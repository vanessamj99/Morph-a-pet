//
//  ContentView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/1/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let pet: Pet = Pet(name: "Jellybean", life: 75, maxLife: 100, hunger: 100, happiness: 100, cleanliness: 100, bathroom: 0)
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Text(pet.name)
                HStack{
                    Image("heart").scaledToFit()
                    ProgressView(value: (pet.life/pet.maxLife), total: 1).progressViewStyle(LinearProgressViewStyle(tint: Color.red))
                }
                AnimatedSpriteView().frame(width:80, height: 80)
                ScrollView(.horizontal) {
                    HStack{
                        VStack{
                            Text("Happy").font(.system(size: 14))
                            NavigationLink(destination: SliderGame().navigationBarBackButtonHidden(true)){
                                ProgressView(value: (pet.happiness/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Hungry").font(.system(size: 14))
                            NavigationLink(destination: SliderGame()){
                                ProgressView(value: (pet.hunger/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Clean").font(.system(size: 14))
                            NavigationLink(destination: SliderGame()){
                                ProgressView(value: (pet.cleanliness/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                        VStack{
                            Text("Bathroom").font(.system(size: 14))
                            NavigationLink(destination: SliderGame()){
                                ProgressView(value: (pet.bathroom/100), total: 1).progressViewStyle(CircularProgressViewStyle(tint: Color.green)).frame(width: 24, height: 24).padding().scaleEffect(0.7)
                            }.clipShape(Circle()).frame(width: 34, height: 34)
                        }
                    }
                }
            }
            .padding()
            Spacer()
            Spacer()
        }
    }
}




#Preview {
    ContentView()
}
