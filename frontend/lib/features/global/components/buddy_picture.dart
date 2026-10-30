import 'dart:typed_data';

import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/services/portrait_cache.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';

// A buddy's picture: the photo of the user's own pet if they made one ("Use
// my own pet"), otherwise the species art. Shows the species art while the
// photo loads, or if it can't.
class BuddyPicture extends StatelessWidget {
  final String speciesKey;
  final int? portraitId;
  final double size;

  const BuddyPicture({
    super.key,
    required this.speciesKey,
    required this.portraitId,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final species = GameArt(AppImages.pet(speciesKey), size: size);
    final id = portraitId;
    if (id == null) return species;
    return FutureBuilder<Uint8List?>(
      future: sl<PortraitCache>().load(id),
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return species;
        return PortraitCircle(bytes: bytes, size: size);
      },
    );
  }
}

// A photo of a pet in a circle with a mint ring
class PortraitCircle extends StatelessWidget {
  final Uint8List bytes;
  final double size;

  const PortraitCircle({super.key, required this.bytes, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.04),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: ClipOval(
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
        ),
      ),
    );
  }
}
