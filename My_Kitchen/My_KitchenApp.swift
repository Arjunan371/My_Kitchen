//
//  My_KitchenApp.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

@main
struct My_KitchenApp: App {
    @StateObject var themeManager = ThemeManager()
    @StateObject var viewModel = HomeViewVM()
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            DashBoardView()
                .preferredColorScheme(themeManager.preferredDesign)
                .environmentObject(themeManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .background:
                        print("Background")
                        themeManager.colorChangeEntireApp()
                    case .inactive:
                        print("Inactive")
                        themeManager.colorChangeEntireApp()
                    case .active:
                        print("Active")
                        themeManager.colorChangeEntireApp()
                    @unknown default:
                        print("unknown default", newPhase)
                    }
                }
        }
    }
}
