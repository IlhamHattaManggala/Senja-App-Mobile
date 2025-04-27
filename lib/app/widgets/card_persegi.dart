import 'package:flutter/material.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

class CardPersegi extends StatelessWidget {
  final String imageUrl;
  final String labelImage;
  final VoidCallback? onTap;

  const CardPersegi({
    super.key,
    required this.imageUrl,
    required this.labelImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> hoverNotifier = ValueNotifier(false);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hoverNotifier.value = true,
      onExit: (_) => hoverNotifier.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: ValueListenableBuilder<bool>(
          valueListenable: hoverNotifier,
          builder: (context, isHovered, child) {
            return Stack(
              children: [
                // Gambar utama
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay transparan saat hover
                if (isHovered)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: PalleteColor.green600.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        labelImage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: PalleteColor.green50,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
