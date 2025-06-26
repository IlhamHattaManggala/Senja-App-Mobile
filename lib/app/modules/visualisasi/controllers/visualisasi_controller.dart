import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisualisasiController extends GetxController {
  late final WebViewController webViewController;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onPageFinished: (url) {
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://senjaapp.streamlit.app/"));
  }
}
