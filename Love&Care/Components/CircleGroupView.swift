//
//  CircleGroupView.swift
//  Love&Care
//
//  Created by Omar Tharwat on 02/07/2023.
//

import SwiftUI

struct CircleGroupView: View {
    var circleGroupColor : Color = .red
    @State var isAnimated : Bool = false
    var body: some View {
        ZStack{
            Circle()
                .stroke(circleGroupColor.opacity(0.2),lineWidth: 40)
                .frame(width: 260,height: 260,alignment: .center)
            Circle()
                .stroke(circleGroupColor.opacity(0.2),lineWidth: 80)
                .frame(width: 260,height: 260,alignment: .center)
        }//:ZStack
        .scaleEffect(isAnimated ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimated)
        .onAppear{
            isAnimated.toggle()
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView()
    }
}
