//
//  ContentView.swift
//  CurvedCustomTabBar
//
//  Created by Yunus Emre Taşdemir on 26.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
