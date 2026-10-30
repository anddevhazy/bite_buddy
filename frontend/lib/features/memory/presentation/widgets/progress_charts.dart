import 'dart:math';

import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

// The memory book's charts, drawn by hand so they match the game. Colours
// were checked with the dataviz palette validator against the card surface
// (#14302A): mint stays inside the lightness band, the calendar ramp is one
// hue with clear steps, and the "before" grey is told apart from mint by
// normal and colour-blind vision (it's also a hollow ring, never colour
// alone).
class ChartColors {
  static const surface = Color(0xFF14302A);
  static const accent = Color(0xFF0FA574);
  static const before = Color(0xFFC9D1CE);
  static const grid = Color(0x1FFFFFFF);
  static const emptyCell = Color(0x14FFFFFF);
  // Calendar: 1, 2, 3 and 4+ meals
  static const ramp = [
    Color(0xFF0E7F5A),
    Color(0xFF14A876),
    Color(0xFF4FD3A3),
    Color(0xFF9AF0CF),
  ];
}

// A chart's card: title, an optional one-line summary, the chart, and the
// caption for whatever is tapped
class ChartCard extends StatelessWidget {
  final String title;
  final String? summary;
  final Widget child;

  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3),
          if (summary != null)
            Text(
              summary!,
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

// What the tapped mark is; a hint until something is tapped
class _Caption extends StatelessWidget {
  final String? text;

  const _Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Text(
        text ?? 'Tap the chart for details',
        style: AppTextStyles.caption.copyWith(
          color: text == null ? AppColors.textMuted : AppColors.white,
        ),
      ),
    );
  }
}

// ── Feeding calendar ───────────────────────────────────────────────────────

// One square per day, a column per week (Monday at the top); brighter means
// more meals that day
class FeedingCalendar extends StatefulWidget {
  final List<FeedingDayEntity> days;

  const FeedingCalendar({super.key, required this.days});

  @override
  State<FeedingCalendar> createState() => _FeedingCalendarState();
}

class _FeedingCalendarState extends State<FeedingCalendar> {
  FeedingDayEntity? _selected;

  static const _gap = 2.0;

  @override
  Widget build(BuildContext context) {
    final days = widget.days;
    if (days.isEmpty) return const SizedBox.shrink();
    // Blank cells before the first day, so columns line up Monday to Sunday
    final lead = days.first.day.weekday - DateTime.monday;
    final columns = ((lead + days.length) / 7).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Caption(switch (_selected) {
          final d? =>
            '${DateFormat('EEE d MMM').format(d.day)} · '
                '${d.meals == 0 ? 'no meals' : '${d.meals} meal${d.meals == 1 ? '' : 's'} · avg score ${d.averageScore}'}',
          null => null,
        }),
        LayoutBuilder(
          builder: (context, constraints) {
            // Big squares while there are only a few weeks, smaller as the
            // calendar fills up
            final cell = min(
              30.0,
              (constraints.maxWidth - _gap * (columns - 1)) / columns,
            );
            final height = cell * 7 + _gap * 6;
            void pick(Offset p) {
              final col = (p.dx / (cell + _gap)).floor();
              final row = (p.dy / (cell + _gap)).floor();
              final index = col * 7 + row - lead;
              if (row < 0 || row > 6 || index < 0 || index >= days.length) {
                return;
              }
              setState(() => _selected = days[index]);
            }

            return Semantics(
              label:
                  'Feeding calendar: fed on '
                  '${days.where((d) => d.meals > 0).length} of '
                  '${days.length} days',
              child: GestureDetector(
                onTapDown: (d) => pick(d.localPosition),
                onPanUpdate: (d) => pick(d.localPosition),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, height),
                  painter: _CalendarPainter(
                    days: days,
                    lead: lead,
                    cell: cell,
                    gap: _gap,
                    selected: _selected,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Text('Less', style: AppTextStyles.caption),
            const SizedBox(width: 4),
            for (final c in [ChartColors.emptyCell, ...ChartColors.ramp])
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            const SizedBox(width: 2),
            Text('More meals', style: AppTextStyles.caption),
          ],
        ),
      ],
    );
  }
}

class _CalendarPainter extends CustomPainter {
  final List<FeedingDayEntity> days;
  final int lead;
  final double cell;
  final double gap;
  final FeedingDayEntity? selected;

