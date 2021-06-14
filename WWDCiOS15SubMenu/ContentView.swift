//
//  ContentView.swift
//  WWDCiOS15SubMenu
//
//  Created by Marlon Raskin on 6/14/21.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedColor: Color = .pink
    @State private var previousColor: [Color] = [.pink]

    var body: some View {
        NavigationView {
            VStack {
                selectedColor
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
                    HStack(spacing: 6) {
                        Image(systemName: "trash")
                        Text("Clear Previous Color")
                    }
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
                    Text("\(selectedColor.description.capitalized(with: .current))")
                        .frame(width: 200.0)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(selectedColor)
                }
            }
        }
        .accentColor(validAccentColor)
    }

    private var validAccentColor: Color {
        withAnimation {
            switch selectedColor {
            case .pink, .red, .orange, .yellow, .blue, .cyan, .teal, .mint, .indigo, .green, .purple, .primary:
                return selectedColor
            default:
                return .primary
            }
        }
    }

    private var borderColor: Color {
        withAnimation {
            switch selectedColor {
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
