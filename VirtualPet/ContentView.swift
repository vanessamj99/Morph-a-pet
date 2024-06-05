//
//  ContentView.swift
//  VirtualPet
//
//  Created by Vanessa Johnson on 6/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Button("Show Alert") {
                       showingAlert = true
                   }
                   .alert("Important message", isPresented: $showingAlert) {
                       Button("OK", role: .cancel) { }
                   }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
