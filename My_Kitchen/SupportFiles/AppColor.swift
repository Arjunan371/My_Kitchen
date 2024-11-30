//
//  AppColor.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

struct AppColor {
    static let whiteAndBlack: Color = Color(uiColor: UIColor(named: "backgroundColor") ?? .white)
    static let blackAndWhite: Color = Color(uiColor: UIColor(named: "blackAndWhite") ?? .white)
    static let appGradient: [Color] = [Color(hex: "#009BBD"), Color(hex: "#085783")]
    static let white: Color = Color.white
}
