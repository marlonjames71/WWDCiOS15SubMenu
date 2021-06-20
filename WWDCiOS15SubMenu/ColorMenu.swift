//
//  ColorMenu.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/14/21.
//

import SwiftUI

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
