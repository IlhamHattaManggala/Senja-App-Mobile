import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar dengan Border
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 42,
            backgroundImage: CachedNetworkImageProvider(
                '$imageUrl?${DateTime.now().millisecondsSinceEpoch}'),
          ),
        ),
      ],
    );
  }
}
