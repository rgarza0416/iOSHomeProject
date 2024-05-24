//
//  iOSHomeProjectApp.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/15/24.
//

import SwiftUI

@main
struct iOSHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleViews()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}

