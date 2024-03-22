//
//  SplashScreen.swift
//  mealdb
//
//  Created by Ankit Mhatre on 3/21/24.
//

import Foundation
import SwiftUI




//
//  SplashView.swift
//  RTK_Spike
//
//  Created by Jason Cheladyn on 2022/04/04.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                VStack{
                    Text("MealDb")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("powered by Fetch")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}


