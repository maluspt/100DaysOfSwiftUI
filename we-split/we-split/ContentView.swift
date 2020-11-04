//
//  ContentView.swift
//  we-split
//
//  Created by Maria Luiza Carvalho Sperotto on 04/11/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelected = Double(tipPercentages[tipPercentage])
        let amountValue = Double(checkAmount) ?? 0
        let tipValue = amountValue / 100 * tipSelected
        let grandTotal = amountValue + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountWithTips: Double {
        let tipSelected = Double(tipPercentages[tipPercentage])
        let amountValue = Double(checkAmount) ?? 0
        let tipValue = amountValue / 100 * tipSelected
        let grandTotal = amountValue + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                
                    TextField("Number of people", text: $numberOfPeople)
                            .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount with tips")) {
                    Text("$\(totalAmountWithTips, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("we split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
