//
//  Colors.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/20/21.
//

import SwiftUI

// MARK: - Color Type

struct ColorType: Hashable {

    // MARK: - Properties

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


    // MARK: - Init

    init(_ swiftUIColor: Color) {
        self.swiftUIColor = swiftUIColor
        self.uiKitColor = nil
    }

    init(_ uiKitColor: UIColor) {
        self.uiKitColor = uiKitColor
        self.swiftUIColor = nil
    }


    // MARK: - Helpers

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
        .allSwiftUIColors: allSwiftUIColors.map { ColorType($0) },
        .swiftUIWarm: warmSwiftUIColors.map { ColorType($0) },
        .swiftUICool: coolSwiftUIColors.map { ColorType($0) },
        .uiKitWarm: warmUIKitColors.map { ColorType($0) },
        .uiKitCool: coolUIKitColors.map { ColorType($0) },
        .uiKitStatic: staticUIKitColors.map { ColorType($0) }
    ]
}
