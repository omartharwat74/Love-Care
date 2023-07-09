//
//  ContentView.swift
//  Love&Care
//
//  Created by Omar Tharwat on 24/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isOnBoarding") var isOnBoarding : Bool = true
    
    var body: some View {
        
        if isOnBoarding {
            OnBoarding()
        }else{
            Home()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
