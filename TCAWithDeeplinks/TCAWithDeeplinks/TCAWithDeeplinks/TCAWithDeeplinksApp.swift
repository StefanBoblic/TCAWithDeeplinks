//
//  TCAWithDeeplinksApp.swift
//  TCAWithDeeplinks
//
//  Created by Stefan Boblic on 09.04.2023.
//

import SwiftUI
import Home
import Detail

@main
struct TCAWithDeeplinksApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(destination: DetailView())
        }
    }
}

