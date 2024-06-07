//
//  BubbleView.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/6/24.
//

import SwiftUI

struct BubbleData: Identifiable {
    let id = UUID()
    @State var isPulsing = false
    @State var position = CGPoint.zero
}

struct BubbleView: View {
    @Binding var isPulsing: Bool

        var body: some View {
            Image("bubble")
                .resizable()
                .frame(width: 10, height: 10)
                .scaleEffect(x: isPulsing ? 1.1 : 1.0, y: isPulsing ? 1.1 : 1.0)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isPulsing.toggle()
                    }
                }
        }
}

#Preview {
    BubbleView(isPulsing: .constant(false))
}
