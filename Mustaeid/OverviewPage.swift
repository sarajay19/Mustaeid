//
//  OverviewPage.swift
//  Mustaeid
//
//  Created by Sara AlQuwaifli on 23/12/2023.
//

import SwiftUI

struct OverviewPage: View {
    
    @State private var progressValue: Float = 0.0
    @State private var progressValue2: Float = 0.0
        
        @State private var habits = [
            Habit(title: "Sleeping", symbol: "bed.double.fill", backC: Color.muteGreen),
            Habit(title: "Studying", symbol: "studentdesk", backC: Color.muteBlue)
        ]
        
        var body: some View {
            Spacer(minLength: 20)
            NavigationView{
                VStack {
                    Text("Build Your Habits, Shape \nYour Future!")
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    VStack {
                        ProgressBar(progress: self.$progressValue)
                            .foregroundColor(.muteGreen).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .frame(width: 200.0, height: 200.0)
                            .padding(20.0)
                            .onAppear {
                                self.progressValue = 0.0
                            }
                            .overlay(
                                ProgressBar(progress: self.$progressValue2, color: .muteBlue)
                                    .foregroundColor(.muteBlue).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                    .frame(width: 150.0, height: 150.0)
                                    .padding(20.0)
                                    .onAppear {
                                        self.progressValue2 = 0.0
                                    }
                            )
                            .overlay(
                                VStack(spacing: 5) {
                                    Text("\(Int((progressValue + progressValue2) / 2 * 100))%")
                                        .font(.system(size: 25))
                                        .bold()
                                    
                                    Text("Overall Progress")
                                        .font(.system(size: 12))
                                }
                            )
                    }
                    HStack(alignment: .top, spacing: 16) {
                        HStack(alignment: .center, spacing: 8) {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 7, height: 7)
                              .background(Color.muteGreen)
                            
                            Text("\(Int((progressValue) * 30)) of 30 days of good sleep")                              .font(
                                Font.custom("SF Pro Rounded", size: 11)
                                  .weight(.medium)
                              )
                              .foregroundColor(Color.muteGreen)
                            
                        }
                        .padding(0)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 7, height: 7)
                              .background(Color.muteBlue)
                            Text("\(Int((progressValue2) * 30)) of 30 days of good sleep")
                              .font(
                                Font.custom("SF Pro Rounded", size: 11)
                                  .weight(.medium)
                              )
                              .foregroundColor(Color.muteBlue)
                            
                        }
                        .padding(0)

                    }
                    .padding(0).frame(height: 50)
                    
                    VStack(spacing: -10){
                        HStack(alignment: .top, spacing: 240){
                            Text("All Habits")
                                .bold()
                            Button(action: {
                            }) {
                                Image(systemName: "plus.square")
                                    .foregroundColor(Color.darkGreen)
                                    .bold()
                            }
                            
                        }
                            
                        ForEach(habits) { habit in
                            CardView(habit: habit, progressValue: $progressValue, progressValue2: $progressValue2)
                        }
                        
                        Spacer()
                    }
                }.navigationTitle("Overview")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarTitle(Text("Overview").font(.largeTitle).fontWeight(.bold))
            }
        }
    }

    struct ProgressBar: View {
        @Binding var progress: Float
        var color: Color = .muteGreen
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.20)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.easeInOut(duration: 2.0))
            }
        }
    }

    struct Habit: Identifiable {
        var id = UUID()
        var title: String
        var symbol: String
        var backC: Color
    }

struct CardView: View {
    @State private var showPlusButton = false
    @State private var showMinusButton = false

    var habit: Habit
    @Binding var progressValue: Float
    @Binding var progressValue2: Float
    @State private var translation: CGSize = .zero
    @State private var showProgressButton = false
    
    var body: some View {
        let gesture = DragGesture()
            .onChanged { value in
                self.translation = value.translation
                self.showProgressButton = value.translation.width < -50
            }
            .onEnded { value in
                if value.translation.width < -100 {
                    if habit.title == "Sleeping" {
                        if progressValue < 1.0 {
                            self.progressValue += 1.0 / 30.0
                        } else {
                            progressValue = 0.0
                        }
                    } else if habit.title == "Studying" {
                        if progressValue2 < 1.0 {
                            self.progressValue2 += 1.0 / 30.0
                        } else {
                            progressValue2 = 0.0
                        }
                    }
                } else if value.translation.width > 100 {
                    if habit.title == "Sleeping" {
                        if progressValue > 0.0 {
                            self.progressValue -= 1.0 / 30.0
                        } else {
                            // Delete the card
                            
                        }
                    } else if habit.title == "Studying" {
                        if progressValue2 > 0.0 {
                            self.progressValue2 -= 1.0 / 30.0
                        } else {
                            // Delete the card
                            
                        }
                    }
                }
                self.translation = .zero
                self.showProgressButton = false
                
            }
        
        return HStack(spacing: 20) {
            Image(systemName: habit.symbol)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .foregroundColor(.white)
            
            Text(habit.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(width: 310, height: 35)
        .padding()
        .background(habit.backC)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top)
        .offset(x: translation.width, y: 0)
        .gesture(gesture)
        .animation(.default)
        .overlay(
                        HStack {
                            Button(action: {
                                if habit.title == "Sleeping" {
                                    if progressValue > 0.0 {
                                        self.progressValue -= 1.0 / 30.0
                                    } else {
                                        progressValue = 0.0
                                    }
                                } else if habit.title == "Studying" {
                                    if progressValue2 > 0.0 {
                                        self.progressValue2 -= 1.0 / 30.0
                                    } else {
                                        progressValue2 = 0.0
                                    }
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.darkGreen)
                            }
                            .opacity(showMinusButton && translation.width > 50 ? 1.0 : 0.0)
                            .animation(.default)
                            .padding(.leading, 20)
                            
                            Button(action: {
                                if habit.title == "Sleeping" {
                                    if progressValue < 1.0 {
                                        self.progressValue += 1.0 / 30.0
                                    } else {
                                        progressValue = 0.0
                                    }
                                } else if habit.title == "Studying" {
                                    if progressValue2 < 1.0 {
                                        self.progressValue2 += 1.0 / 30.0
                                    } else {
                                        progressValue2 = 0.0
                                    }
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.darkGreen)
                            }
                            .opacity(showPlusButton && translation.width < -50 ? 1.0 : 0.0)
                            .animation(.default)
                            .padding(.trailing, 20)
                        }
                    )
                    .onChange(of: translation.width) { newValue in
                        showMinusButton = newValue > 50
                        showPlusButton = newValue < -50
                    }
    }
            
}

#Preview {
    OverviewPage()
}

