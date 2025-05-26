import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/modules/account/controllers/account_controller.dart';

class PengaturanAkunController extends GetxController {
  final api = Get.find<ApiProvider>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final user = Rxn<User>();
  XFile? pickedImage;

  final picker = ImagePicker();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final argUser = Get.arguments;
    if (argUser != null && argUser is User) {
      setUser(argUser);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setUser(User data) {
    user.value = data;
    nameController.text = data.name ?? '';
    emailController.text = data.email ?? '';
  }

  void pickImage() async {
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      pickedImage = result;
      update(); // Supaya tampilan avatar ikut berubah
    }
  }

  Future<void> updateProfile() async {
    try {
      // Validasi sederhana (optional)
      if (nameController.text.isEmpty || emailController.text.isEmpty) {
        Get.snackbar('Error', 'Nama dan email tidak boleh kosong');
        return;
      }

      final response = await api.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        avatar: pickedImage,
      );

      if (response['status'] == 'sukses') {
        Get.snackbar('Sukses', 'Profil berhasil diperbarui');
        user.value = User.fromJson(response['data']);
        update();
        final accountController = Get.find<AccountController>();
        await accountController.getUser();
      } else {
        Get.snackbar('Gagal', response['pesan'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  @override
  Future<void> refresh() async {
    final accountController = Get.find<AccountController>();
    await accountController.getUser();
  }
}
