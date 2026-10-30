import SwiftUI
import WidgetKit

// The home-screen widget. The app saves the buddy's details whenever it loads
// the pet (lib/features/global/services/pet_widget_service.dart) into the
// shared App Group; the mood is worked out here from the last meal time, so
// it stays right between app opens. Same rules as the Android widget
// (android/.../BuddyWidgetProvider.kt).

private let appGroupId = "group.com.example.biteBuddy"

struct BuddyEntry: TimelineEntry {
  let date: Date
  let name: String?
  let mood: String
  let streak: Int
  let imagePath: String?
}

struct BuddyProvider: TimelineProvider {
  func placeholder(in context: Context) -> BuddyEntry {
    BuddyEntry(date: Date(), name: "Fluffy", mood: "Happy and full 😊", streak: 3, imagePath: nil)
  }

  func getSnapshot(in context: Context, completion: @escaping (BuddyEntry) -> Void) {
    completion(entry(at: Date()))
  }

  // An entry every 30 minutes for the next 12 hours, so the mood changes on
  // time even if the app isn't opened
  func getTimeline(in context: Context, completion: @escaping (Timeline<BuddyEntry>) -> Void) {
    let now = Date()
    let entries = (0..<24).map { entry(at: now.addingTimeInterval(Double($0) * 1800)) }
    completion(Timeline(entries: entries, policy: .atEnd))
  }

  private func entry(at date: Date) -> BuddyEntry {
    let data = UserDefaults(suiteName: appGroupId)
    let name = data?.string(forKey: "petName")
    let meals = data?.integer(forKey: "mealsEaten") ?? 0
    let lastFedAt = Double(data?.string(forKey: "lastFedAt") ?? "").map {
      Date(timeIntervalSince1970: $0 / 1000)
    }
    return BuddyEntry(
      date: date,
      name: name,
      mood: name == nil ? "Open the app to meet your buddy" : mood(meals, lastFedAt, date),
      streak: liveStreak(data?.integer(forKey: "streak") ?? 0, lastFedAt, date),
      imagePath: data?.string(forKey: "petImage")
    )
  }

  // Same 8-hour hunger grace as the server (utils/pet_stats.dart)
  private func mood(_ meals: Int, _ lastFedAt: Date?, _ now: Date) -> String {
    guard meals > 0, let fed = lastFedAt else { return "Hungry! Scan your first meal 🍽️" }
    let hours = now.timeIntervalSince(fed) / 3600
    switch hours {
    case ..<4: return "Happy and full 😊"
    case ..<8: return "Getting peckish 🙂"
    case ..<24: return "Hungry! Feed me 🍽️"
    default: return "Starving and feeling weak 😢"
    }
  }

  // A streak ends once a whole day passes with no meal
  private func liveStreak(_ streak: Int, _ lastFedAt: Date?, _ now: Date) -> Int {
    guard streak > 0, let fed = lastFedAt else { return 0 }
    let calendar = Calendar.current
    let days = calendar.dateComponents(
      [.day], from: calendar.startOfDay(for: fed), to: calendar.startOfDay(for: now)
    ).day ?? 0
    return days <= 1 ? streak : 0
  }
}

struct BuddyWidgetView: View {
  let entry: BuddyEntry

  var body: some View {
    HStack(spacing: 12) {
      if let path = entry.imagePath, let image = UIImage(contentsOfFile: path) {
        Image(uiImage: image).resizable().scaledToFit().frame(width: 64, height: 64)
      }
      VStack(alignment: .leading, spacing: 2) {
        Text(entry.name ?? "Bite Buddy").font(.headline).foregroundColor(.white)
        Text(entry.mood).font(.subheadline).foregroundColor(Color(red: 0.72, green: 0.77, blue: 0.75))
        if entry.streak > 0 {
          Text("🔥 \(entry.streak)-day streak").font(.caption.bold())
            .foregroundColor(Color(red: 1, green: 0.64, blue: 0.11))
        }
      }
      Spacer(minLength: 0)
    }
    .containerBackground(for: .widget) {
      LinearGradient(
        colors: [Color(red: 0.07, green: 0.23, blue: 0.18), Color(red: 0.04, green: 0.14, blue: 0.11)],
        startPoint: .top, endPoint: .bottom
      )
    }
  }
}

@main
struct BuddyWidget: Widget {
  // Must match iOSName in pet_widget_service.dart
  let kind = "BuddyWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: BuddyProvider()) { entry in
      BuddyWidgetView(entry: entry)
    }
    .configurationDisplayName("Bite Buddy")
    .description("See how hungry your buddy is and keep your streak going.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}
