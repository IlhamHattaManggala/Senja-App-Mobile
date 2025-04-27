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

    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        elevation: 0,
        title: const Text('Tarian',
            style: TextStyle(
                color: PalleteColor.green50, fontWeight: FontWeight.bold)),
        leading: IconButton(
          color: PalleteColor.green50,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar tarian
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

          // Konten description dan daftar gerakan
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Color(0xFFF5F3EB)),
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

                  // Daftar Gerakan
                  const Text(
                    'Gerakan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Daftar gerakan dari API
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.gerakanList.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada data gerakan.'));
                      }

                      return ListView.builder(
                        itemCount: controller.gerakanList.length,
                        itemBuilder: (context, index) {
                          final gerakan = controller.gerakanList[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              onTap: () {
                                Get.toNamed('/monitoring', arguments: gerakan);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: (gerakan.imageUrl?.isNotEmpty ??
                                          false)
                                      ? gerakan.imageUrl!
                                      : 'https://th.bing.com/th/id/OIP.DrdVLxWoqBK9dRhOrTvTsAHaFj?rs=1&pid=ImgDetMain',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image, size: 30),
                                ),
                              ),
                              title: Text(gerakan.name ?? '-'),
                              subtitle: Text(
                                gerakan.description ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16, color: Colors.grey),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
