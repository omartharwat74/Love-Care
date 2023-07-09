//
//  Home.swift
//  Love&Care
//
//  Created by Omar Tharwat on 25/06/2023.
//

import SwiftUI

struct Home: View {
    @AppStorage("isOnBoarding") var isOnBoarding : Bool = true
    @State var isMove : Bool = false
    let feedBack = UINotificationFeedbackGenerator()
    var body: some View {
        VStack(alignment: .center,spacing: 30){
            //MARK: - Header
            ZStack{
                CircleGroupView(circleGroupColor:.gray)
                Image("baby-boy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,alignment: .center)
                    .offset(y: isMove ? 30 : -30)
                    .animation(.easeOut(duration: 2.5).repeatForever(), value: isMove)
            }//:ZStack
            //MARK: - Center
            Text("Having children just puts the whole world into perspective. Everything else just disappears")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding()
            //MARK: - Footer
            Button {
                isOnBoarding.toggle()
                playSound (soundFile: "success", soundType: "m4a")
                    feedBack.notificationOccurred(.success)
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("restart")
                    .font (.system(size: 25, design: .rounded))
                    .fontWeight(.bold)
            }
            .accentColor(.blue)
            .buttonStyle (.borderedProminent)
            .buttonBorderShape (.capsule)
        }//:VStack
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                isMove.toggle()
            }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
