import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({super.key});
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Baris atas: 2 card
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    'Tari Gambyong Mari Kangen',
                    'https://i.ytimg.com/vi/bxLlxz58vOw/maxresdefault.jpg',
                    () => controller.onGerakanTapped('Tari Gambyong'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCard(
                    'Tari Topeng Endel',
                    'https://t-2.tstatic.net/tribunnewswiki/foto/bank/images/tari-endel-3.jpg',
                    () => controller.onGerakanTapped('Tari Topeng Endel'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Baris bawah: 1 card lebar
            _buildCard(
              'Tari Guci',
              'https://i.ytimg.com/vi/DYw6djwa64E/maxresdefault.jpg',
              () => controller.onGerakanTapped('Tari Guci'),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String imageUrl, VoidCallback onTap,
      {bool isFullWidth = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(Get.context!).size.height * 0.26,
        margin: isFullWidth
            ? const EdgeInsets.symmetric(horizontal: 4)
            : const EdgeInsets.all(0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: PalleteColor.green50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Lihat selengkapnya',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
