import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../shared/utils/app_toast.dart';

class SignAgreementController extends GetxController {
  final RxBool signatureLoading = false.obs;

  final RxBool agreeAgreement = false.obs;
  final RxBool carTracking = false.obs;
  final RxBool termsAndPrivacy = false.obs;
  final Rxn<File> sign = Rxn();

  Future<void> saveSignature(
      {required SignatureController signatureController}) async {
    signatureLoading(true);

    final signatureBytes = await signatureController.toPngBytes();
    if (signatureBytes != null) {
      try {
        final directory = await getTemporaryDirectory();
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final file = File('${directory.path}/$fileName.png');
        await file.writeAsBytes(signatureBytes);
        sign.value = file;
        Get.back();
      } catch (e) {
        showToast('Error saving signature');
      }
    } else {
      showToast('Error generating signature');
    }
    signatureLoading(false);
  }
}
