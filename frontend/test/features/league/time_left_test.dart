import 'package:bite_buddy/features/league/presentation/widgets/time_left.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 10, 30, 12);

  test('formats days, hours and minutes left', () {
    expect(
      timeLeft(now.add(const Duration(days: 3, hours: 4)), now: now),
      '3d 4h',
    );
    expect(
      timeLeft(now.add(const Duration(hours: 5, minutes: 12)), now: now),
      '5h 12m',
    );
    expect(timeLeft(now.add(const Duration(minutes: 12)), now: now), '12m');
  });

  test('says "now" once the time has passed', () {
    expect(timeLeft(now.subtract(const Duration(minutes: 5)), now: now), 'now');
  });
}
