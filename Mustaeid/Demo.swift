//
//  Demo.swift
//  Mustaeid
//
//  Created by Sara AlQuwaifli on 24/12/2023.
//

import SwiftUI

struct Demo: View {
    var body: some View {
        ZStack {
            Color.logoC
        VStack(spacing: 20) {
            HStack {
                Text("Welcome to ")
                +
                Text("Mustaeid")
                    .bold()
                +
                Text("!")
            }
            .foregroundColor(.black)
            .font(.system(size: 30))
            
            Text("Your first step toward your goals")
              .multilineTextAlignment(.center)
              .font(.system(size: 12))
              .foregroundColor(.black)
            
            Spacer().frame(height: 20)
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 286, height: 286)
                .clipped()
                .cornerRadius(16)
            
            Spacer().frame(height: 50)
            Button(action: {
                            // action
                        }) {
                            Text("Get started")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 228, alignment: .center)
                                .background(Color.darkGreen)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
        .ignoresSafeArea()
            }
}

#Preview {
    Demo()
}
