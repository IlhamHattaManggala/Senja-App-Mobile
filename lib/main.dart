import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:senja_mobile/app/modules/navbar/controllers/navbar_controller.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Fungsi untuk menangani pesan saat aplikasi di background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  // Tampilkan notifikasi lokal di background
  if (message.notification != null) {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'senja_app', // ID channel
      'SenjaApp', // Nama channel
      channelDescription: 'Default channel for notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false, // Tidak ada suara
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0, // ID notifikasi
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Inisialisasi Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Inisialisasi notifikasi lokal
  await _initializeLocalNotifications();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Minta izin notifikasi
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Izin diterima');
  } else {
    print('User menolak izin notifikasi');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Menangani notifikasi saat aplikasi aktif
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      // Tampilkan notifikasi lokal di foreground
      try {
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'senja_app', // ID channel
          'SenjaApp', // Nama channel
          channelDescription: 'Default channel for notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: false, // Tidak ada suara
        );

        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(
          0, // ID notifikasi
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
        );
      } catch (e) {
        print('$e');
      }
    }
  });

  // Ambil token FCM
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
    final box = GetStorage();
    box.write("fcm_token", token);
  });

  // Tangani aplikasi saat dibuka dari notifikasi
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final controller = Get.find<NavbarController>();
    controller.changeIndex(2); // Navigasi ke halaman tertentu
  });

  // Subskripsi ke topik
  FirebaseMessaging.instance.subscribeToTopic("user_baru");

  // Inisialisasi Intl untuk format tanggal
  await initializeDateFormatting('id_ID', null);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SENJA APP",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

// Fungsi untuk inisialisasi notifikasi lokal
Future<void> _initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Membuat channel notifikasi di Android 8.0 dan lebih tinggi
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'senja_app', // ID channel
    'SenjaApp', // Nama channel
    description: 'Channel untuk notifikasi aplikasi Senja',
    importance: Importance.high,
  );

  // Daftarkan channel notifikasi
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
