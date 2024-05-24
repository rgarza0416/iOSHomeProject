//
//  SettingsView.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/22/24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultsKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                haptics
            }
            .navigationTitle("Settings")
        }
    }
}
private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

#Preview {
    SettingsView()
}
