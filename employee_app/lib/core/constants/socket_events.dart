class SocketEvents {
  SocketEvents._();

  // Socket events key
  static const String getNotificationEvent = 'send-notification';
  static const String userNewMessageEvent = 'user-new-message';
  static const String incompleteTaskEmitEvent = 'incomplete-task';
  static const String incompleteTaskEvent = 'get-incomplete-task';
  static const String typingEvent = 'typing';
  static const String stopTypingEvent = 'stop-typing';
}
