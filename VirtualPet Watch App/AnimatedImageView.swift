//
//  AnimatedImageView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/3/24.
//
import UIKit
import SwiftUI

struct AnimatedSpriteView: View {
    @State private var currentFrame = 0
    let spriteImages = (0...2).map { "bird\($0)" } // Adjust the range to the number of your frames
    let animationDuration = 1.0 // Time interval between frames

    var body: some View {
        Image(spriteImages[currentFrame])
            .resizable()
            .scaledToFit().frame(width: 80, height: 80)
            .onAppear(perform: startAnimation)
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { timer in
            currentFrame = (currentFrame + 1) % spriteImages.count
        }
    }
}


#Preview {
    AnimatedSpriteView()
}
