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
        title: Obx(() => Text('Laporan: ${controller.tariName.value}')),
        centerTitle: true,
        backgroundColor: PalleteColor.green550,
        foregroundColor: PalleteColor.green50,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const SizedBox(height: 16),

            // Dropdown pilih jenis chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: PalleteColor.green50,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: PalleteColor.green550.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedChartType.value,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.blue),
                        isExpanded: true,
                        dropdownColor: PalleteColor.green50,
                        elevation: 8,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'bar', child: Text('Bar Chart')),
                          DropdownMenuItem(
                              value: 'line', child: Text('Line Chart')),
                          DropdownMenuItem(
                              value: 'pie', child: Text('Pie Chart')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedChartType.value = value;
                          }
                        },
                      ),
                    ),
                  )),
            ),

            const SizedBox(height: 16),

            // Chart Section
            SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final type = controller.selectedChartType.value;
                  if (type == 'bar') {
                    return _buildBarChart();
                  } else if (type == 'line') {
                    return _buildLineChart();
                  } else if (type == 'pie') {
                    return _buildPieChart();
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Riwayat Gerakan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Table Section
            // Table Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(() => Table(
                              border:
                                  TableBorder.all(color: Colors.grey, width: 1),
                              columnWidths: const {
                                0: FixedColumnWidth(150),
                                1: FixedColumnWidth(150),
                                2: FixedColumnWidth(80),
                              },
                              children: [
                                // Header
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: PalleteColor.green550),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('DATE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: PalleteColor.green50,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('GERAKAN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: PalleteColor.green50,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('SCORE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: PalleteColor.green50,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                // Paginated Data Rows
                                ...controller.paginatedData.map((item) {
                                  return TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item['date'] ?? '-'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item['gerakanName'] ??
                                            item['gerakan_name'] ??
                                            '-'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            item['score']?.toString() ?? '-'),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            )),
                      ),
                    ),

                    // Pagination Controls
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: controller.currentPage.value > 1
                                  ? () => controller.currentPage.value--
                                  : null,
                            ),
                            Text(
                              'Halaman ${controller.currentPage.value} dari ${controller.totalPages}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: controller.currentPage.value <
                                      controller.totalPages
                                  ? () => controller.currentPage.value++
                                  : null,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < controller.scoreData.length) {
                  final gerakanName =
                      controller.scoreData[index]['gerakan_name'] ?? '';
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      gerakanName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(),
            bottom: BorderSide(),
          ),
        ),
        minY: 0,
        maxY: 100,
        barGroups: controller.scoreData
            .asMap()
            .entries
            .map(
              (e) => BarChartGroupData(
                x: e.key,
                barRods: [
                  BarChartRodData(
                    toY: double.tryParse(e.value['score'].toString()) ?? 0.0,
                    color: PalleteColor.green550,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < controller.scoreData.length) {
                  final gerakanName =
                      controller.scoreData[index]['gerakan_name'] ?? "";
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      gerakanName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(),
            bottom: BorderSide(),
          ),
        ),
        minX: 0,
        maxX: controller.scoreData.length > 1
            ? (controller.scoreData.length - 1).toDouble()
            : 1.0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: controller.scoreData
                .asMap()
                .entries
                .map((e) => FlSpot(
                      e.key.toDouble(),
                      double.tryParse(e.value['score'].toString()) ?? 0.0,
                    ))
                .toList(),
            isCurved: true,
            color: PalleteColor.green550,
            barWidth: 3,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: controller.scoreData.asMap().entries.map((e) {
          final value = double.tryParse(e.value['score'].toString()) ?? 0.0;
          final index = e.key;
          return PieChartSectionData(
            value: value,
            title: e.value['gerakan_name'] ?? "",
            color: Colors.primaries[index % Colors.primaries.length],
            radius: 50,
            titleStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
