//
//  CircleGroupView.swift
//  Restart
//
//  Created by Nickelfox on 04/01/24.
//

import SwiftUI

struct CircleGroupView: View {
    @State var shapColor: Color
    @State var ShapeOpacity: Double
    @State var isAnimating:Bool = false
    var body: some View {
        ZStack{
            Circle()
                .stroke(shapColor.opacity(ShapeOpacity),lineWidth: 40)
               .frame(width: 260,height: 260,alignment: .center)
           
            Circle()
                .stroke(shapColor.opacity(ShapeOpacity),lineWidth: 80)
                .frame(width: 260,height: 260,alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5 )
        .animation(Animation.easeOut(duration: 1),value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    ZStack{
        Color(.teal)
            .ignoresSafeArea(.all,edges: .all)
        CircleGroupView(shapColor: .white, ShapeOpacity: 0.2)
    }
}
