//
//  ContentView.swift
//  challenge-01
//
//  Created by Maria Luiza Carvalho Sperotto on 24/11/20.
//

import SwiftUI

struct ContentView: View {
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var firstUnit = 0
    @State private var secondUnit = 0
    @State private var firstValue = ""
    var valueConverted: Double {
        let firstUnitSelected = units[firstUnit]
        let secondUnitSelected = units[secondUnit]
        if firstUnitSelected == "Celsius" && secondUnitSelected == "Kevin" {
            let newValue = Double(firstValue) ?? 0 + 273
            return newValue
        } else if firstUnitSelected == "Kevin" && secondUnitSelected == "Celsius" {
            let newValue = Double(firstValue) ?? 0 - 273
            return newValue
        } else if firstUnitSelected == "Celsius" && secondUnitSelected == "Fahrenheit" {
            let newValue = Double(firstValue) ?? 0 * 1.8 + 32
            return newValue
        } else if firstUnitSelected == "Fahrenheit" && secondUnitSelected == "Celsius" {
            let newValue = (Double(firstValue) - 32) / 1.8
            return newValue
        }
        
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select a unit and value to convert")) {
                    Picker("Unit", selection: $firstUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    
                    TextField("Value", text: $firstValue)
                }
                
                Section(header: Text("Select a unit to convert your value")) {
                    Picker("Unit", selection: $secondUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }

                    }
                }
                
                Section(header: Text("Value converted")) {
                    Text("\(valueConverted, specifier: "%.2f")")

                }
            }
            
            .navigationTitle("temperature converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
