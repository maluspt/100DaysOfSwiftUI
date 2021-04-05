import SwiftUI

struct EmojiButton: View {
    var emoji: String

    var body: some View {
        ZStack {
            Color.gray
            Text(emoji)
                .font(Font.system(size: 48))
        }
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {

    let moves = ["✊","✋","✌️"]
    @State var currentChoice = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0
    @State var isPresenting = false
    @State var alertTitle = ""
    @State var rounds = 0

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                VStack {
                    Text("Round: \(rounds)")
                    Text("Select a move")
                        .font(.title)
                }

                HStack(spacing: 20) {
                    ForEach(0..<moves.count) { number in
                        Button(action: {
                            self.playMove(number)
                        }) {
                            EmojiButton(emoji: self.moves[number])
                        }
                    }
                }
                Text("Score: \(score)")
                
                Spacer()
                
            }.alert(isPresented: $isPresenting) {
                Alert(title: Text(alertTitle),
                      message: Text("Score: \(score). App move was: \(moves[currentChoice])"),
                      dismissButton: .default(Text("OK")) {
                        self.nextRound()
                      })
        }.padding(.top, 30)
    }
}

    func playMove(_ number: Int) {
        let app = moves[currentChoice]
        let player = moves[number]

        let playerWins =
               (app == "✊" && player == "✋")
            || (app == "✋" && player == "✌️")
            || (app == "✌️" && player == "✊")
        
        let playerTies = app == player

        if playerWins {
            score += 1
            rounds += 1
            alertTitle = "Well done"
        } else if playerTies {
            alertTitle = "Tied!"
            rounds += 1
        } else {
            score = max(0, score - 1)
            alertTitle = "Nope, not good"
            rounds += 1
        }
        
        isPresenting = true
        
        
        if rounds == 10 {
            alertTitle = "Game over!"
            rounds = 0
            score = 0
        }
    }

    private func nextRound() {
        currentChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

