//
//  CheckmarkPopoverView.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/21/24.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    CheckmarkPopoverView()
}
