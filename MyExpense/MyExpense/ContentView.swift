//
//  ContentView.swift
//  MyExpense
//
//  Created by Mantosh Kumar on 14/09/24.
//

import SwiftUI

struct ExpanceItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expances {
    var items = [ExpanceItem]() {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                let expances = UserDefaults.standard.set(encodedData, forKey: "savedExpances")
            }
        }
    }
    
    init () {
        if let savedItems = UserDefaults.standard.data(forKey: "savedExpances") {
            if let decodedItems = try? JSONDecoder().decode([ExpanceItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView: View {
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State var expances = Expances()
    @State var isVisibleExpanceView = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    ForEach(expances.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading, content: {
                                Text(item.name).font(.headline)
                                Text(item.type).font(.subheadline)
                            })
                           Spacer()
                            Text(item.amount, format: .currency(code: "IN"))
                        }
                    }
                    .onDelete(perform: removeRow)
                }
                
            }.navigationTitle("MyExpance")
                .toolbar {
                    Button("Add Expances", systemImage: "plus") {
//                        let expance = ExpanceItem(name: " Juhi Medicine", type: "Medical", amount: 200)
//                        expances.items.append(expance)
                        isVisibleExpanceView = true
                         
                    }.sheet(isPresented: $isVisibleExpanceView, content: {
                        AddExpenseView(expances: expances)
                    })
                    
                }
        }
    }
    
    func removeRow(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
