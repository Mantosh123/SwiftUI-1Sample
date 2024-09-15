//
//  AddExpenseView.swift
//  MyExpense
//
//  Created by Mantosh Kumar on 15/09/24.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    
    var expances = Expances()
    
    var body: some View {
        
        var types = ["Personal", "Business", "Friend"]
        
        NavigationStack {
            Form {
                TextField("Add Expense Name", text: $name)

                Picker("Select Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField ("Amount", value: $amount, format: .currency(code: "Rs"))
                    .keyboardType(.decimalPad)
                
            }.navigationTitle("Add new Expense")
                .toolbar{
                    Button("Add") {
                        let myExpance = ExpanceItem(name: name, type: type, amount: amount)
                        expances.items.append(myExpance)
                        dismiss()
                    }
                }
        }
    }
}

#Preview {
    AddExpenseView()
}
