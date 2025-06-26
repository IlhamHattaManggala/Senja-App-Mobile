import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/gerakan_controller.dart';

class GerakanView extends GetView<GerakanController> {
  const GerakanView({super.key});

  @override
  Widget build(BuildContext context) {
    final tari = controller.tari;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: PalleteColor.green50,
        appBar: AppBar(
          backgroundColor: PalleteColor.green550,
          elevation: 0,
          title: const Text(
            'Tarian',
            style: TextStyle(
              color: PalleteColor.green50,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            color: PalleteColor.green50,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          bottom: const TabBar(
            labelColor: PalleteColor.green50,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Gerakan'),
              Tab(text: 'Contoh Gerakan'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: (tari.imageUrl?.isNotEmpty ?? false)
                  ? tari.imageUrl!
                  : 'https://th.bing.com/th/id/OIP.DrdVLxWoqBK9dRhOrTvTsAHaFj?rs=1&pid=ImgDetMain',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image, size: 100)),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFF5F3EB)),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return TabBarView(
                    children: [
                      // Tab 1: Daftar Gerakan
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tari.name ?? 'Nama Tarian',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              tari.description ?? 'description belum tersedia',
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Gerakan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (controller.gerakanList.isEmpty)
                              const Center(
                                  child: Text('Tidak ada data gerakan.'))
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.gerakanList.length,
                                itemBuilder: (context, index) {
                                  final gerakan = controller.gerakanList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed('/monitoring', arguments: {
                                        'tariName': tari.name ?? '',
                                        'gerakanName': gerakan.name ?? '',
                                        'gerakanVideoUrl':
                                            gerakan.videoUrl ?? '',
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: PalleteColor.green50,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.play_circle_fill,
                                              color: PalleteColor.green400,
                                              size: 36),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  gerakan.name ?? '-',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Klik untuk latihan gerakan ini',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 16, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),

                      // Tab 2: Contoh Gerakan
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contoh Gerakan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (controller.gerakanList.isEmpty)
                              const Center(
                                  child: Text('Tidak ada data gerakan.'))
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.gerakanList.length,
                                itemBuilder: (context, index) {
                                  final gerakan = controller.gerakanList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed('/preview', arguments: {
                                        'tariName': tari.name ?? '',
                                        'previewVideo':
                                            gerakan.previewVideo ?? '',
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: PalleteColor.green50,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.play_circle_outline,
                                              color: PalleteColor.green300,
                                              size: 36),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  gerakan.name ?? '-',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Tonton contoh gerakan ini',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 16, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
