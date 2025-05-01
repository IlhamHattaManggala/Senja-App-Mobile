import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Laporan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF6B6211), // Olive green color
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          // Cream background
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chart Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFFD8CEA6), width: 1),
                ),
                color: const Color(0xFFF8F3E0),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Skor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: _buildBarChart(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Riwayat Latihan Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          'Riwayat Latihan ${controller.tariName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A),
                          ),
                        )),
                    const Text(
                      'Skor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ],
                ),
              ),

              // Table of training history
              _buildTrainingHistoryTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return ElevatedButton(
      onPressed: () {
        controller.exportData();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE9DFBE),
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: const [
          Text('Ekspor'),
          SizedBox(width: 4),
          Icon(Icons.chevron_right, size: 18),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    // Check if data exists, otherwise show placeholder
    if (controller.scoreData.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada data latihan tersedia',
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 14,
          ),
        ),
      );
    }

    final List<BarChartGroupData> barGroups = [
      _makeBarGroup(0, controller.getScoreForDay(0), "Sen"),
      _makeBarGroup(1, controller.getScoreForDay(1), "Sel"),
      _makeBarGroup(2, controller.getScoreForDay(2), "Rab"),
      _makeBarGroup(3, controller.getScoreForDay(3), "Kam"),
      _makeBarGroup(4, controller.getScoreForDay(4), "Jum"),
      _makeBarGroup(5, controller.getScoreForDay(5), "Sab"),
      _makeBarGroup(6, controller.getScoreForDay(6), "Min"),
      _makeBarGroup(7, controller.getScoreForDay(7), "Sat"),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.blueGrey.withOpacity(0.8),
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  switch (value.toInt()) {
                    case 0:
                      text = 'Sen';
                      break;
                    case 1:
                      text = 'Sel';
                      break;
                    case 2:
                      text = 'Rab';
                      break;
                    case 3:
                      text = 'Kam';
                      break;
                    case 4:
                      text = 'Jum';
                      break;
                    case 5:
                      text = 'Sab';
                      break;
                    case 6:
                      text = 'Min';
                      break;
                    case 7:
                      text = 'Sat';
                      break;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Color(0xFF4A4A4A),
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (value % 20 == 0) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Color(0xFF4A4A4A),
                        fontSize: 12,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 20,
            checkToShowHorizontalLine: (value) => value % 20 == 0,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xFFD8CEA6),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: barGroups,
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, String label) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFF6B6211),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingHistoryTable() {
    // Show placeholder message if no data
    if (controller.historiData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'Belum ada riwayat latihan tersedia',
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Table(
      border: TableBorder.all(
        color: const Color(0xFFD8CEA6),
        width: 1,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2.5), // Tanggal
        1: FlexColumnWidth(2), // Gerakan
        2: FlexColumnWidth(1.5), // Skor
      },
      children: [
        // Table Header
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFE9DFBE)),
          children: [
            _buildTableHeader('Tanggal'),
            _buildTableHeader('Gerakan'),
            _buildTableHeader('Skor'),
          ],
        ),
        // Table Rows - Dynamic Data
        ...controller.historiData.map((item) => _buildTableRow(
            item['date'] ?? '', item['gerakan'] ?? '', item['score'] ?? '')),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0xFF4A4A4A),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTableRow(String date, String gerakanName, String score) {
    return TableRow(
      children: [
        _buildTableCell(date),
        _buildTableCell(gerakanName),
        _buildTableCell(score),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF4A4A4A),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
