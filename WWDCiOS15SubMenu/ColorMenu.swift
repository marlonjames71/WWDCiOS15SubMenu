//
//  ColorMenu.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/14/21.
//

import SwiftUI

struct ColorMenu: View {

    @Binding var selectedColor: Color
    @Binding var previousColor: [Color]

    var body: some View {
        Menu {
            if previousColor.count > 1 {
                if let prevColor = previousColor.first {
                    Button {
                        selectedColor = prevColor
                        previousColor.removeFirst()
                    } label: {
                        Label("Previous Color (\(prevColor.description.capitalized(with: .current)))", systemImage: "arrow.turn.up.left")
                    }
                }
                Divider()
            }
            Menu("Warm Colors") {
                Picker("Warm Colors", selection: $selectedColor) {
                    Text("Pink").tag(Color.pink)
                    Text("Orange").tag(Color.orange)
                    Text("Yellow").tag(Color.yellow)
                    Text("Red").tag(Color.red)
                }
            }
            Menu("Cool Colors") {
                Picker("Cool Colors", selection: $selectedColor) {
                    Text("Blue").tag(Color.blue)
                    Text("Cyan").tag(Color.cyan)
                    Text("Indigo").tag(Color.indigo)
                    Text("Teal").tag(Color.teal)
                    Text("Mint").tag(Color.mint)
                    Text("Green").tag(Color.green)
                    Text("Purple").tag(Color.purple)
                }
            }
            Menu("System Colors") {
                Picker("System Colors", selection: $selectedColor) {
                    Text("Primary").tag(Color.primary)
                    Text("Secondary").tag(Color.secondary)
                    Menu("Grays") {
                        Picker("Grays", selection: $selectedColor) {
                            Text("Gray").tag(Color.gray)
                            Text("System Gray").tag(Color(uiColor: .systemGray))
                            Text("System Gray 2").tag(Color(uiColor: .systemGray2))
                            Text("System Gray 3").tag(Color(uiColor: .systemGray3))
                            Text("System Gray 4").tag(Color(uiColor: .systemGray4))
                            Text("System Gray 5").tag(Color(uiColor: .systemGray5))
                            Text("System Gray 6").tag(Color(uiColor: .systemGray6))
                        }
                    }
                    Menu("Background Colors") {
                        Picker("Grays", selection: $selectedColor) {
                            Text("System Background").tag(Color(uiColor: .systemBackground))
                            Text("System Secondary Background").tag(Color(uiColor: .secondarySystemBackground))
                        }
                    }

                    Text("Tertiary Label").tag(Color(uiColor: .tertiaryLabel))
                    Text("Quaternary Label").tag(Color(uiColor: .quaternaryLabel))
                }
            }
            Menu("Monochrome Colors") {
                Picker("Monochrome Colors", selection: $selectedColor) {
                    Text("White").tag(Color.white)
                    Text("Black").tag(Color.black)
                    Text("Gray").tag(Color.gray)
                }
            }
        } label: {
            Image(systemName: "list.triangle")
                .symbolRenderingMode(.hierarchical)
                .tint(.primary)
        }
    }
}

struct ColorMenu_Previews: PreviewProvider {
    static var previews: some View {
        ColorMenu(selectedColor: .constant(.pink), previousColor: .constant([]))
    }
}
