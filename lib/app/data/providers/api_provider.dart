import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:senja_mobile/app/config/config_url.dart';
import 'package:senja_mobile/app/data/models/artikel.dart';
import 'package:senja_mobile/app/data/models/log_activity.dart';
import 'package:senja_mobile/app/data/models/notifikasi.dart';
import 'package:senja_mobile/app/data/models/seni_lainnya.dart';
import 'package:senja_mobile/app/data/models/tari.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class ApiProvider {
  final storage = Get.find<Storage>();

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ConfigUrl.loginUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'senjawebdev-12',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['data'];
      await storage.saveToken(data['token']);
      await storage.saveApiKey('senjawebdev-12');

      // Gabungkan user dan token ke dalam satu map, lalu parse ke model
      final user = User.fromJson({
        ...data['user'],
        'token': data['token'],
      });

      return user;
    } else {
      final body = json.decode(response.body);

      // Cetak pesan error dari backend (jika ada)
      final message = body['pesan'] ?? body['message'] ?? 'Login gagal';

      // Tampilkan juga ke UI jika kamu ingin tangkap exception-nya nanti
      throw Exception(message);
    }
  }

  Future<User?> loginGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Step 1: Login Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final fb_auth.OAuthCredential credential =
          fb_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 2: Login Firebase
      final fb_auth.UserCredential userCredential =
          await fb_auth.FirebaseAuth.instance.signInWithCredential(credential);

      final fb_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        String? idToken = await firebaseUser.getIdToken();

        Map<String, dynamic> requestBody = {
          'idToken': idToken,
        };

        // Step 3: Kirim data ke backend
        final Uri url = Uri.parse(ConfigUrl.loginGoogleUrl);

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'senjawebdev-12'
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final body = json.decode(response.body);
          final data = body['data'];

          // Simpan token dan api key
          await storage.saveToken(data['token']);
          await storage.saveApiKey('senjawebdev-12');

          // Parse ke User model kamu
          final user = User.fromJson({
            ...data['user'],
            'token': data['token'], // jika diperlukan
          });

          return user;
        } else {
          return null;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse(ConfigUrl.registerUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'senjawebdev-12'
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['data'];
      await storage.saveToken(data['token']);
      await storage.saveApiKey('senjawebdev-12');

      // Gabungkan user dan token ke dalam satu map, lalu parse ke model
      final user = User.fromJson({
        ...data['user'],
        'token': data['token'],
      });

      return user;
    } else {
      // gagal
      return null;
    }
  }

  Future<User?> registerGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Step 1: Login Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final fb_auth.OAuthCredential credential =
          fb_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 2: Login Firebase
      final fb_auth.UserCredential userCredential =
          await fb_auth.FirebaseAuth.instance.signInWithCredential(credential);

      final fb_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        String? idToken = await firebaseUser.getIdToken();

        Map<String, dynamic> requestBody = {
          'idToken': idToken,
        };

        // Step 3: Kirim data ke backend
        final Uri url = Uri.parse(ConfigUrl.registerGoogleUrl);

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'senjawebdev-12',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201) {
          final body = json.decode(response.body);
          final data = body['data'];

          // Simpan token dan api key
          await storage.saveToken(data['token']);
          await storage.saveApiKey('senjawebdev-12');

          // Parse ke User model
          final user = User.fromJson({
            ...data['user'],
            'token': data['token'], // jika diperlukan
          });

          return user;
        } else {
          return null;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> verifyEmail(String pin) async {
    final token = storage.getToken();
    final api = storage.getApiKey();

    final response = await http.post(
      Uri.parse(ConfigUrl.verifyEmailUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-api-key': '$api'
      },
      body: jsonEncode({'otp': pin}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          jsonDecode(response.body)['message'] ?? 'Verifikasi gagal');
    }
  }

  Future<Map<String, dynamic>> fetchBeranda() async {
    final token = storage.getToken();
    final api = storage.getApiKey();

    final response = await http.get(
      Uri.parse(ConfigUrl.berandaUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'x-api-key': '$api'
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final tariList = body['tari'] as List;
      final seniList = body['seni_lainnya'] as List;

      List<Tari> listTari = tariList.map((e) => Tari.fromJson(e)).toList();
      List<SeniLainnya> listSeniLainnya =
          seniList.map((e) => SeniLainnya.fromJson(e)).toList();

      return {
        'tari': listTari,
        'seni_lainnya': listSeniLainnya,
      };
    } else {
      throw Exception('Failed to load beranda');
    }
  }

  Future<Map<String, dynamic>> fetchArtikel(int page) async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final response = await http.get(
      Uri.parse('${ConfigUrl.beritaUrl}?page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-api-key': '$api',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      final int totalPages = jsonData['total_pages'];
      final int currentPage = jsonData['current_page'];

      final artikelList = data.map((item) {
        return Artikel.fromJson(item);
      }).toList();

      return {
        'data': artikelList,
        'total_pages': totalPages,
        'current_page': currentPage,
      };
    } else {
      throw Exception('Gagal memuat data artikel');
    }
  }

  Future<bool> lupaPassword(String email) async {
    final url = Uri.parse(ConfigUrl.lupaPasswordUrl);

    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-api-key': 'senjawebdev-12',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          await storage.saveApiKey('senjawebdev-12');
          return true;
        } else {
          throw data['message'] ?? 'Gagal mengirim permintaan reset password.';
        }
      } else {
        throw 'Gagal: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifikasiPin(String pin) async {
    final api = storage.getApiKey();
    final response = await http.post(
      Uri.parse(ConfigUrl.verifikasiPinUrl),
      headers: {'Content-Type': 'application/json', 'x-api-key': '$api'},
      body: jsonEncode({'otp': pin}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          jsonDecode(response.body)['message'] ?? 'Verifikasi gagal');
    }
  }

  Future<bool> resetPassword(String password, String pin) async {
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.resetPasswordUrl);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-api-key': '$api'
      },
      body: jsonEncode({'otp': pin, 'password': password}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Gagal mengubah password');
    }
  }

  Future<List<Notifikasi>> fetchNotifikasi() async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.notifikasiUrl);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': '$api',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['notifikasi'];

      return data.map((item) => Notifikasi.fromJson(item)).toList();
    } else {
      throw Exception("Gagal mengambil data notifikasi");
    }
  }

  Future<void> markNotifAsRead(String id) async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse("${ConfigUrl.notifikasiUrl}/$id/read");

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': '$api'
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal menandai sebagai dibaca");
    }
  }

  Future<void> deleteNotifFromBackend(String id) async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse("${ConfigUrl.notifikasiUrl}/$id");

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': '$api',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus notifikasi");
    }
  }

  Future<List<LogActivity>> fetchLogActivity() async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.logActivityUrl);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': '$api',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      final List data = body['data'];
      return data.map((json) => LogActivity.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data log aktivitas");
    }
  }

  Future<User?> fetchUser() async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.profileUrl);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': '$api',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      return User.fromJson(body['data']);
    } else {
      throw Exception("Gagal mengambil data user");
    }
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required String name,
    required String email,
    String? password,
    XFile? avatar,
  }) async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final uri = Uri.parse(ConfigUrl.UpdateProfileUrl);

    final request = http.MultipartRequest('PUT', uri)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
        'x-api-key': '$api',
      })
      ..fields['name'] = name
      ..fields['email'] = email;

    if (password != null && password.isNotEmpty) {
      request.fields['password'] = password;
    }

    if (avatar != null) {
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<bool> kirimHasilLatihan({
    required String tariName,
    required String gerakanName,
    required String date,
    required double score,
  }) async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.addRiwayatLatihan);

    final data = {
      'date': date,
      'tari_name': tariName,
      'gerakan_name': gerakanName,
      'score': score.toStringAsFixed(2),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'x-api-key': '$api',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchRiwayat() async {
    final token = storage.getToken();
    final api = storage.getApiKey();
    final url = Uri.parse(ConfigUrl.riwayatUrl); // Ganti sesuai domainmu

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'x-api-key': '$api',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json['data'] as List;
        // Ubah ke List<Map<String, dynamic>> jika diperlukan
        return data.cast<Map<String, dynamic>>();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
