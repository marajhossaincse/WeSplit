//
//  ContentView.swift
//  WeSplit
//
//  Created by Maraj Hossain on 3/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool

    let tipPercentages: [Int] = Array(0 ... 100)

    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)

        let tipValue = billAmount/100 * tipSelection
        let grandTotal = billAmount + tipValue

        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = billAmount/100 * tipSelection
        let grandTotal = billAmount + tipValue

        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Enter Amount", value: $billAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "BDT")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)

                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people.")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip would you like to leave?")
                }

                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "BDT"))
                } header: {
                    Text("Total amount: ")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "BDT"))
                } header: {
                    Text("Amount per person: ")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
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
