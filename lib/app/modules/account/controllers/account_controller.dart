import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';
import 'package:senja_mobile/app/modules/navbar/controllers/navbar_controller.dart';

class AccountController extends GetxController {
  final count = 0.obs;
  final navbarController = Get.find<NavbarController>();
  final api = Get.find<ApiProvider>();
  final storage = Get.find<Storage>();

  // Pakai Rxn untuk reactive user (nullable)
  final Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> logout() async {
    // navbarController.logout();
  }

  Future<void> getUser() async {
    try {
      final result = await api.fetchUser();
      user.value = result;
      print("User loaded: ${user.value?.name}");
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
  // I/flutter (23384): Error fetching user: type 'int' is not a subtype of type 'String
}
