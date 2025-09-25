import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../repository/local/media_repo.dart';
import '../../utils/app_toast.dart';
import 'permission_handler.dart';

class MediaService extends MediaRepo {
  @override
  Future<File?> getImageFromCamera() async {
    final bool permission = await AppPermissionHandler.requestCameraPermission();
    if (!permission) {
      return null;
    }
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 100);
      if (image != null) {
        final file = File(image.path);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      showToast('Something went wrong');
      debugPrint('Error getting image: $e');
      return null;
    }
  }

  @override
  Future<File?> getImageFromGallery({int? imageQuality, double? maxHeight}) async {
    final bool permission = await AppPermissionHandler.requestGalleryPermission();
    if (!permission) {
      return null;
    }
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality ?? 80,
        maxHeight: maxHeight ?? 500.0,
      );
      if (image != null) {
        final file = File(image.path);
        return file;
      } else {
        return null;
      }
    } on PlatformException {
      showToast('This image format is not supported on this device! try different one.');
      return null;
    } catch (e) {
      showToast('Something went wrong');
      debugPrint('Error picking photo: $e');
      return null;
    }
  }

  @override
  Future<File?> getFile({int? imageQuality, double? maxHeight, List<String>? allowedExtensions}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['jpg', 'png', 'pdf', 'docx', 'doc', 'txt', 'xls', 'gif'],
      );
      if (result != null) {
        final file = File(result.files.single.path!);
        return file;
      } else {
        return null;
      }
    } on PlatformException {
      showToast('This format is not supported on this device! try different one.');
      return null;
    } catch (e) {
      showToast('Something went wrong');
      debugPrint('Error picking photo: $e');
      return null;
    }
  }

  @override
  Future<List<File>?> pickMultipleFile({List<String>? allowedExtensions}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['jpg', 'png', 'pdf', 'docx', 'doc', 'txt', 'xls', 'gif'],
      );

      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      showToast(e.toString());
      debugPrint('Error picking Multiple File: $e');
    }
    return null;
  }

  @override
  Future<File?> saveFileToAppDirectory({required File file}) async {
    try {
      // Save file to the application documents directory
      final Directory directory = await getApplicationDocumentsDirectory();
      final String fileName = '${DateTime.now().microsecondsSinceEpoch}-${file.path.split('/').last}';
      final File savedFile = await file.copy('${directory.path}/$fileName');
      return savedFile;
    } catch (_) {}
    return null;
  }
}
