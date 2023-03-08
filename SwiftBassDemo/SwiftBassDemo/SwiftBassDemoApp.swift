//
//  SwiftBassDemoApp.swift
//  SwiftBassDemo
//
/// This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSMicrophoneUsageDescription key with a string value explaining to the user how the app uses this data.
///
//  Created by Keith Bromley on 3/7/23.
//

import SwiftUI

@main
struct SwiftBassDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AudioManager.audioManager)
        }
    }
}
