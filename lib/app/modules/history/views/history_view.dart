import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Histori',
          style: TextStyle(color: PalleteColor.green50),
        ),
        centerTitle: true,
        backgroundColor: PalleteColor.green550,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Search & Dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.filteredHistoryList(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Cari',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(() => DropdownButton<String>(
                          value: controller.sortOption.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.sortOption.value = newValue;
                              controller.sortHistory();
                            }
                          },
                          items: controller.sortOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        )),
                  ),
                ],
              ),
            ),

            // Riwayat
            SizedBox(
              height: 120,
              child: controller.filteredHistoryList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 8),
                        color: PalleteColor.green50,
                        child: SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                // Ikon
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: PalleteColor.green100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.groups,
                                    color: PalleteColor.green50,
                                    size: 26,
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // Info Teks
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize:
                                        MainAxisSize.min, // <-- Penting
                                    children: const [
                                      Text(
                                        'Gerakan 1',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Tari 1',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Senin, 1 Jan 2023',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: PalleteColor.green900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Poin
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: PalleteColor.green550,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center, // <--
                                    children: [
                                      const Text(
                                        'Poin:',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: PalleteColor.green50),
                                      ),
                                      Text(
                                        '9/10',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: PalleteColor.green50),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.filteredHistoryList.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredHistoryList[index];

                        return SizedBox(
                          height: 120, // <- supaya semua Card sama tingginya
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: PalleteColor.green50,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: PalleteColor.green100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.groups,
                                      color: PalleteColor.green50,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center, // <--
                                      children: [
                                        Text(
                                          item['gerakan'] ?? 'Gerakan 1',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item['title'] ?? 'Tari 1',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item['date'] ?? 'Senin, 1 Jan 2023',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: PalleteColor.green900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center, // <--
                                      children: [
                                        const Text(
                                          'Poin:',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          '${item['point'] ?? '9'}/10',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
