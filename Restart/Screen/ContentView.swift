//
//  ContentView.swift
//  Restart
//
//  Created by Nickelfox on 04/01/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingActive:Bool = true
    var body: some View {
        VStack {
            if isOnboardingActive{
                OnboardingView()
            } else{
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
