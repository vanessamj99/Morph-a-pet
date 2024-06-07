//
//  VirtualPetApp.swift
//  VirtualPet Watch App
//
//  Created by Vanessa Johnson on 6/1/24.
//

import SwiftUI

@main
struct VirtualPet_Watch_AppApp: App {
    @StateObject private var sharedData = SharedData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(sharedData)
        }
    }
}
