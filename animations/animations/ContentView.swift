//
//  ContentView.swift
//  animations
//
//  Created by Maria Luiza Carvalho Sperotto on 12/04/21.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var isShowingRed = false
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded { _ in withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                }
                            })

            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(dragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }.gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    }
            )
            
            VStack {
                Button("Tap me") {
                    withAnimation {
                        self.isShowingRed.toggle()
                    }
                }
                
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)

                }
            }
        }}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
