import 'dart:io';

abstract class MediaRepo {
  Future<File?> getImageFromCamera();
  Future<File?> getImageFromGallery({int? imageQuality, double? maxHeight});
  Future<File?> getFile({int? imageQuality, double? maxHeight, List<String>? allowedExtensions});
  Future<List<File>?> pickMultipleFile({List<String>? allowedExtensions});
  Future<File?> saveFileToAppDirectory({required File file});
}
