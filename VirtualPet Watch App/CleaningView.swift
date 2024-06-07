//
//  CleaningView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/6/24.
//

import SwiftUI

struct CleaningView: View {
    @State private var isPulsing = false
    @State private var cleaning = false
    @State private var goingToBathroom = false
    
    @State private var bathroomButtonVisible = true
    @State private var cleanButtonVisible = true
    
    @EnvironmentObject var sharedData: SharedData
    
    @State private var currentFrame = 0
    let spriteImages = (0...4).map { "bathroom\($0)" } // Adjust the range to the number of your frames
    let animationDuration = 0.9 // Time interval between frames
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
//            GeometryReader{ geometry in
            VStack{
                HStack{
                    
                    if(cleanButtonVisible){
                        Button(action: {
                            cleaning = true
                            cleanButtonVisible = false
                            sharedData.cleanliness = 100
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                cleaning = false
                                cleanButtonVisible = true
                            }
                        }, label: {
                            Text("Clean")
                        }).padding().foregroundStyle(Color.teal).buttonStyle(PlainButtonStyle()).background(Color.indigo)
                    }
                    if(bathroomButtonVisible){
                        Button(action: {
                            goingToBathroom = true
                            bathroomButtonVisible = false
                            sharedData.bathroom = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                goingToBathroom = false
                                bathroomButtonVisible = true
                            }
                        }, label: {
                            Text("Bathroom")
                        }).padding().foregroundStyle(Color.teal).buttonStyle(PlainButtonStyle()).background(Color.indigo)
                    }
                }
                if(cleaning){
                    AnimatedSpriteView()
                        .overlay(
                            ForEach(0..<10, id: \.self){ _ in
                                Image("bubble").resizable().frame(width: 20, height: 20).position(CGPoint(x: Double.random(in: 0...80), y: Double.random(in: 30...70)))
                                    .scaleEffect(x: isPulsing ? 1.1 : 1.0, y: isPulsing ? 1.1 : 1.0)
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            isPulsing.toggle() // Toggle the state to start the animation
                                        }
                                    }
                            }
                        )
                }
                else if(goingToBathroom){
                    Image(spriteImages[currentFrame])
                        .scaledToFit()
                        .onAppear(perform: startAnimation)
                }
                else{
                    AnimatedSpriteView()
                }
            }
            }.environmentObject(sharedData)
        }
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { timer in
            currentFrame = (currentFrame + 1) % spriteImages.count
        }
        currentFrame = 0
    }
    
    }

#Preview {
    CleaningView()
}