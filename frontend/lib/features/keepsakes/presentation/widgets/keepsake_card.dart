import 'dart:math';

import 'package:bite_buddy/features/global/components/buddy_picture.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

// A keepsake card, drawn like the NFT's picture on the server
// (backend utils/keepsake_rules.dart keepsakeSvg): frame and colour for the
// kind, the buddy, the date, the moment's stat and the edition number.
class KeepsakeCard extends StatelessWidget {
  final KeepsakeEntity keepsake;
  final double width;

  const KeepsakeCard({super.key, required this.keepsake, this.width = 160});

  static const kindColors = {
    'certificate': Color(0xFF12C48B),
    'streak': Color(0xFFFFA41B),
    'level': Color(0xFF5B8CFF),
    'meals': Color(0xFF1FB48F),
    'trophy': Color(0xFFF2C14E),
  };

  static const kindLabels = {
    'certificate': 'BUDDY CERTIFICATE',
    'streak': 'STREAK',
    'level': 'LEVEL UP',
    'meals': 'MEALS',
    'trophy': 'LEAGUE TROPHY',
  };

  @override
  Widget build(BuildContext context) {
    final k = keepsake;
    final color = kindColors[k.kind] ?? AppColors.primary;
    // Everything scales with the card, so it reads the same big or small
    final s = width / 300;
    // Small cards keep their text readable rather than scaling it away
    double text(double size, double minimum) => max(size * s, minimum);
    final picture = width * 0.42;
    return Container(
      width: width,
      height: width * 1.4,
      padding: EdgeInsets.all(14 * s),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * s),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundTop, AppColors.background],
        ),
        border: Border.all(color: color, width: 3 * s),
      ),
      child: Column(
        children: [
          Text(
            kindLabels[k.kind] ?? k.kind.toUpperCase(),
            maxLines: 1,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontSize: text(13, 9),
              fontWeight: FontWeight.w700,
              letterSpacing: 2 * s,
            ),
          ),
          SizedBox(height: 4 * s),
          Text(
            '${k.emoji} ${k.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h3.copyWith(fontSize: text(22, 14)),
          ),
          const Spacer(),
          Container(
            width: picture + 10 * s,
            height: picture + 10 * s,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: k.showPaw
                ? Container(
                    width: picture,
                    height: picture,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1C3A31),
                    ),
                    child: Text(
                      '🐾',
                      style: TextStyle(fontSize: picture * 0.45),
                    ),
                  )
                : ClipOval(
                    child: Container(
                      width: picture,
                      height: picture,
                      color: const Color(0xFF1C3A31),
                      child: BuddyPicture(
                        speciesKey: k.speciesKey,
                        portraitId: k.portraitId,
                        size: picture,
                      ),
                    ),
                  ),
          ),
          const Spacer(),
          Text(
            k.petName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h3.copyWith(fontSize: text(22, 14)),
          ),
          Text(
            DateFormat('d MMM y').format(k.earnedAt),
            style: AppTextStyles.caption.copyWith(fontSize: text(13, 10)),
          ),
          if (k.stat != null)
            Text(
              k.stat!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white,
                fontSize: text(13, 10),
              ),
            ),
          SizedBox(height: 6 * s),
          Text(
            k.edition == null ? 'Not minted yet' : '#${k.edition}',
            style: AppTextStyles.h3.copyWith(
              color: k.edition == null ? AppColors.textMuted : color,
              fontSize: k.edition == null ? text(14, 10) : text(20, 14),
            ),
          ),
        ],
      ),
    );
  }
}
