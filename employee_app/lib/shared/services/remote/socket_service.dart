// ignore_for_file: library_prefixes
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/constants/socket_events.dart';
import '../../../features/inbox/controller/inbox_controller.dart';
import '../../../features/my_task/controller/my_task_controller.dart';
import '../../../features/notification/controller/notification_controller.dart';
import '../../../flavor_config.dart';
import '../../repository/local/local_storage_repo.dart';
import '../service_locator.dart';

class SocketService {
  SocketService._privateConstructor();
  static final SocketService instance = SocketService._privateConstructor();
  factory SocketService() => instance;

  IO.Socket? socket;
  Timer? _timer;

  // Connect Socket
  Future<IO.Socket?> initSocket() async {
    if (socket != null && socket?.connected == true) return socket;

    try {
      // Disconnect socket first
      disconnectSocket();

      final String? accessToken = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();
      if (accessToken == null) {
        debugPrint('👉Socket initialization failed: No access token available');
        return null;
      }

      socket = IO.io(
        AppFlavor.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setAuth({'token': accessToken})
            .setQuery({'isInMobileApp': true})
            .enableAutoConnect()
            .build(),
      );

      _setupSocketEventHandlers();
      socket?.connect();

      return socket;
    } catch (e) {
      debugPrint('👉Socket connection Error: $e');
      return null;
    }
  }

  void _setupSocketEventHandlers() {
    socket?.onConnect((_) {
      debugPrint('👉Socket connected:::::::::::::: (${socket?.id})');
      socket?.clearListeners();
      _handleSocketEvents();
      _startPeriodicEventEmitTask();
    });

    socket?.onDisconnect((_) {
      debugPrint('👉Socket disconnected:::::::::::::: (${socket?.id})');
      _cancelTimer();
    });

    socket?.onConnectError((handler) => debugPrint('👉Socket connection error: $handler'));
    socket?.onReconnect((_) {
      debugPrint('👉Socket reconnected:::::::::::::: (${socket?.id})');
      socket?.clearListeners();
      _handleSocketEvents();
      _startPeriodicEventEmitTask();
    });
    socket?.onReconnectAttempt((_) => debugPrint('👉Socket reconnecting...'));
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // Disconnect and dispose socket
  void disconnectSocket() {
    _cancelTimer();
    socket?.clearListeners();
    socket?.disconnect();
    socket?.dispose();
    socket = null;
    debugPrint('👉Socket disconnected successfully');
  }

  void _handleSocketEvents() {
    final NotificationController notificationController = Get.find();
    final MyTaskController myTaskController = Get.find();
    final InboxController inboxController = Get.find();

    socket?.on(SocketEvents.getNotificationEvent, (data) {
      notificationController.updateNotificationBySocket(data: data);
      myTaskController.refreshMyTask();
    });

    socket?.on(SocketEvents.incompleteTaskEvent, (data) {
      myTaskController.showIncompleteTaskWarningDialog(data: data);
    });

    socket?.on(SocketEvents.userNewMessageEvent, (data) {
      inboxController.updateNewMessageBySocket(data: data);
    });
  }

  // Emit incomplete task event periodically
  void _startPeriodicEventEmitTask() {
    _cancelTimer();

    // 10 min for prod & 1 min for dev
    final int intervalSeconds = AppFlavor.env == Env.prod ? 600 : 600;

    // Emit initial event
    socket?.emit(SocketEvents.incompleteTaskEmitEvent);
    // Start periodic timer
    _timer = Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) {
      if (socket?.connected == false) {
        _cancelTimer();
        return;
      }
      socket?.emit(SocketEvents.incompleteTaskEmitEvent);
      debugPrint('👉emitted: ${SocketEvents.incompleteTaskEmitEvent}');
    });
  }

  // Handle token refresh
  Future<void> handleTokenRefresh() async {
    debugPrint('👉Handling socket token refresh...');
    // Disconnect current socket
    disconnectSocket();

    // Wait for a short duration to ensure clean disconnect
    await Future.delayed(const Duration(seconds: 2));

    // Reinitialize socket with new token
    final socket = await initSocket();
    if (socket != null) {
      debugPrint('👉Socket reconnected with new token');
    } else {
      debugPrint('👉Failed to reconnect socket with new token');
    }
  }
}
