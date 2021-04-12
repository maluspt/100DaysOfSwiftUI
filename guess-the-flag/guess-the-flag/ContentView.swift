//
//  ContentView.swift
//  guess-the-flag
//
//  Created by Maria Luiza Carvalho Sperotto on 26/03/21.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 3)
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...10)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertText = ""
    @State private var score = 0
    
    @State private var spinAmount: Double = 0
    @State private var opacityValue = 1.0
    @State private var animationAmount: CGFloat = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("SCORE: \(score)")
                        .foregroundColor(.white)
                        .padding()
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
            }
            
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        
                    }) {
                        FlagImage(country: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.correctAnswer == number ? self.spinAmount : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.correctAnswer == number ? 1 : self.opacityValue)
                    .animation(.default)
                        
                        
                }
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(alertText),
                  dismissButton: .default(Text("ok")))
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.opacityValue = 1.0
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            alertText = "Your score is: \(score)"
            score += 1
            withAnimation {
                self.spinAmount += 360
                self.opacityValue = 0.25
            }
        } else {
            scoreTitle = "Wrong"
            alertText = "This is the flag of \(countries[number])"
            score -= 1
            self.animationAmount = 2
        }

        showingScore = true
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
