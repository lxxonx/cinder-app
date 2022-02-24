import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mocozi/app/model/group.dart';
import 'package:mocozi/app/services/remote_services.dart';

class GroupController extends GetxController {
  var isLoading = true.obs;
  var groupList = <Group>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var groups = await RemoteServices.fetchGroups();
      if (groups != null) {
        groupList.value = groups;
      }
    } finally {
      isLoading(false);
    }
  }
}
