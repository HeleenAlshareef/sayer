//
//  SayerWidgetBundle.swift
//  SayerWidget
//
//  Created by Heleen Alshareef on 14/03/1447 AH.
//

import WidgetKit
import SwiftUI

@main
struct SayerWidgetBundle: WidgetBundle {
    var body: some Widget {
        SayerWidget()
        SayerWidgetControl()
        SayerWidgetLiveActivity()
    }
}
