//
//  ColorMenu.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/14/21.
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

    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
    }
}


// MARK: - Color Collection

struct ColorCollection {
    enum Collection {
        case swiftUIWarm
        case swiftUICool
        case uiKitWarm
        case uiKitCool
        case uiKitStatic
    }

    // Dynamic SwiftUI Colors
    static let warmSwiftUIColors: [Color] = [.red, .orange, .yellow, .pink, .brown]
    static let coolSwiftUIColors: [Color] = [.blue, .cyan, .teal, .mint, .green, .indigo, .purple]

    // Dynamic UIKit Colors
    static let warmUIKitColors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemPink, .systemBrown]
    static let coolUIKitColors: [UIColor] = [.systemBlue, .systemTeal, .systemGreen, .systemIndigo, .systemPurple]

    // Static UIKit Colors
    static let staticUIKitColors: [UIColor] = [.red, .orange, .yellow, .magenta, .purple, .blue, .green, .brown, .cyan, .link]

    static let colorDict: [Collection: [ColorType]] = [
        .swiftUIWarm: warmSwiftUIColors.map { ColorType(swiftUIColor: $0, uiKitColor: nil) },
        .swiftUICool: coolSwiftUIColors.map { ColorType(swiftUIColor: $0, uiKitColor: nil) },
        .uiKitWarm: warmUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) },
        .uiKitCool: coolUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) },
        .uiKitStatic: staticUIKitColors.map { ColorType(swiftUIColor: nil, uiKitColor: $0) }
    ]
}


// MARK: - Color Menu View

struct ColorMenu: View {

    @Binding var selectedColor: ColorType
    @Binding var previousColor: [ColorType]

    var body: some View {
        Menu {
            if previousColor.count > 1 {
                if let prevColor = previousColor.first {
                    Button {
                        selectedColor = prevColor
                        previousColor.removeFirst()
                    } label: {
                        Label("Previous Color (\(prevColor.name))", systemImage: "arrow.turn.up.left")
                    }
                }
                Divider()
            }

            Menu {
                makeSubMenuPicker(
                    with: ColorCollection.colorDict[.swiftUIWarm]!,
                    selection: $selectedColor,
                    label: "Warm Colors",
                    iconName: .warm)
                makeSubMenuPicker(
                    with: ColorCollection.colorDict[.swiftUICool]!,
                    selection: $selectedColor,
                    label: "Cool Colors",
                    iconName: .cool)
            } label: {
                Label("SwiftUI Colors", systemImage: IconName.swift.rawValue)
            }

            Menu {
                makeSubMenuPicker(
                    with: ColorCollection.colorDict[.uiKitWarm]!,
                    selection: $selectedColor,
                    label: "Warm Colors",
                    iconName: .warm)
                makeSubMenuPicker(
                    with: ColorCollection.colorDict[.uiKitCool]!,
                    selection: $selectedColor,
                    label: "Cool Colors",
                    iconName: .cool)
                makeSubMenuPicker(
                    with: ColorCollection.colorDict[.uiKitStatic]!,
                    selection: $selectedColor,
                    label: "Static Colors",
                    iconName: .static)
            } label: {
                Label("UIKit Colors", systemImage: IconName.swift.rawValue)
            }
        } label: {
            Image(systemName: "list.triangle")
                .symbolRenderingMode(.hierarchical)
                .tint(.primary)
        }
    }

    enum IconName: String {
        case warm = "sun.and.horizon.fill"
        case cool = "snowflake"
        case swift = "swift"
        case `static` = "circle.and.line.horizontal.fill"
    }

    private func makeSubMenuPicker(with colors: [ColorType],
                                   selection: Binding<ColorType>,
                                   label: String,
                                   iconName: IconName) -> some View {
        Menu {
            Picker(label, selection: selection) {
                ForEach(colors, id: \.color) { colorType in
                    Text(colorType.name).tag(colorType)
                }
            }
        } label: {
            Label(label, systemImage: iconName.rawValue)
        }
    }
}

struct ColorMenu_Previews: PreviewProvider {
    static var previews: some View {
        ColorMenu(selectedColor: .constant(ColorType(swiftUIColor: .pink, uiKitColor: nil)), previousColor: .constant([]))
    }
}
