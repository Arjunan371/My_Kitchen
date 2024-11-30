//
//  ThemeManager.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("appearance") var appearanceMode: AppearanceMode = .light
    @AppStorage("automaticTheme") var automaticTheme: Bool = false
    @AppStorage("systemTheme") var systemTheme: Bool = false
    
    init() {
        systemTheme = true
        appearanceMode = .system
    }
    
    var preferredDesign: ColorScheme? {
        switch appearanceMode {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    func automaticThemeChange() -> Bool? {
        let calendar = Calendar.current
        let currentDate = Date()
        guard let morning = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: currentDate),
              let evening = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: currentDate) else {
            return nil
        }
        return !(morning...evening).contains(currentDate)
    }
    
    func automaticChangeTrueAction() {
        systemTheme = false
        appearanceMode = (automaticThemeChange() ?? false) ? .dark : .light
        print("Color scheme updated: \(appearanceMode == .light ? "Light" : "Dark")")
    }
    
    func getSystemColorScheme() -> ColorScheme {
        return UITraitCollection.current.userInterfaceStyle == .light ? .light : .dark
    }
    
    func colorChangeEntireApp() {
        if automaticTheme {
            automaticChangeTrueAction()
        }
    }

}

enum AppearanceMode: Int {
    case light = 1
    case dark = 2
    case system = 0
}
