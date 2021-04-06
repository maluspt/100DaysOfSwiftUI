//
//  ContentView.swift
//  better-rest
//
//  Created by Maria Luiza Carvalho Sperotto on 05/04/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var wakeUp = defaultWakeTime

    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var bedTime: String {
        calculateBedtime()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }

                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker("Cups", selection: $coffeeAmount) {
                        ForEach(0..<21) { cup in
                            if cup == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(cup) cups")
                            }
                        }
                    }
                }
                Section {
                    Text("Your ideal bedtime is... \(bedTime)")
                }
            }.navigationBarTitle("Better Rest")
        }
    }
    
    func calculateBedtime() -> String {
            let model = SleepCalculator()
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            do {
                let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                
                return formatter.string(from: sleepTime)
            } catch {
                alertTitle = "Error"
                alertMessage = "Sry, there was an error calculating your bedtime."
                return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
