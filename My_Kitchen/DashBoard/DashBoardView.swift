//
//  DashBoardView.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

struct DashBoardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                appGradientView
                    .edgesIgnoringSafeArea(.all)
                TabView(
                    content:  {
                        HomeView()
                            .tabItem { Label("Home", systemImage: "house.fill") }
                        FavouriteView()
                            .tabItem { Label("Favourite", systemImage: "star.fill") }
                        CartView()
                            .tabItem { Label("Cart", systemImage: "cart") }
                    })
            }
        }
    }
}

#Preview {
    DashBoardView()
}
