//
//  CustomModifiers.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

struct FGColorFontModifier: ViewModifier {
    var fgColor: Color
    var size: CGFloat
    var weight: FontWeight
    
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(fgColor)
            .font(.fontDMSansText(ofSize: size, weight: weight))
    }
}
