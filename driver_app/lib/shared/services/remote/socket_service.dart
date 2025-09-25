import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../flavor_config.dart';
import '../../repository/local/local_storage_repo.dart';
import '../service_locator.dart';

class SocketService {
  SocketService._privateConstructor();
  static final SocketService instance = SocketService._privateConstructor();
  factory SocketService() => instance;

  IO.Socket? socket;

  // Connect Socket
  Future<void> initSocket() async {
    if (socket == null) {
      try {
        final String? accessToken = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();
        if (accessToken == null) return;

        socket = IO.io(
          AppFlavor.socketBaseUrl,
          IO.OptionBuilder().setTransports(['websocket', 'polling']) // Specify transport methods
              .setAuth({'token': accessToken}) // Pass token via auth
              .setQuery({'isInMobileApp': true}) // Add query parameter
              .build(),
        );
        socket?.connect();

        socket?.onConnect((_) => debugPrint('Socket connected:::::::::::::: (${socket?.id})'));
        socket?.onDisconnect((_) => debugPrint('Socket disconnected:::::::::::::: (${socket?.id})'));
        socket?.onConnectError((handler) => debugPrint('Socket connection error:::::::::::::: $handler'));
      } catch (e) {
        debugPrint('Socket connection Error: $e');
      }
    }
  }

  // Disconnect and Dispose Socket
  void disconnectSocket() {
    if (socket != null) {
      socket?.disconnect();
      socket?.close();
      socket = null;
      debugPrint('Socket disconnected successfully');
    }
  }
}
