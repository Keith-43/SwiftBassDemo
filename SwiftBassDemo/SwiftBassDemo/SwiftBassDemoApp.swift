//
//  SwiftBassDemoApp.swift
//  SwiftBassDemo
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
