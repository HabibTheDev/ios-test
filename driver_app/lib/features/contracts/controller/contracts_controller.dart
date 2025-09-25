import 'package:get/get.dart';

class ContractsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<String> selectedCarFilterList = <String>['Clear all'].obs;

  void addCarFilterItem(String value) {
    if (selectedCarFilterList.length == 1) {
      selectedCarFilterList.insert(0, value);
    } else {
      selectedCarFilterList[0] = value;
    }
  }

  void removeCarFilterItem(String value) {
    selectedCarFilterList.remove(value);
  }

  void clearCarFilter() {
    selectedCarFilterList.clear();
    selectedCarFilterList.add('Clear all');
  }
}
