import '../../../features/inbox/model/message_model.dart';

abstract class InboxRepo {
  Future<MessageModel?> getMessages({required int page, required int limit});
  Future<MessageModel?> sendMessage({List<String>? filePaths, Map<String, dynamic>? body});
}
