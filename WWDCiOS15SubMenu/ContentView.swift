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

    init() {
        let startingColor = ColorType(swiftUIColor: .pink, uiKitColor: nil)
        _selectedColor = State(initialValue: startingColor)
        _previousColor = State(initialValue: [startingColor])
    }

    var body: some View {
        NavigationView {
            VStack {
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
                    Text("\(selectedColor.name)")
                        .frame(width: 200.0)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(validAccentColor)
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
