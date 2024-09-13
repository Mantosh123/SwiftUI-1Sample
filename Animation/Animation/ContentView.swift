//
//  ContentView.swift
//  Animation
//
//  Created by Mantosh Kumar on 13/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var animation3dAmount = 0.0
    
    @State private var animableEnabled = false
    @State private var drageAnimationValue = CGSize.zero
        
    @State private var drageLatterAnimAmount = CGSize.zero
    @State private var enabled = false
    
    var letters = Array("Mantosh Kumar")
    
    var body: some View {
        
         VStack {
            Button(" Tapp me") {
                animationAmount += 1
            }
            .padding(30)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            //.blur(radius: animationAmount)
             
             Stepper("Add animation value", value: $animationAmount.animation(), in: 1...20).padding()
             
             Button("3D Animation") {
                 print("3D")
                 withAnimation(.spring(.bouncy(duration: 2))) {
                     animation3dAmount += 360
                 }
             }
             .padding(30)
             .background(.blue)
             .foregroundStyle(.white)
             .clipShape(.circle)
             .rotation3DEffect(.degrees(animation3dAmount), axis: (x: 0, y: 1, z: 1))
                          
             Button("Tap me ") {
                 animableEnabled.toggle()
             }.frame(width: 100, height: 100)
                 .background( animableEnabled ? .purple : .red)
                 .foregroundStyle(.white)
                 .animation(nil, value: animableEnabled)
                 .clipShape( .rect(cornerRadius: animableEnabled ? 40 : 0))
                 .animation(.spring(duration: 2, bounce: 0.9), value: animableEnabled)
             
             // Dragg Card
             LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                 .frame(width: 200, height: 100)
                 .clipShape(.rect(cornerRadius: 20))
                 .shadow(radius: 5)
                 .offset(drageAnimationValue)
                 .gesture(
                    DragGesture()
                        .onChanged { drageAnimationValue = $0.translation}
                        .onEnded { _ in
                            withAnimation(.bouncy) {
                                drageAnimationValue = .zero
                            }
                        }
                 )
             
             HStack(spacing: 0) {
                 ForEach(0..<letters.count, id: \.self) { num in
                     
                     Text(String(letters[num]))
                         .padding(5)
                         .font(.title)
                         .background( enabled ? .red : .orange)
                         .offset(drageLatterAnimAmount)
                         .animation(.linear.delay(Double(num) / 20), value: drageLatterAnimAmount)
                 }
             }.gesture(
                DragGesture()
                    .onChanged { drageLatterAnimAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            drageLatterAnimAmount = .zero
                            enabled.toggle()
                        }
                    }
             )
             
             Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
