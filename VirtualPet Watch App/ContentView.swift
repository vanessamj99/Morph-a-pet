//
//  ContentView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/1/24.
//

import SwiftUI
import Foundation

class SharedData: ObservableObject {
    @Published var life: Double = 75
    @Published var maxLife: Double = 100
    @Published var hunger: Double = 70
    @Published var happiness: Double = 80
    @Published var cleanliness: Double = 100
    @Published var bathroom: Double = 0
    @Published var name: String = "Jellybean"
}

struct ContentView: View {
    @StateObject private var sharedData = SharedData()
//    let pet: Pet = Pet(name: "Jellybean", life: sharedData.life, maxLife: 100, hunger: 100, happiness: 100, cleanliness: 100, bathroom: 0)
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Text(sharedData.name)
                HStack{
                    Image("heart").scaledToFit()
                    ProgressView(value: (sharedData.life/sharedData.maxLife), total: 1).progressViewStyle(LinearProgressViewStyle(tint: Color.red))
                }
                AnimatedSpriteView().frame(width:80, height: 80)
                ScrollView(.horizontal) {
                    HStack{
                        VStack{
                            Text("Happy").font(.system(size: 14))
                            NavigationLink(destination: SliderGame().navigationBarBackButtonHidden(true)){
                                ProgressView(value: (sharedData.happiness/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Hungry").font(.system(size: 14))
                            NavigationLink(destination: FeedingView()){
                                ProgressView(value: (sharedData.hunger/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Clean").font(.system(size: 14))
                            NavigationLink(destination: SliderGame()){
                                ProgressView(value: (sharedData.cleanliness/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Bathroom").font(.system(size: 14))
                            NavigationLink(destination: SliderGame()){
                                ProgressView(value: (sharedData.bathroom/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                    }
                }
            }
            .padding()
            Spacer()
            Spacer()
        }.environmentObject(sharedData)
    }
}




#Preview {
    ContentView()
}
