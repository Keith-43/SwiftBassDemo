//
//  ContentView.swift
//  SwiftBassDemo
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        Spectrum()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
