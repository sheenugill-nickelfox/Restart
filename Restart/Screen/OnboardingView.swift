//
//  OnboardingView.swift
//  Restart
//
//  Created by Nickelfox on 04/01/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingActive:Bool = true
    
    @State var isAnimating:Bool = false
    
    @State private var ButtonWidth:Double = UIScreen.main.bounds.width - 80
    
    @State private var buttonOffset:CGFloat = 0
    @State private var imageOffset:CGSize = .zero //CGSize(width:0,height:0)
    @State private var indicatorOpacity:Double = 1.0
    @State private var textTitle:String = "Share."
    
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing: 20){
                
                Spacer()
                //Mark -  HEADER
                VStack(spacing:0){
                    Text(textTitle)
                        .font(.system(size: 69,weight: .heavy))
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                         It's not how much we give but how much love we put into giving.
                         """)
                    .font(.system(.title3,weight: .light))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                }//End of Header Vstack
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                
                
                //Mark - CENTER
                ZStack{
                    CircleGroupView(shapColor: .white, ShapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 0.5),value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y:0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                if(abs(imageOffset.width) <= 150){
                                    imageOffset = gesture.translation
                                    withAnimation(Animation.linear(duration:0.25)){
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    
                                    }
                                }
                            }
                            .onEnded{ gesture in
                                imageOffset = .zero
                                withAnimation(Animation.linear(duration:0.25)){
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                    
                                }
                            })
                        .animation(Animation.easeOut(duration: 1),value: imageOffset)
                        
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44,weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 1)
                            .delay(2),value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,alignment: .bottom
                )
                
                Spacer()
                // Mark - FOOTER
                ZStack{
                    //Mark - BACKGROUND
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    //Mark - CALL TO ACTION (STATIC)
                    Text("GET STARTED")
                        .font(.system(.title3,design:.rounded,weight:.bold))
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    // MARK - DYNAMIC WIDTH
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width:buttonOffset+80,height: 80)
                        Spacer()
                    }
                    
                    // MARK - DRAGGABLE
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }// End of Draggable ZStack
                        .frame(width: 80,height: 80,alignment: .center)
                       .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= ButtonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)){
                                        if(buttonOffset > ButtonWidth / 2){
                                            isOnboardingActive = false
                                            playSound(sound: "chimeup", type: "mp3")
                                            
                                        }else{
                                            buttonOffset = 0
                                        }
                                    }
                                })
                          
                        Spacer()
                    }// End Of Draggable Hstack

                }//END OF FOOTER ZSTACK
                .frame(width: ButtonWidth,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 0.5),value: isAnimating)
                
            }// END OF OUTER VSTACK
        }
        .onAppear(){
            isAnimating = true
        }
    }
}

#Preview {
    OnboardingView()
}
