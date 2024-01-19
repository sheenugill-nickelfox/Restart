//
//  HomeView.swift
//  Restart
//
//  Created by Nickelfox on 04/01/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingActive:Bool = false
    @State var isAnimating:Bool = false

    var body: some View {
        VStack{
            Spacer()
            //MARk  - HEADER
            ZStack{
                CircleGroupView(shapColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
            }
            
            //MARK - CENTER
            Text(" The time that leads tp mastery is dependent on the intensity of our focus")
                .font(.system(.title3, weight: .light))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            //MARK FOOTER
            Button(action: {
                withAnimation(.easeInOut(duration: 1)){
                    isOnboardingActive = true
                    playSound(sound: "success", type: "m4a")}}, label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system( .title3, design:.rounded))
                    .fontWeight(.bold)
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
           
        })
    }
}

#Preview {
    HomeView()
}
