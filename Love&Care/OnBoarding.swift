//
//  OnBoarding.swift
//  Love&Care
//
//  Created by Omar Tharwat on 25/06/2023.
//

import SwiftUI

struct OnBoarding: View {
    @AppStorage("isOnBoarding") var isOnBoarding : Bool = true
    @State var isAnimated : Bool = false
    @State var imageOffset : CGSize = CGSize(width: 0.0, height: 0.0)
    @State var buttonOffset : CGFloat = 0.0
    @State var buttonWidth : Double = UIScreen.main.bounds.width - 80
    @State var isHidden : Bool = false
    let feedBack = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all)
            VStack{
                VStack{
                    //MARK: - Header
                    Text(abs(imageOffset.width) > 0 ? "Care" : "Love")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("Life doesn't come with a manual, it comes with a mother")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,10)
                    
                }//:VStack
                .offset(y: isAnimated ?   0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimated)
                Spacer()
                
                ZStack{
                    //MARK: - Center
                    CircleGroupView(circleGroupColor: .white)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: imageOffset.width / 5 ,opaque: false)
                    Image("happy-pregnant")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(imageOffset.width / 15))
                        .offset(x: imageOffset.width,y: 0)
                        .scaleEffect (isAnimated ? 1: 0.8)
                        .animation (.easeOut (duration: 0.5), value: isAnimated)
                        .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.5), radius: 8,x: 3,y: 30)
                        .overlay(
                            Image(systemName: "arrow.left.and.right.circle")
                                .opacity(isHidden ? 0 : 1)
                                .foregroundColor(.white)
                                .font(.system(size: 40,weight: .ultraLight,design: .rounded))
                            ,alignment: .bottom
                        )
                        .frame(width: 300,alignment: .center)
                        .gesture(DragGesture()
                            .onChanged({ gesture in
                                isHidden = true
                                if abs(gesture.translation.width ) <= 150{
                                    imageOffset = gesture.translation
                                    
                                }
                                
                            })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.5)){
                                        isHidden = false
                                        imageOffset = .zero
                                    }
                                })
                        )
                    
                }//:ZStack
                Spacer()
                
                ZStack{
                    //MARK: - Footer
                    
                    //1-Background
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    //2-Text
                    Text("Start")
                        .font(.system(size: 30,weight: .bold,design: .rounded))
                        .foregroundColor(.white)
                    //3- Capsule Dynamic
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80 + buttonOffset)
                        Spacer()
                    }
                    //4- Dragable Circle
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(.black.opacity(0.2))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.white)
                                .font(.system(size: 24,weight: .bold,design: .rounded))
                        }
                        .frame(height: 80,alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(DragGesture()
                            .onChanged({ gesture in
                                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                    buttonOffset = gesture.translation.width
                                }
                            })
                                .onEnded ( {
                                    _ in
                                    withAnimation(.easeOut(duration: 0.5)){
                                        if buttonOffset >= buttonWidth / 2 {
                                            isOnBoarding = false
                                            playSound(soundFile: "chimeup", soundType: "mp3")
                                            feedBack.notificationOccurred(.success)
                                        } else {
                                            buttonOffset = 0
                                               feedBack .notificationOccurred(.error)
                                        }
                                    }
                                    
                                })
                        )
                        Spacer()
                    }
                }//:ZStack
                .frame(height: 80,alignment: .center)
                .padding(.horizontal,40)
                .offset(y: isAnimated ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimated)
            }//:VStack
            
        }//:ZStack
        .onAppear{
            isAnimated.toggle()
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
