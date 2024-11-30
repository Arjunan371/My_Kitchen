//
//  Extensions.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

enum FontWeight: String {
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
}

extension Font {
    static func fontDMSansText(ofSize: CGFloat, weight: FontWeight = .regular) -> Font {
        return Font.custom("DMSans-\(weight.rawValue)", size: ofSize)
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func fgFont(size: CGFloat = 14, isDynamic: Bool = true, weight: FontWeight = .regular, color: Color = AppColor.whiteAndBlack) -> some View {
        self.modifier(FGColorFontModifier(fgColor: color, size: isDynamic ? .ratioHeightBasedOniPhoneX(size) : size, weight: weight))
    }
    
    func cornerRadiusCustom(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .mask(self)
    }
    
    var appGradientView: some View {
        LinearGradient(gradient: Gradient(colors: AppColor.appGradient), startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea(.all)
        
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension UIApplication {
    func hideKeyBoard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension CGFloat{
    
    static let screenHeight = UIScreen.main.bounds.height
    
    static let screenWidth  = UIScreen.main.bounds.width
    
    static func ratioHeightBasedOniPhoneX(_ val: CGFloat) -> CGFloat{
        return self.screenHeight * (val/812)
    }
    static func ratioWidthBasedOniPhoneX(_ val: CGFloat) -> CGFloat{
        return self.screenWidth * (val/375)
    }
    
    static func factionHeightBasedOnScreen(_ val: CGFloat) -> CGFloat{
        return self.screenHeight * val
    }
    static func factionWidthBasedOnScreen(_ val: CGFloat) -> CGFloat{
        return self.screenWidth * val
    }
}
