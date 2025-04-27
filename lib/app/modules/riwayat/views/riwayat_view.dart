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
      body: Column(
        children: [
          SizedBox(height: 30),
          _buildGerakanItem(
            'Gerakan 1',
            'https://png.pngtree.com/png-clipart/20221227/original/pngtree-traditional-art-of-horse-jaranan-lumping-reog-dance-ponorogo-east-java-png-image_8811263.png',
            PalleteColor.green550,
            () => controller.onGerakanTapped(1),
          ),
          SizedBox(height: 15),
          _buildGerakanItem(
            'Gerakan 2',
            'https://png.pngtree.com/png-clipart/20221227/original/pngtree-traditional-art-of-horse-jaranan-lumping-reog-dance-ponorogo-east-java-png-image_8811263.png',
            PalleteColor.green550,
            () => controller.onGerakanTapped(2),
          ),
          SizedBox(height: 15),
          _buildGerakanItem(
            'Gerakan 3',
            'https://png.pngtree.com/png-clipart/20221227/original/pngtree-traditional-art-of-horse-jaranan-lumping-reog-dance-ponorogo-east-java-png-image_8811263.png',
            PalleteColor.green550,
            () => controller.onGerakanTapped(3),
          ),
        ],
      ),
    );
  }

  Widget _buildGerakanItem(
      String title, String imageUrl, Color accentColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        decoration: BoxDecoration(
          color: PalleteColor.green50, // Light olive/beige color
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4), // Warna shadow
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3), // Posisi shadow: (x, y)
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                // If image not found, create a custom dance figure with music note
                return Stack(
                  children: [
                    const Icon(Icons.music_note,
                        color: Colors.purple, size: 16),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: accentColor, width: 1),
                        ),
                        child: const Icon(Icons.person, color: Colors.indigo),
                      ),
                    ),
                  ],
                );
              },
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: const Text(
            'Lihat selengkapnya',
            style: TextStyle(
              color: Color(0xFF666666),
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
