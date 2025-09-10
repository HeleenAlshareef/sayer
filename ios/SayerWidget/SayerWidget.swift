import WidgetKit
import SwiftUI

// MARK: - Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalOrders: Int
    let newOrders: Int
    let inProgressOrders: Int
    let closedOrders: Int
}

// MARK: - Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), totalOrders: 0, newOrders: 0, inProgressOrders: 0, closedOrders: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = loadEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry = loadEntry()

        // Force reload to ensure data sync
        WidgetCenter.shared.reloadAllTimelines()

        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(15 * 60))) // refresh every 15 min
        completion(timeline)
    }

    private func loadEntry() -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.SayerWidget")

        let totalOrders = userDefaults?.integer(forKey: "total_orders") ?? 0
        let newOrders = userDefaults?.integer(forKey: "new_orders") ?? 0
        let inProgressOrders = userDefaults?.integer(forKey: "in_progress_orders") ?? 0
        let closedOrders = userDefaults?.integer(forKey: "closed_orders") ?? 0

        return SimpleEntry(
            date: Date(),
            totalOrders: totalOrders,
            newOrders: newOrders,
            inProgressOrders: inProgressOrders,
            closedOrders: closedOrders
        )
    }
}

// MARK: - View
struct SayerWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text("الطلبات: \(entry.totalOrders)")
                .font(.headline)
                .foregroundColor(Color(hex: 0xFF0362de))

            Text("جديد: \(entry.newOrders)")
                .font(.caption)
                .foregroundColor(.primary)

            Text("جارٍ التواصل: \(entry.inProgressOrders)")
                .font(.caption)
                .foregroundColor(.primary)

            Text("تم الإغلاق: \(entry.closedOrders)")
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double(hex & 0xff) / 255
        self.init(red: red, green: green, blue: blue)
    }
}

// MARK: - Widget
struct SayerWidget: Widget {
    let kind: String = "SayerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SayerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("إحصائيات الطلبات")
        .description("يعرض حالة الطلبات مباشرة من التطبيق")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
