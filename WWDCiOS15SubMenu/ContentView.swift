//
//  ContentView.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/14/21.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedColor: ColorType
    @State private var previousColor: [ColorType]
    let colorBarColors: [(color: Color, opacity: CGFloat)] = [
        (.red, 1.0),
        (.orange, 0.85),
        (.yellow, 0.70),
        (.green, 0.60),
        (.cyan, 0.50),
        (.blue, 0.35),
        (.indigo, 0.20),
        (.pink, 0.10),
        (.purple, 0.02)
    ]

    init() {
        let startingColor = ColorType(.pink)
        _selectedColor = State(initialValue: startingColor)
        _previousColor = State(initialValue: [startingColor])
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    selectedColor.color
                        .frame(height: 275)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(borderColor)
                        )
                        .onChange(of: _selectedColor.wrappedValue) { newColor in
                            _previousColor.wrappedValue.append(newColor)
                            if previousColor.count >= 3 {
                                previousColor.removeFirst()
                            }
                            print(previousColor)
                        }
                    VStack(alignment: .trailing, spacing: 8.0) {
                        Text(selectedColor.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text(selectedColor.isSwiftUIColor ? "SwiftUI Color" : "UIKit Color")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8.0)
                    .padding(.horizontal, 12.0)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12.0, style: .continuous))
                    .padding(8.0)
                }
                Spacer()
                Button {
                    previousColor.removeFirst()
                    print(previousColor)
                } label: {
                    Label("Clear Previous Color", systemImage: "trash")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .padding(.bottom, 100.0)
                .disabled(previousColor.count < 2)
            }
            .padding()
            .navigationTitle("Color Swatch")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ColorMenu(selectedColor: $selectedColor, previousColor: $previousColor)
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 4.0) {
                        ForEach(colorBarColors, id: \.color) { colorBarColor in
                            Circle()
                                .fill(colorBarColor.color)
                                .opacity(colorBarColor.opacity)
                                .frame(width: 12.0, height: 12.0)
                        }
                    }
                    .frame(width: 175.0)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
        .accentColor(validAccentColor)
    }

    private var validAccentColor: Color {
        withAnimation {
            switch selectedColor.color {
            case .black, .white:
                return .primary
            default:
                return selectedColor.color
            }
        }
    }

    private var borderColor: Color {
        withAnimation {
            switch selectedColor.color {
            case Color(uiColor: .systemBackground), .black, .primary, .white:
                return .gray
            default:
                return .clear
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
