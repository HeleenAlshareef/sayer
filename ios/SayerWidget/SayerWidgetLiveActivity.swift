//
//  SayerWidgetLiveActivity.swift
//  SayerWidget
//
//  Created by Heleen Alshareef on 14/03/1447 AH.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SayerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SayerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SayerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SayerWidgetAttributes {
    fileprivate static var preview: SayerWidgetAttributes {
        SayerWidgetAttributes(name: "World")
    }
}

extension SayerWidgetAttributes.ContentState {
    fileprivate static var smiley: SayerWidgetAttributes.ContentState {
        SayerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SayerWidgetAttributes.ContentState {
         SayerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SayerWidgetAttributes.preview) {
   SayerWidgetLiveActivity()
} contentStates: {
    SayerWidgetAttributes.ContentState.smiley
    SayerWidgetAttributes.ContentState.starEyes
}
