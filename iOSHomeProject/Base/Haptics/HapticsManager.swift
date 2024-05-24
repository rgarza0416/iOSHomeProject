//
//  HapticsManager.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/22/24.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
