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
    let spriteImages = (0...1).map { "blob\($0)" } // Adjust the range to the number of your frames
    let animationDuration = 0.9 // Time interval between frames

    var body: some View {
        Image(spriteImages[currentFrame])
            .scaledToFit()
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
