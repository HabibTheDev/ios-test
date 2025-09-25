import '../../../features/get_help/model/message_model.dart';

abstract class GetHelpRepo {
  Future<MessageModel?> getMessages({required int page, required int limit});
  Future<MessageModel?> sendMessage({List<String>? filePaths, Map<String, dynamic>? body});
}
