import 'dart:math';

import 'package:bite_buddy/features/global/constants/species.dart';
import 'package:flutter/material.dart';

// The pet, gently bobbing. Tapping it pops a few hearts.
class PetAvatar extends StatefulWidget {
  final String speciesKey;
  final double size;
  final bool interactive;

  const PetAvatar({
    super.key,
    required this.speciesKey,
    this.size = 160,
    this.interactive = false,
  });

  @override
  State<PetAvatar> createState() => _PetAvatarState();
}

class _PetAvatarState extends State<PetAvatar>
    with TickerProviderStateMixin {
  late final AnimationController _bob = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  final List<_Heart> _hearts = [];
  final _rng = Random();

  @override
  void dispose() {
    _bob.dispose();
    for (final h in _hearts) {
      h.controller.dispose();
    }
    super.dispose();
  }

  void _popHearts() {
    for (var i = 0; i < 3; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1100),
      );
      final heart = _Heart(
        controller: controller,
        dx: (_rng.nextDouble() - 0.5) * widget.size,
      );
      setState(() => _hearts.add(heart));
      controller.forward().whenComplete(() {
        if (!mounted) return;
        setState(() => _hearts.remove(heart));
        controller.dispose();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.interactive ? _popHearts : null,
      child: SizedBox(
        width: widget.size * 1.6,
        height: widget.size * 1.4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _bob,
              builder:
                  (context, child) => Transform.translate(
                    offset: Offset(0, -8 * Curves.easeInOut.transform(_bob.value)),
                    child: child,
                  ),
              child: Text(
                Species.emoji(widget.speciesKey),
                style: TextStyle(fontSize: widget.size * 0.75),
              ),
            ),
            for (final h in _hearts)
              AnimatedBuilder(
                animation: h.controller,
                builder:
                    (context, _) => Transform.translate(
                      offset: Offset(
                        h.dx,
                        -widget.size * 0.6 * h.controller.value,
                      ),
                      child: Opacity(
                        opacity: 1 - h.controller.value,
                        child: const Text('❤️', style: TextStyle(fontSize: 34)),
                      ),
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Heart {
  final AnimationController controller;
  final double dx;

  _Heart({required this.controller, required this.dx});
}