  _CalendarPainter({
    required this.days,
    required this.lead,
    required this.cell,
    required this.gap,
    required this.selected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final (i, d) in days.indexed) {
      final slot = i + lead;
      final rect = Rect.fromLTWH(
        (slot ~/ 7) * (cell + gap),
        (slot % 7) * (cell + gap),
        cell,
        cell,
      );
      final color = d.meals == 0
          ? ChartColors.emptyCell
          : ChartColors.ramp[min(d.meals, 4) - 1];
      final shape = RRect.fromRectAndRadius(rect, Radius.circular(cell * 0.2));
      canvas.drawRRect(shape, Paint()..color = color);
      if (d == selected || i == days.length - 1) {
        // Today, and the tapped day, get a ring
        canvas.drawRRect(
          shape.inflate(1),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = d == selected ? AppColors.white : AppColors.textMuted,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_CalendarPainter old) =>
      old.selected != selected || old.days != days || old.cell != cell;
}

// ── Line and step charts ───────────────────────────────────────────────────

class ChartPoint {
  // 0 to 1 across the chart
  final double x;
  // Null leaves a gap in the line
  final double? y;
  final String caption;

  const ChartPoint({required this.x, required this.y, required this.caption});
}

// A single series over time. [step] holds each value until the next one,
// for things that jump (like levels), and carries the last value to the end.
class TrendChart extends StatefulWidget {
  final List<ChartPoint> points;
  final double yMax;
  final List<double> yTicks;
  final String startLabel;
  final String endLabel;
  final bool step;
  final String semanticLabel;

  const TrendChart({
    super.key,
    required this.points,
    required this.yMax,
    required this.yTicks,
    required this.startLabel,
    required this.endLabel,
    required this.semanticLabel,
    this.step = false,
  });

  @override
  State<TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<TrendChart> {
  int? _selected;

  static const _height = 150.0;
  static const _axisWidth = 28.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Caption(_selected == null ? null : widget.points[_selected!].caption),
        LayoutBuilder(
          builder: (context, constraints) {
            final plotWidth = constraints.maxWidth - _axisWidth;
            void pick(Offset p) {
              final x = ((p.dx - _axisWidth) / plotWidth).clamp(0.0, 1.0);
              // Nearest point that has a value
              int? best;
              for (final (i, pt) in widget.points.indexed) {
                if (pt.y == null) continue;
                if (best == null ||
                    (pt.x - x).abs() < (widget.points[best].x - x).abs()) {
                  best = i;
                }
              }
              if (best != null) setState(() => _selected = best);
            }

            return Semantics(
              label: widget.semanticLabel,
              child: GestureDetector(
                onTapDown: (d) => pick(d.localPosition),
                onPanUpdate: (d) => pick(d.localPosition),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, _height),
                  painter: _TrendPainter(
                    points: widget.points,
                    yMax: widget.yMax,
                    yTicks: widget.yTicks,
                    step: widget.step,
                    selected: _selected,
                    axisWidth: _axisWidth,
                    labelStyle: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: _axisWidth, top: 4),
          child: Row(
            children: [
              Text(widget.startLabel, style: AppTextStyles.caption),
              const Spacer(),
              Text(widget.endLabel, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<ChartPoint> points;
  final double yMax;
  final List<double> yTicks;
  final bool step;
  final int? selected;
  final double axisWidth;
  final TextStyle labelStyle;

  _TrendPainter({
    required this.points,
    required this.yMax,
    required this.yTicks,
    required this.step,
    required this.selected,
    required this.axisWidth,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const top = 8.0;
    final plot = Rect.fromLTRB(axisWidth, top, size.width - 6, size.height);
    Offset at(double x, double y) => Offset(
      plot.left + x * plot.width,
      plot.bottom - (y / yMax) * plot.height,
    );

    // Recessive grid and axis labels
    final grid = Paint()
      ..color = ChartColors.grid
      ..strokeWidth = 1;
    for (final t in yTicks) {
      final y = at(0, t).dy;
      canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), grid);
      final label = TextPainter(
        text: TextSpan(text: t.round().toString(), style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(
        canvas,
        Offset(axisWidth - label.width - 6, y - label.height / 2),
      );
    }

    // The line, broken where there's no value
    final line = Paint()
      ..color = ChartColors.accent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    final path = Path();
    Offset? last;
    for (final p in points) {
      if (p.y == null) {
        last = null;
        continue;
      }
      final o = at(p.x, p.y!);
      if (last == null) {
        path.moveTo(o.dx, o.dy);
      } else if (step) {
        path.lineTo(o.dx, last.dy);
        path.lineTo(o.dx, o.dy);
      } else {
        path.lineTo(o.dx, o.dy);
      }
      last = o;
    }
    if (step && last != null) path.lineTo(plot.right, last.dy);
    canvas.drawPath(path, line);

    // Selected point: a crosshair
    if (selected case final s?) {
      final o = at(points[s].x, points[s].y ?? 0);
      canvas.drawLine(
        Offset(o.dx, plot.top),
        Offset(o.dx, plot.bottom),
        Paint()
          ..color = AppColors.textMuted.withValues(alpha: 0.5)
          ..strokeWidth = 1,
      );
    }

    // Markers with a surface ring, so they read on top of the line
    for (final (i, p) in points.indexed) {
      if (p.y == null) continue;
      final o = at(p.x, p.y!);
      final r = i == selected ? 6.0 : 4.0;
      canvas.drawCircle(o, r + 2, Paint()..color = ChartColors.surface);
      canvas.drawCircle(o, r, Paint()..color = ChartColors.accent);
    }
  }

  @override
  bool shouldRepaint(_TrendPainter old) =>
      old.selected != selected || old.points != points;
}

// ── Weekly bars ────────────────────────────────────────────────────────────

class WeeklyBars extends StatefulWidget {
  final List<int> values;
  final List<String> captions;
  final String startLabel;
  final String endLabel;
  final String semanticLabel;

  const WeeklyBars({
    super.key,
    required this.values,
    required this.captions,
    required this.startLabel,
    required this.endLabel,
    required this.semanticLabel,
  });

  @override
  State<WeeklyBars> createState() => _WeeklyBarsState();
}

class _WeeklyBarsState extends State<WeeklyBars> {
  int? _selected;

  static const _height = 110.0;

  @override
  Widget build(BuildContext context) {
    final n = widget.values.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Caption(_selected == null ? null : widget.captions[_selected!]),
        LayoutBuilder(
          builder: (context, constraints) {
            void pick(Offset p) {
              final i = (p.dx / constraints.maxWidth * n).floor();
              if (i >= 0 && i < n) setState(() => _selected = i);
            }

            return Semantics(
              label: widget.semanticLabel,
              child: GestureDetector(
                onTapDown: (d) => pick(d.localPosition),
                onPanUpdate: (d) => pick(d.localPosition),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, _height),
                  painter: _BarsPainter(
                    values: widget.values,
                    selected: _selected,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(widget.startLabel, style: AppTextStyles.caption),
            const Spacer(),
            Text(widget.endLabel, style: AppTextStyles.caption),
          ],
        ),
      ],
    );
  }
}

class _BarsPainter extends CustomPainter {
  final List<int> values;
  final int? selected;

  _BarsPainter({required this.values, required this.selected});

  @override
  void paint(Canvas canvas, Size size) {
    final top = max(1, values.fold(0, max)).toDouble();
    final slot = size.width / values.length;
    // A 2px gap between bars, but never thinner than the slot allows
    final width = max(2.0, min(18.0, slot - 2));
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      Paint()
        ..color = ChartColors.grid
        ..strokeWidth = 1,
    );
    for (final (i, v) in values.indexed) {
      if (v == 0) continue;
      final h = max(3.0, v / top * (size.height - 4));
      final left = i * slot + (slot - width) / 2;
      final bar = RRect.fromRectAndCorners(
        Rect.fromLTWH(left, size.height - h, width, h),
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
      );
      canvas.drawRRect(
        bar,
        Paint()
          ..color = i == selected || selected == null
              ? ChartColors.accent
              : ChartColors.accent.withValues(alpha: 0.45),
      );
    }
  }

  @override
  bool shouldRepaint(_BarsPainter old) =>
      old.selected != selected || old.values != values;
}

// ── Nutrients: first week vs last 7 days ───────────────────────────────────

// A dumbbell per nutrient: hollow grey ring for the first week, filled mint
// dot for now, values written out beside them
class NutrientDumbbells extends StatelessWidget {
  final NutrientBalanceEntity first;
  final NutrientBalanceEntity last;

  const NutrientDumbbells({super.key, required this.first, required this.last});

  @override
  Widget build(BuildContext context) {
    final rows = [
      for (final (i, (name, before)) in first.named.indexed)
        (name, before, last.named[i].$2),
    ];
    final scale = max(
      100,
      rows.fold(0, (m, r) => max(m, max(r.$2, r.$3))),
    ).toDouble();
    return Column(
      children: [
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: 4,
          children: [
            for (final (filled, label) in [
              (false, 'First week'),
              (true, 'Last 7 days'),
            ])
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Dot(filled: filled),
                  const SizedBox(width: 4),
                  Text(label, style: AppTextStyles.caption),
                ],
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (name, before, now) in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Semantics(
              label: '$name: $before% in the first week, $now% now',
              excludeSemantics: true,
              child: Row(
                children: [
                  SizedBox(
                    width: 68,
                    child: Text(name, style: AppTextStyles.caption),
                  ),
                  Expanded(
                    child: CustomPaint(
                      size: const Size(double.infinity, 16),
                      painter: _DumbbellPainter(
                        before: before / scale,
                        now: now / scale,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 74,
                    child: Text(
                      '$before → $now%',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool filled;

  const _Dot({required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? ChartColors.accent : null,
        border: filled ? null : Border.all(color: ChartColors.before, width: 2),
      ),
    );
  }
}

class _DumbbellPainter extends CustomPainter {
  final double before;
  final double now;

  _DumbbellPainter({required this.before, required this.now});

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    const pad = 8.0;
    double x(double v) => pad + v * (size.width - pad * 2);
    canvas.drawLine(
      Offset(pad, y),
      Offset(size.width - pad, y),
      Paint()
        ..color = ChartColors.grid
        ..strokeWidth = 1,
    );
    canvas.drawLine(
      Offset(x(before), y),
      Offset(x(now), y),
      Paint()
        ..color = AppColors.textMuted
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(x(before), y),
      5,
      Paint()
        ..color = ChartColors.before
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(x(now), y),
      7,
      Paint()..color = ChartColors.surface,
    );
    canvas.drawCircle(
      Offset(x(now), y),
      5,
      Paint()..color = ChartColors.accent,
    );
  }

  @override
  bool shouldRepaint(_DumbbellPainter old) =>
      old.before != before || old.now != now;
}
