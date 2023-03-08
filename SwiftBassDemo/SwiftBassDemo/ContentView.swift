//
//  ContentView.swift
//  SwiftBassDemo
//
//  Created by Keith Bromley on 3/7/23.
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
