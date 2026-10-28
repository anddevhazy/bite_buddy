import 'package:bite_buddy/features/guide/data/guide_content.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/pages/guide_page.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every topic id has exactly one entry with text', () {
    for (final id in GuideTopicId.values) {
      final matches = GuideContent.topics.where((t) => t.id == id);
      expect(matches, hasLength(1), reason: '$id');
      final topic = matches.single;
      expect(topic.title, isNotEmpty);
      expect(topic.summary, isNotEmpty);
      expect(topic.points, isNotEmpty);
    }
  });

  testWidgets('guide page lists every topic and expands on tap', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 3000));
    await tester.pumpWidget(const MaterialApp(home: GuidePage()));

    for (final topic in GuideContent.topics) {
      expect(find.text(topic.title), findsOneWidget);
    }
    // The basics start open; the others show only their title
    final health = GuideContent.byId(GuideTopicId.health);
    expect(find.text(health.summary), findsNothing);
    await tester.tap(find.text(health.title));
    await tester.pumpAndSettle();
    expect(find.text(health.summary), findsOneWidget);
  });

  testWidgets('info button opens a sheet with its topics', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InfoButton(topics: [GuideTopicId.energy, GuideTopicId.coins]),
        ),
      ),
    );
    await tester.tap(find.byType(InfoButton));
    await tester.pumpAndSettle();
    expect(find.text('Energy'), findsOneWidget);
    expect(find.text('Coins'), findsOneWidget);
    expect(find.text('Health'), findsNothing);
  });
}
