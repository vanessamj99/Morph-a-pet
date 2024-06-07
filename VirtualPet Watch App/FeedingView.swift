//
//  FeedingView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/5/24.
//

import SwiftUI

struct FeedingView: View {
    @State private var fudgePosition = CGPoint(x: 20, y: 20)
    @State private var fishPosition = CGPoint(x: 20, y: 20)
    @State private var chickenPosition = CGPoint(x: 20, y: 20)
    @State private var carrotPosition = CGPoint(x: 20, y: 20)
    @State private var petPosition = CGPoint(x: 100, y: 100)
    
    @State private var isFudgeVisible = true
    @State private var isFishVisible = true
    @State private var isChickenVisible = true
    @State private var isCarrotVisible = true
    
    @EnvironmentObject var sharedData: SharedData
    
    @State private var fudgeEaten = false
    @State private var fishEaten = false
    @State private var chickenEaten = false
    @State private var carrotEaten = false
    
    @State private var tooFull = false
    
    @State private var currentFrame = 0
    let spriteImages = (0...1).map { "blob\($0)" } // Adjust the range to the number of your frames
    let animationDuration = 0.8 // Time interval between frames
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            GeometryReader { geometry in
                VStack{
                    if(tooFull){
                        Text("Jellybean is too full for that food!").foregroundStyle(Color.black).font(.system(size: 10))
                    }
                    ZStack{
                        Image(spriteImages[currentFrame])
                            .onAppear(perform: startAnimation)
                            .position(petPosition)
                        HStack{
                            if(isFudgeVisible){
                                Image("ice_cream").position(fudgePosition).padding().gesture(
                                    DragGesture().onChanged({ value in
                                        fudgePosition = CGPoint(x: value.location.x, y: value.location.y - 50/2)
                                    }))
                            }
                            if(isFishVisible){
                                Image("fish").position(fishPosition).padding().gesture(DragGesture().onChanged({ value in
                                    fishPosition = CGPoint(x: value.location.x, y: value.location.y)
                                }))
                            }
                            if(isChickenVisible){
                                Image("chicken").position(chickenPosition).padding().gesture(DragGesture().onChanged({ value in
                                    chickenPosition = CGPoint(x: value.location.x, y: value.location.y)
                                }))
                            }
                            if(isCarrotVisible){
                                Image("carrot").position(carrotPosition).padding().gesture(DragGesture().onChanged({ value in
                                    carrotPosition = CGPoint(x: value.location.x, y: value.location.y)
                                }))
                            }
                            
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
                
            }
        }.onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            checkEaten()
        }.environmentObject(sharedData)
    }
    
    func checkEaten(){
        if(!fudgeEaten && (fudgePosition.x > petPosition.x - 30 && fudgePosition.x < petPosition.x + 10) && (fudgePosition.y > petPosition.y - 5 && fudgePosition.y < petPosition.y + 20)){
            isFudgeVisible = false
            fudgeEaten = true
            if(sharedData.hunger + 5 < 100){
                sharedData.hunger += 5
            }
            else{
                tooFull = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                fudgePosition = CGPoint(x: 20, y: 20)
                isFudgeVisible = true
                fudgeEaten = false
                tooFull = false
            }

        }
        else if(!fishEaten && (fishPosition.x > petPosition.x - 80 && fishPosition.x < petPosition.x) && (fishPosition.y > petPosition.y - 5 && fishPosition.y < petPosition.y + 20)){
            isFishVisible = false
            fishEaten = true
            if(sharedData.hunger + 7 < 100){
                sharedData.hunger += 7
            }
            else{
                tooFull = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                fishPosition = CGPoint(x: 20, y: 20)
                fishEaten = false
                isFishVisible = true
                tooFull = false
            }
        }
        else if(!chickenEaten && (chickenPosition.x > petPosition.x - petPosition.x - 30 && chickenPosition.x < petPosition.x - 80) && (chickenPosition.y > petPosition.y - 5 && chickenPosition.y < petPosition.y + 20)){
            isChickenVisible = false
            chickenEaten = true
            if(sharedData.hunger + 4 < 100){
                sharedData.hunger += 4
            }
            else{
                tooFull = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                chickenPosition = CGPoint(x: 20, y: 20)
                isChickenVisible = true
                chickenEaten = false
                tooFull = false
            }
        }
        else if(!carrotEaten && (carrotPosition.x > petPosition.x - petPosition.x - 84 && carrotPosition.x < petPosition.x - petPosition.x - 28) && (carrotPosition.y > petPosition.y - 5 && carrotPosition.y < petPosition.y + 20)){
            isCarrotVisible = false
            carrotEaten = true
            if(sharedData.hunger + 6 < 100){
                sharedData.hunger += 6
            }
            else{
                tooFull = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                carrotPosition = CGPoint(x: 20, y: 20)
                isCarrotVisible = true
                carrotEaten = false
                tooFull = false
            }

        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { timer in
            currentFrame = (currentFrame + 1) % spriteImages.count
        }
    }
    
}

#Preview {
    FeedingView().environmentObject(SharedData())
}
