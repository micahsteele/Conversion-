//
//  ContentView.swift
//  Time Conversion
//
//  Created by Micah Steele on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var time = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @FocusState private var inputIsFocused: Bool
        
    let timeType = ["Seconds", "Minutes", "Hours", "Days", "Weeks"]
    
    var result: String {
        let inputToMinuteMultiplier: Double
        let minuteToOutputMultiplier: Double
        
        switch inputUnit {
        case "Minutes":
            inputToMinuteMultiplier = 60
        case "Hours":
            inputToMinuteMultiplier = 3_600
        case "Days":
            inputToMinuteMultiplier = 86_400
        case "Weeks":
            inputToMinuteMultiplier = 604_800
        default:
            inputToMinuteMultiplier = 1
        }
        
        switch outputUnit {
        case "Minutes":
            minuteToOutputMultiplier = 0.016_666_7
        case "Hours":
            minuteToOutputMultiplier = 0.000_277_778
        case "Days":
            minuteToOutputMultiplier = 0.000_011_574
        case "Weeks":
            minuteToOutputMultiplier = 0.000_001_653_4
        default:
            minuteToOutputMultiplier = 1
        }
        
        let inputInMinutes = time * inputToMinuteMultiplier
        let output = inputInMinutes * minuteToOutputMultiplier
        
        let outputString = output.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Time input", value: $time, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                    Picker("Convert From:", selection: $inputUnit) {
                        ForEach(timeType, id: \.self) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Input")
                }
                
                Section {
                    Text("\(result)")
                    Picker("Temp Input", selection: $outputUnit) {
                        ForEach(timeType, id: \.self) {
                            Text("\($0)")
                        }
                    }
                } header : {
                    Text("Result")
                }
            }
            .navigationTitle("Temp Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
