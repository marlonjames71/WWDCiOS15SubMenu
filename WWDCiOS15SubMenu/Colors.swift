//
//  Colors.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/20/21.
//

import SwiftUI

// MARK: - Color Type

struct ColorType: Hashable {
    let swiftUIColor: Color?
    let uiKitColor: UIColor?

    var color: Color {
        if let swiftUIColor = swiftUIColor {
            return swiftUIColor
        } else if let uiKitColor = uiKitColor {
            return Color(uiColor: uiKitColor)
        }
        return .blue
    }

    var name: String {
        var name: String = ""

        if let swiftUIColor = swiftUIColor {
            name = swiftUIColor.description.capitalized(with: .current)
        }

        if let uiKitColor = uiKitColor {
            name = "\(uiKitColor.value(forKey: "_systemColorName") ?? "")"
        }

        return name
    }

    var isSwiftUIColor: Bool { swiftUIColor != nil }

    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
    }
}


// MARK: - Color Collection

struct ColorCollection {
    enum Collection {
        case allSwiftUIColors
        case swiftUIWarm
        case swiftUICool
        case uiKitWarm
        case uiKitCool
        case uiKitStatic
    }

    // Dynamic SwiftUI Colors
    static let warmSwiftUIColors: [Color] = [.red, .orange, .yellow, .pink, .brown]
    static let coolSwiftUIColors: [Color] = [.blue, .cyan, .teal, .mint, .green, .indigo, .purple]
    static let allSwiftUIColors: [Color] = (warmSwiftUIColors + coolSwiftUIColors)

    // Dynamic UIKit Colors
    static let warmUIKitColors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemPink, .systemBrown]
    static let coolUIKitColors: [UIColor] = [.systemBlue, .systemTeal, .systemGreen, .systemIndigo, .systemPurple]

    // Static UIKit Colors
    static let staticUIKitColors: [UIColor] = [.red, .orange, .yellow, .magenta, .purple, .blue, .green, .brown, .cyan, .link]

    static let colorDict: [Collection: [ColorType]] = [
        .allSwiftUIColors: allSwiftUIColors.map { ColorType(swiftUIColor: $0, uiKitColor: nil) },
        .swiftUIWarm: warmSwiftUIColors.map { ColorType(swiftUIColor: $0, uiKitColor: nil) },
        .swiftUICool: coolSwiftUIColors.map { ColorType(swiftUIColor: $0, uiKitColor: nil) },
        .uiKitWarm: warmUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) },
        .uiKitCool: coolUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) },
        .uiKitStatic: staticUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) }
    ]
}
