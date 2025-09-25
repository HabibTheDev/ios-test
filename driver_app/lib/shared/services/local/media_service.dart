import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import '../../repository/local/media_repo.dart';
import '../../utils/app_toast.dart';
import 'permission_handler.dart';

class MediaService extends MediaRepo {
  @override
  Future<File?> getImageFromCamera() async {
    File? file;
    final bool permission = await AppPermissionHandler.requestCameraPermission();
    if (!permission) {
      return null;
    }
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        file = File(image.path);
      } else {
        return null;
      }
    } catch (e) {
      showToast('Something went wrong');
      debugPrint('Error getting image: $e');
      return null;
    }
    return file;
  }

  @override
  Future<File?> getImageFromGallery({int? imageQuality, double? maxHeight}) async {
    File? file;
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
        file = File(image.path);
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
    return file;
  }

  @override
  Future<File?> getFile({int? imageQuality, double? maxHeight, List<String>? allowedExtensions}) async {
    File? file;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['jpg', 'pdf', 'png', 'jpeg'],
      );
      if (result != null) {
        file = File(result.files.single.path!);
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
    return file;
  }
}
