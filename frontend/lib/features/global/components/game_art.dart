import 'package:flutter/material.dart';

// A character illustration (pet or opponent). If a new species or opponent is
// added on the server before its art exists, shows a paw instead of crashing.
class GameArt extends StatelessWidget {
  final String asset;
  final double size;

  const GameArt(this.asset, {super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      // Decode at display size rather than the full 512px
      cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
      errorBuilder: (_, _, _) => SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Text('🐾', style: TextStyle(fontSize: size * 0.6)),
        ),
      ),
    );
  }
}
