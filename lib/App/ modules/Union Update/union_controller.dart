// lib/App/modules/union/union_controller.dart
import 'package:get/get.dart';
import 'package:myamco/App/data/ModelClass/getUnionListModel.dart';

import 'union_Repostory.dart';

class UnionController extends GetxController {
  final UnionRepository repository;

  UnionController({required this.repository});

  var isLoading = false.obs;
  var unionUpdates = <NotifyDetail>[].obs;
  var filePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUnionUpdates();
  }

  void fetchUnionUpdates() async {
    isLoading.value = true;

    final response = await repository.getUnionUpdates();

    if (response != null && response.success == true) {
      unionUpdates.value = response.data?.notifyDetails ?? [];
      filePath.value = response.data?.filePath ?? ""; // store base path
    } else {
      unionUpdates.clear();
      filePath.value = "";
    }

    isLoading.value = false;
  }
  // union_controller.dart


}
