//
//  ContentView.swift
//  AddAndRemoveRow
//
//  Created by Mantosh Kumar on 14/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { rowValue in
                        Text("I am mantosh \(rowValue)")
                    }
                    .onDelete(perform: removeRow)
                }
                Button("Add new Row") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.navigationTitle("Add and Remove Row")
        }
    }
    
    func removeRow(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
