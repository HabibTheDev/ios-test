import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../core/constants/socket_events.dart';
import '../../../shared/repository/local/media_repo.dart';
import '../../../shared/repository/remote/inbox_repo.dart';
import '../../../shared/services/remote/push_notification_service.dart';
import '../../../shared/services/remote/socket_service.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../drawer/controller/drawer_controller.dart';
import '../model/message_model.dart';

class InboxController extends GetxController {
  InboxController({required this.inboxRepo});
  final InboxRepo inboxRepo;
  final AppDrawerController appDrawerController = Get.find();

  // variables
  final RxBool isLoading = true.obs;
  final RxBool sendMgsLoading = false.obs;
  final RxBool hasMessage = false.obs;

  int currentPage = 1, totalPage = 1, limit = 20;
  final RxList<File> selectedAttachments = <File>[].obs;

  // Scrolling related variables
  late AnimationController scrollButtonAnimationController;
  late Animation<double> scrollButtonAnimation;
  final RxBool isListViewFullyScrolled = true.obs;
  final RxBool isListViewFullyScrolledToTop = false.obs;

  // Message variables
  final chatScrollController = ScrollController();
  final messageController = TextEditingController();

  final RxList<Message> messages = <Message>[].obs;
  Timer? _stopTypingTimer;
  bool isTyping = false;

  // Socket
  // late IO.Socket? socket;

  @override
  void onInit() async {
    // Add listener to chatScrollController
    chatScrollController.addListener(onScroll);
    messageController.addListener(hasMessageListener);
    messageController.addListener(monitorTypingListener);

    await fetchMessages();
    isLoading(false);

    super.onInit();
  }

  @override
  void dispose() {
    chatScrollController.dispose();
    messageController.removeListener(hasMessageListener);
    messageController.removeListener(monitorTypingListener);
    messageController.dispose();

    scrollButtonAnimationController.dispose();
    _stopTypingTimer?.cancel();
    super.dispose();
  }

  // Monitor text changes to determine typing events
  void monitorTypingListener() {
    if (!isTyping) {
      isTyping = true;
      onStartTyping();
    }
    // Reset the stop-typing timer
    _stopTypingTimer?.cancel();
    _stopTypingTimer = Timer(const Duration(seconds: 2), () {
      isTyping = false;
      onStopTyping();
    });
  }

  void onStartTyping() {
    debugPrint("User started typing");
    SocketService.instance.socket?.emit(SocketEvents.typingEvent);
  }

  void onStopTyping() {
    debugPrint("User stopped typing");
    SocketService.instance.socket?.emit(SocketEvents.stopTypingEvent);
  }

  void hasMessageListener() {
    if (messageController.text.isNotEmpty) {
      hasMessage(true);
    } else if (selectedAttachments.isNotEmpty) {
      hasMessage(true);
    } else {
      hasMessage(false);
    }
  }

  Future<void> initScrollButtonAnimation({required TickerProvider vsync}) async {
    scrollButtonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600), //center button animation duration
      vsync: vsync,
    );
    CurvedAnimation curve = CurvedAnimation(
      parent: scrollButtonAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    scrollButtonAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
    await Future.delayed(const Duration(seconds: 1), () => scrollButtonAnimationController.forward());
  }

  // User interaction
  void scrollDown() {
    chatScrollController.animateTo(
      chatScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> onScroll() async {
    // scrolled down to the last bottom. here have to hide animation.
    if (chatScrollController.position.pixels == chatScrollController.position.minScrollExtent) {
      isListViewFullyScrolled(true);
      scrollButtonAnimationController.reset();
      debugPrint('Fully scrolled to bottom');
    }
    // scrolled up to the top most. here have to load more data.
    else if (chatScrollController.position.pixels == chatScrollController.position.maxScrollExtent) {
      isListViewFullyScrolledToTop(true);
      await fetchMessages();
      debugPrint('Fully scrolled to top');
    }
    // when scrolling.
    else {
      // to hide loader when scrolling.
      isListViewFullyScrolled(false);
      isListViewFullyScrolledToTop(false);

      // to view "Scroll Bottom" widget when scroll up.
      if (chatScrollController.position.minScrollExtent + chatScrollController.position.pixels > 500) {
        scrollButtonAnimationController.forward();
      }
    }
  }

  // Receive notification socket event
  void updateNewMessageBySocket({required dynamic data}) {
    try {
      debugPrint('New message received::::::::::::::: $data');
      final mapData = data as Map<String, dynamic>;
      final Message message = Message.fromJson(mapData);
      messages.insert(0, message);
      messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      if (appDrawerController.selectedItem.value != AppList.drawerItemList[1]) {
        FirebasePushApiService().showLocalNotification(
          id: data['id'],
          title: 'You have new ${message.message == null ? 'attachment' : 'message'}',
          body: message.message ?? '',
          payload: jsonEncode(data),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Fetch messages
  Future<void> fetchMessages() async {
    if (currentPage <= totalPage) {
      final notificationModel = await inboxRepo.getMessages(page: currentPage, limit: limit);
      if (notificationModel != null) {
        final messageList = notificationModel.data?.messages ?? [];

        messageList.reversed.toList();
        messages.insertAll(messages.length, messageList);
        messageList.clear();
        currentPage++;
        totalPage = notificationModel.meta?.total ?? 1;
      }
      debugPrint('Total Message: ${messages.length}');
    }
    isListViewFullyScrolledToTop(false);
  }

  // Send message
  Future<void> sendMessage() async {
    if (hasMessage.value == false) return;

    if (sendMgsLoading.value) {
      showToast('Another process running');
      return;
    }

    sendMgsLoading(true);
    final message = messageController.text.trim();
    List<String>? filePaths = [];

    if (selectedAttachments.isNotEmpty) {
      for (File file in selectedAttachments) {
        filePaths.add(file.path);
      }
    }

    final Message model = Message(
      id: null,
      conversationId: null,
      message: message.isNotEmpty ? message : null,
      attachments: [],
      toAdmin: true,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
    messages.insert(0, model);
    messageController.clear();
    selectedAttachments.clear();

    final body = {'message': message};

    final result = await inboxRepo.sendMessage(body: body, filePaths: filePaths);
    if (result != null) {
      messages.first = result.data!.messages!.first;
    } else {
      messages.removeAt(0);
    }

    messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    sendMgsLoading(false);
    scrollDown();
    hasMessageListener();
  }

  // Pick files
  Future<void> pickFiles() async {
    final List<File>? files = await ServiceLocator.get<MediaRepo>().pickMultipleFile();
    if (files != null) {
      selectedAttachments.clear();
      selectedAttachments.addAll(files);
    }
    hasMessageListener();
  }

  void clearAttachments() {
    selectedAttachments.clear();
    hasMessageListener();
  }
}
