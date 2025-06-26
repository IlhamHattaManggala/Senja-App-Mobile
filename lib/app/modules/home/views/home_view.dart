import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/card_persegi.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      body: Stack(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              color: Color(0xFF7A651F),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              "SENJA",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: PalleteColor.green50,
                              ),
                            ),
                            Text(
                              "Belajar Tari Lebih Mudah, Langkah Demi Langkah",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, color: PalleteColor.green50),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: PalleteColor.green50,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: PalleteColor.green900.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Informasi Terkait",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              final seniList = controller.seniLainnyaList;

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: (seniList.isNotEmpty)
                                      ? seniList.map((item) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.5),
                                            child: CardPersegi(
                                              imageUrl: item.imageUrl ?? '',
                                              labelImage: item.name ?? '',
                                              onTap: () {
                                                Get.toNamed('/detail',
                                                    arguments: item.toJson());
                                              },
                                            ),
                                          );
                                        }).toList()
                                      : [
                                          // Ini fallback kalau kosong dengan navigasi ke null data
                                          _buildEmptyCard("Item 1"),
                                          _buildEmptyCard("Item 2"),
                                          _buildEmptyCard("Item 3"),
                                          _buildEmptyCard("Item 4"),
                                        ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    final tariList = controller.filteredTari;
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Get.toNamed('/berita');
                                  },
                                  icon: Icon(Icons.newspaper,
                                      color: PalleteColor.green50),
                                  label: Text("Berita Tari"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PalleteColor.green550,
                                    foregroundColor: PalleteColor.green50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // controller.goToWeb();
                                    Get.toNamed('/visualisasi');
                                  },
                                  icon: Icon(Icons.bar_chart,
                                      color: PalleteColor.green50),
                                  label: Text("Visualisasi Data Tari"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PalleteColor.green550,
                                    foregroundColor: PalleteColor.green50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "Monitoring Gerakan Tari",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  FilterChip(
                                    label: const Text("Semua Level"),
                                    selected: controller.selectedLevel.value ==
                                        "Semua Level",
                                    onSelected: (_) =>
                                        controller.updateLevel("Semua Level"),
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: const Text("Level Pemula"),
                                    selected: controller.selectedLevel.value ==
                                        "Level Pemula",
                                    onSelected: (_) =>
                                        controller.updateLevel("Level Pemula"),
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: const Text("Level Menengah"),
                                    selected: controller.selectedLevel.value ==
                                        "Level Menengah",
                                    onSelected: (_) => controller
                                        .updateLevel("Level Menengah"),
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: const Text("Level Mahir"),
                                    selected: controller.selectedLevel.value ==
                                        "Level Mahir",
                                    onSelected: (_) =>
                                        controller.updateLevel("Level Mahir"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            tariList.isEmpty
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Belum ada data tari untuk level ini.",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: tariList.length,
                                    itemBuilder: (context, index) {
                                      final tari = tariList[index];
                                      return ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: tari.imageUrl ?? '',
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        title: Text(
                                          tari.name ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          tari.description ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () {
                                          print(tari
                                              .gerakanTari); // Di GerakanController
                                          Get.toNamed('/gerakan',
                                              arguments: tari);
                                        },
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.5),
      child: CardPersegi(
        imageUrl:
            'https://images.unsplash.com/photo-1589810264340-0ce27bfbf751?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        labelImage: label,
        onTap: () {
          // Navigate with null data
          Get.toNamed('/detail', arguments: null);
        },
      ),
    );
  }
}
