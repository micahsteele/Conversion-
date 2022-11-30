//
//  ContentView.swift
//  Time Conversion
//
//  Created by Micah Steele on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var selectedUnits = 0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.miles, UnitLength.meters, UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    ]
        
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Time input", value: $input, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                    } header: {
                        Text("Amount to Convert")
                    }
                
                Picker("Conversions:", selection: $selectedUnits) {
                    ForEach(0..<conversions.count) {
                        Text(conversions[$0])
                    }
                }
                Picker("Convert From", selection: $inputUnit) {
                            ForEach(unitTypes[selectedUnits], id: \.self) {
                                Text(formatter.string(from: $0).capitalized)
                            }
                }
                Picker("Convert To", selection: $outputUnit) {
                            ForEach(unitTypes[selectedUnits], id: \.self) {
                                Text(formatter.string(from: $0).capitalized)
                            }
                }
                
                Section {
                    Text("\(result)")
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
            onChange(of: selectedUnits) { newSelection in
                let units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
