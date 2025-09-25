import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../../utils/app_toast.dart';

class AppPermissionHandler {
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }
    if (!status.isGranted) {
      showToast('Permission denied');
    }
    return status.isGranted;
  }

  static Future<bool> requestGalleryPermission() async {
    if (Platform.isAndroid) {
      return true;
    }
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isDenied || storageStatus.isPermanentlyDenied) {
      storageStatus = await Permission.storage.request();
    }
    if (!storageStatus.isGranted) {
      showToast('Storage permission denied');
    }
    return storageStatus.isGranted;
  }

  Future<bool> micPermission() async {
    final PermissionStatus status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    } else if (!status.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status.isGranted) {
        return true;
      } else {
        showToast('Permission Denied!');
        return false;
      }
    } else if (status.isLimited) {
      return true;
    } else if (status.isDenied) {
      showToast('Permission Denied!');
      return false;
    } else {
      return false;
    }
  }
}
