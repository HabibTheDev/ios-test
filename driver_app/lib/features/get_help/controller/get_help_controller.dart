import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../shared/services/remote/get_help_service.dart';
import '../../../shared/services/remote/push_notification_service.dart';
import '../../../shared/services/remote/socket_service.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/message_model.dart';

class GetHelpController extends GetxController {
  GetHelpController(this._service, this.vsync);
  final GetHelpService _service;
  final TickerProvider vsync;

  // variables
  final RxBool isLoading = true.obs;
  final RxBool sendMgsLoading = false.obs;
  final RxBool hasMessage = false.obs;

  int currentPage = 1, totalPage = 1, limit = 20;
  final RxList<File> selectedAttachments = <File>[].obs;
  final ScrollController chatScrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final RxBool isListViewFullyScrolled = true.obs;
  final RxBool isListViewFullyScrolledToTop = false.obs;

  late AnimationController scrollButtonAnimationController;
  late Animation<double> scrollButtonAnimation;

  final RxList<Message> messages = <Message>[].obs;

  @override
  void onInit() async {
    super.onInit();
    // Add listener to chatScrollController
    chatScrollController.addListener(onScroll);
    messageController.addListener(typingMessage);
    initScrollButtonAnimation();

    await Future.wait([fetchMessages()]);
    await SocketService.instance.initSocket();
    isLoading(false);
    receiveNewMessageEvent();
  }

  Future<void> connectSocket() async {}

  @override
  void dispose() {
    chatScrollController.dispose();
    messageController.dispose();
    scrollButtonAnimationController.dispose();
    super.dispose();
  }

  //UI functions::::::::::::::::::::::::::::::::::::
  void typingMessage() {
    if (messageController.text.isNotEmpty) {
      hasMessage(true);
    } else {
      hasMessage(false);
    }
  }

  void initScrollButtonAnimation() {
    scrollButtonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600), //center button animation duration
      vsync: vsync,
    );
    CurvedAnimation curve = CurvedAnimation(
      parent: scrollButtonAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    scrollButtonAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
    Future.delayed(const Duration(seconds: 1), () => scrollButtonAnimationController.forward());
  }

  // User interaction
  scrollDown() {
    chatScrollController.animateTo(chatScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
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

  // API functions:::::::::::::::::::::::::::::::::::

  // Receive notification socket event
  void receiveNewMessageEvent() async {
    final IO.Socket socket = SocketService.instance.socket!;

    socket.on(ApiEndpoint.userNewMessageEvent, (data) async {
      debugPrint('New message received::::::::::::::: $data');
      final mapData = data as Map<String, dynamic>;
      final Message message = Message.fromJson(mapData);
      messages.insert(0, message);
      FirebasePushApiService().showLocalNotification(
        id: data['id'],
        title: 'You have new message',
        body: message.message ?? 'N/A',
        payload: jsonEncode(data),
      );
    });
  }

  // Fetch messages
  Future<void> fetchMessages() async {
    if (currentPage <= totalPage) {
      final notificationModel = await _service.getMessages(page: currentPage, limit: limit);
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
    if (messageController.text.isEmpty) {
      return;
    }
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
      message: message,
      attachments: [],
      toAdmin: true,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
    messages.insert(0, model);
    messageController.clear();
    selectedAttachments.clear();

    final body = {'message': message};

    final result = await _service.sendMessage(body: body, filePaths: filePaths);
    if (result != null) {
      messages.first = result.data!.messages!.first;
    } else {
      messages.removeAt(0);
    }

    sendMgsLoading(false);
    scrollDown();
  }

  // Pick multiple files
  Future<void> pickMultipleFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'docx', 'doc', 'txt'],
      );

      if (result != null) {
        final files = result.paths.map((path) => File(path!)).toList();
        selectedAttachments.clear();
        selectedAttachments.addAll(files);
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  void clearAttachments() {
    selectedAttachments.clear();
  }
}
