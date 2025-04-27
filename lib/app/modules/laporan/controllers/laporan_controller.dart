import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanController extends GetxController {
  // Observable variables
  final tariName = 'Default'.obs;
  final historiData = <Map<String, dynamic>>[].obs;
  final scoreData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Get arguments if available, otherwise use defaults
    final args = Get.arguments;
    if (args != null) {
      if (args['tariName'] != null) {
        tariName.value = args['tariName'];
      }
    }

    // Initialize with placeholder data if none exists
    loadData();
  }

  void loadData() {
    try {
      // Attempt to load real data from your data source
      // If this fails or returns null, we'll use the default data below

      // If no real data available, use placeholder data
      if (scoreData.isEmpty) {
        scoreData.value = [
          {'day': 'Sen', 'score': 50},
          {'day': 'Sel', 'score': 78},
          {'day': 'Rab', 'score': 58},
          {'day': 'Kam', 'score': 82},
          {'day': 'Jum', 'score': 65},
          {'day': 'Sab', 'score': 85},
          {'day': 'Min', 'score': 70},
          {'day': 'Sat', 'score': 92},
        ];
      }

      // Populate history data with placeholder data if empty
      if (historiData.isEmpty) {
        historiData.value = [
          {
            'date': '1 Jan 2023',
            'gerakan': 'Gerakan 1',
            'score': '80',
            'ov': '70'
          },
          {
            'date': '2 Jan 2023',
            'gerakan': 'Gerakan 1',
            'score': '75',
            'ov': '80'
          },
          {
            'date': '3 Jan 2023',
            'gerakan': 'Gerakan 1',
            'score': '90',
            'ov': '95'
          },
          {
            'date': '4 Jan 2023',
            'gerakan': 'Gerakan 1',
            'score': '65',
            'ov': '70'
          },
          {
            'date': '5 Jan 2023',
            'gerakan': 'Gerakan 1',
            'score': '60',
            'ov': '65'
          },
        ];
      }
    } catch (e) {
      // Handle any exceptions by ensuring we have default data
      print('Error loading data: $e');
      scoreData.value = [
        {'day': 'Sen', 'score': 50},
        {'day': 'Sel', 'score': 78},
        {'day': 'Rab', 'score': 58},
        {'day': 'Kam', 'score': 82},
        {'day': 'Jum', 'score': 65},
        {'day': 'Sab', 'score': 85},
        {'day': 'Min', 'score': 70},
        {'day': 'Sat', 'score': 92},
      ];

      historiData.value = [
        {
          'date': '1 Jan 2023',
          'gerakan': 'Gerakan 1',
          'score': '80',
          'ov': '70'
        },
        {
          'date': '2 Jan 2023',
          'gerakan': 'Gerakan 1',
          'score': '75',
          'ov': '80'
        },
        {
          'date': '3 Jan 2023',
          'gerakan': 'Gerakan 1',
          'score': '90',
          'ov': '95'
        },
        {
          'date': '4 Jan 2023',
          'gerakan': 'Gerakan 1',
          'score': '65',
          'ov': '70'
        },
        {
          'date': '5 Jan 2023',
          'gerakan': 'Gerakan 1',
          'score': '60',
          'ov': '65'
        },
      ];
    }
  }

  void exportData() {
    if (scoreData.isEmpty) {
      Get.snackbar(
        'Info',
        'Tidak ada data untuk diekspor',
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Your existing export code
      Get.snackbar(
        'Info',
        'Data berhasil diekspor',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to get score for specific day for chart
  double getScoreForDay(int dayIndex) {
    try {
      if (scoreData.isNotEmpty && dayIndex < scoreData.length) {
        return scoreData[dayIndex]['score'].toDouble();
      }
    } catch (e) {
      print('Error getting score for day $dayIndex: $e');
    }
    return 0.0; // Default value if data not available
  }
}
