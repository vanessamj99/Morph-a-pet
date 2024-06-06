//
//  SliderGame.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/3/24.
//

import SwiftUI

struct SliderGame: View {
    @State private var ballPosition: CGPoint = CGPoint(x: 20, y: 10)
    @State private var ballVelocity: CGPoint = CGPoint(x: 0.1, y: -0.1)
    @State private var barPosition: CGPoint = CGPoint(x: 100, y: 170)
    @State private var isGameRunning = false
    @State private var backToMain = false
    @State private var isGameOver = false
    @State private var score = 0
    @State private var showingAlert = false
    @State private var goToContentView = false
    @State private var startGameButton = false
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                if(startGameButton){
                    Text("Score: \(score)").position(CGPoint(x: 38, y: -16))
                    Circle().fill(Color.teal).frame(width: 20,height: 20).position(ballPosition)
                    Rectangle()
                        .fill(Color.teal)
                        .frame(width: 40, height: 10)
                        .position(barPosition)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    barPosition.x = value.location.x
                                }
                        )
                }
                else{
                    VStack{
                        if(isGameOver){
                            Text("Game Over!").font(.title).foregroundStyle(Color.teal)
                            Text("Your score was: \(score)").foregroundStyle(Color.teal).font(.system(size: 10))
                            Text("Jellybean will get \(score) happiness points").foregroundStyle(Color.teal).font(.system(size: 10))
                        }
                        Button("Start Game"){
                            startGameButton = true
                            startGame()
                        }.padding().foregroundStyle(Color.teal).buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)){
                            Text("Back to Jellybean").padding().foregroundStyle(Color.teal)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                if(startGameButton){
                    updateBallPosition()
                    checkForCollision()
                }
            }
        }
        
    }
    
    
    
    func startGame() {
        isGameRunning = true
        ballPosition = CGPoint(x: 30, y: 10)
        ballVelocity = CGPoint(x: 0.6, y: -0.6)
        score = 0
    }
    
    func updateBallPosition() {
        ballPosition.x +=  ballVelocity.x
        ballPosition.y += ballVelocity.y
    }
    
    func checkForCollision() {
        if(ballPosition.y < barPosition.y - 10 && ballPosition.y > barPosition.y - 14 && ballPosition.x > barPosition.x - 16 ) {
            ballVelocity.y *= -1
            score += 1
        }
        if(ballPosition.y < -40){
            ballVelocity.y *= -1
        }
        if(ballPosition.x > 190 || ballPosition.x < 8){
            ballVelocity.x *= -1
        }
        if(ballPosition.y > 180){
            isGameOver = true
            showingAlert = true
            isGameRunning = false
            startGameButton = false
            sharedData.happiness += Double(score)
        }
    }
}

#Preview {
    SliderGame()
}
