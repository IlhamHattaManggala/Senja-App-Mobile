import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/berita_controller.dart';

class BeritaView extends GetView<BeritaController> {
  const BeritaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: PalleteColor.green50),
        title: Text(
          'Berita Tari',
          style: TextStyle(color: PalleteColor.green50),
        ),
        backgroundColor: PalleteColor.green550,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.artikelList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.artikelList.length,
                itemBuilder: (context, index) {
                  final artikel = controller.artikelList[index];
                  return Card(
                    color: PalleteColor.green50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: PalleteColor.green550, width: 1),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: artikel.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: artikel.imageUrl!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2)),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image),
                              ),
                            )
                          : const Icon(Icons.image_not_supported),
                      title: Text(artikel.title, maxLines: 1),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(artikel.date),
                          const SizedBox(height: 4),
                          if (artikel.content != null)
                            Text(
                              artikel.content!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            _buildPagination(controller),
            const SizedBox(height: 18),
          ],
        );
      }),
    );
  }

  Widget _buildPagination(BeritaController controller) {
    int currentPage = controller.currentPage;
    int totalPages = controller.totalPages;
    List<Widget> pageButtons = [];

    // Tombol halaman pertama
    if (currentPage > 2) {
      pageButtons.add(_pageButton(controller, 1));
      if (currentPage > 3) {
        pageButtons.add(
          const Text("..."),
        );
      }
    }

    // Halaman di sekitar currentPage
    for (int i = currentPage - 1; i <= currentPage + 1; i++) {
      if (i > 0 && i <= totalPages) {
        pageButtons.add(_pageButton(controller, i));
      }
    }

    // Tombol halaman terakhir
    if (currentPage < totalPages - 2) {
      if (currentPage < totalPages - 3) {
        pageButtons.add(
          const Text("..."),
        );
      }
      pageButtons.add(_pageButton(controller, totalPages));
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _navigationButton(
              label: "Prev",
              onPressed: currentPage > 1 ? controller.previousPage : null,
            ),
            ...pageButtons,
            _navigationButton(
              label: "Next",
              onPressed: currentPage < totalPages ? controller.nextPage : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigationButton({required String label, VoidCallback? onPressed}) {
    final isEnabled = onPressed != null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isEnabled ? PalleteColor.green550 : PalleteColor.green100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isEnabled ? PalleteColor.green50 : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _pageButton(BeritaController controller, int page) {
    final isCurrent = controller.currentPage == page;

    return GestureDetector(
      onTap: () {
        if (!isCurrent) controller.fetchArtikel(page: page);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isCurrent ? PalleteColor.green550 : PalleteColor.green50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: PalleteColor.green550),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCurrent ? PalleteColor.green50 : Colors.black,
          ),
        ),
      ),
    );
  }
}
