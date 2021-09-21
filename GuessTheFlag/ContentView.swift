//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nicholas Verrico on 9/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries =  ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
    var body: some View {
    
        
        ZStack {
            // Screen background, first item to push to back of Z-Stack
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
               
                VStack{
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
                    }){Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(
                                Color.black,
                                lineWidth: 1
                            )
                        )
                        .shadow(
                            color: .black,
                            radius: 2
                        )
                    }
                    Spacer()
                }
            }.padding(.top, 50)
            .alert(isPresented: $showingScore){
                Alert(
                    title:
                        Text(scoreTitle).font(.largeTitle),
                    message:
                        Text("Score: \(score)"),
                    dismissButton:
                        .default(Text("Continue")){
                            self.askQuestion()
                        }
                )
            }
        }.statusBar(hidden: true)
    }
    
    func flagTapped(_ number: Int){
            if number == correctAnswer{
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score -= 1
            }
            showingScore = true
        }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
