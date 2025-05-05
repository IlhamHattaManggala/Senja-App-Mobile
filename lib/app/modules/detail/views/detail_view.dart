import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/data/models/detail_seni.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: PalleteColor.green50,
          onPressed: () {
            Get.back(); // atau Navigator.pop(context);
          },
        ),
        title: Text(
          controller.seniItem.name ?? 'Alat Musik Tradisional',
          style: const TextStyle(color: PalleteColor.green50),
        ),
        iconTheme: const IconThemeData(color: PalleteColor.green50),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            controller.seniItem.imageUrl != null &&
                    controller.seniItem.imageUrl!.isNotEmpty
                ? Image.network(
                    controller.seniItem.imageUrl!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultImage(),
                  )
                : _buildDefaultImage(),

            // Content container with rounded top corners
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: PalleteColor.green50,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    controller.seniItem.name ?? 'Gamelan',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: PalleteColor.green700,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    controller.seniItem.description ??
                        'Gamelan adalah ansambel musik tradisional Indonesia yang terdiri dari berbagai instrumen seperti gong, kendang, dan saron. Musiknya berirama harmonis dan sering digunakan dalam pertunjukan seni serta upacara adat',
                    style: const TextStyle(
                        fontSize: 16, color: PalleteColor.green600),
                  ),
                  const SizedBox(height: 20),

                  // Subtitle for types
                  Text(
                    controller.seniItem.name != null &&
                            controller.seniItem.name!.isNotEmpty
                        ? "Jenis-Jenis ${controller.seniItem.name}"
                        : "Jenis-Jenis Gamelan",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PalleteColor.green700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // List of items
                  controller.detailList.isNotEmpty
                      ? _buildDetailList()
                      : _buildDefaultDetailList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Default image when no image URL is provided
  Widget _buildDefaultImage() {
    return Image.asset(
      'assets/images/gamelan.jpg', // Replace with your actual asset path
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: 250,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported, size: 50),
      ),
    );
  }

  // Build the list from controller data
  Widget _buildDetailList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.detailList.length,
      itemBuilder: (context, index) {
        final DetailSeni detail = controller.detailList[index];
        final String detailName = detail.name ?? '-';
        final String detailDesc = detail.description ?? '-';
        final String detailImage = detail.imageUrl ?? '';

        return _buildDetailItem(detailName, detailDesc, detailImage);
      },
    );
  }

  // Build default details list with hardcoded data
  Widget _buildDefaultDetailList() {
    return Column(
      children: [
        _buildDetailItem(
            'Gong',
            'Gong adalah alat musik pukul berbentuk cakram logam yang menghasilkan suara dalam dan beresonansi.',
            '', // Empty string will trigger the asset image
            assetImage: 'assets/images/gong.jpg'),
        _buildDetailItem(
            'Saron',
            'Saron adalah alat musik berbentuk bilah logam yang dipukul dengan pemukul kayu, menghasilkan nada kuat dan tajam bagian dari melodi utama',
            '',
            assetImage: 'assets/images/saron.jpg'),
        _buildDetailItem(
            'Kendang',
            'Gong adalah alat musik gamelan berbentuk tabung dengan dua sisi membran, dimainkan dengan tangan untuk mengatur irama',
            '',
            assetImage: 'assets/images/kendang.jpg'),
        _buildDetailItem(
            'Bonang',
            'Bonang terdiri dari deretan gong kecil yang diletakkan horizontal, dimainkan dengan pemukul khusus untuk menghasilkan melodi',
            '',
            assetImage: 'assets/images/bonang.jpg'),
      ],
    );
  }

  // Helper to build individual detail item
  Widget _buildDetailItem(String name, String description, String imageUrl,
      {String? assetImage}) {
    return Card(
      color: PalleteColor.green50,
      elevation: 3,
      shadowColor: PalleteColor.green550.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dari network atau asset
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 60,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildItemAssetImage(assetImage),
                    )
                  : _buildItemAssetImage(assetImage),
            ),
            const SizedBox(width: 12),

            // Konten teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ReadMoreText(
                    description,
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Lihat selengkapnya',
                    trimExpandedText: ' Sembunyikan',
                    style: const TextStyle(
                      fontSize: 16,
                      color: PalleteColor.green600,
                    ),
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PalleteColor.green700,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PalleteColor.green700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build asset image with fallback
  Widget _buildItemAssetImage(String? assetPath) {
    if (assetPath != null && assetPath.isNotEmpty) {
      return Image.asset(
        assetPath,
        width: 60,
        height: 110,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
      );
    }
    return _buildPlaceholderImage();
  }

  // Placeholder image
  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 110,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported, size: 24),
    );
  }
}
