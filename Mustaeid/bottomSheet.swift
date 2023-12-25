//
//  bottomSheet.swift
//  Mustaeid
//
//  Created by Lujain Alaydie on 24/12/2023.
//

import SwiftUI

struct bottomSheet: View {
    @State var presentSheet = false
    @State var text = "Maintain a consistent sleep schedule, going to bed and waking up at the same time every day.\nCreate a sleep-friendly environment with a cool, quiet, and dark bedroom.\nEstablish a relaxing bedtime routine to signal your body that it's time to sleep."
    @State var isToggled = false
    @State private var value = 0
    @State private var selectedSegment = 0

    
    var body: some View {
        NavigationView {
            Button("Modal") {
                presentSheet = true
            }
            .navigationTitle("Main")
        }.sheet(isPresented: $presentSheet) {
            VStack{
                GeometryReader { geometry in
                    HStack(alignment: .center, spacing:geometry.size.width / 4) {
                        Text("Cancel")
                            .font(
                                .system( size: 17))
                            .foregroundColor(.cancel)
                        
                            .onTapGesture {
                                presentSheet = false
                            }
                            .padding(.leading)
                        
                        Text("Sleeping")
                            .font(
                                .system( size: 17)
                                .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        
                    }.padding(.leading, 0)
                        .padding(.trailing)
                        .padding(.vertical, 10)
                    
                    
                    HStack{
                        Text("Tips")
                            .font(
                                .system( size: 15)
                                .weight(.semibold)
                            )
                            .foregroundColor(.black)
                        
                            .frame(width: 320, height: 138, alignment: .topLeading)
                        
                    }.padding(.leading)
                        .padding(.trailing)
                        .padding(.vertical, geometry.size.height / 8)
                    
                    HStack{
                        Text(text)
                            .font(
                                .system( size: 12))
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                Rectangle()
                                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .cornerRadius(5)
                            )
                    }.padding(.leading)
                        .padding(.trailing)
                        .padding(.vertical, geometry.size.height / 5)
                    
                    HStack(spacing: geometry.size.width / 2.5){
                        Text("Notification")
                            .font(
                                .system( size: 15)
                                .weight(.semibold)
                            )
                            .foregroundColor(.black)
                        
                        
                        Toggle("", isOn: $isToggled)
                            .padding()
                        
                    }.padding(.leading)
                        .padding(.trailing)
                        .padding(.vertical, geometry.size.height / 2)
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .top, spacing: geometry.size.width / 3.4) {
                            Text("Reminder")
                                .font(
                                    .system( size: 15)
                                    .weight(.semibold)
                                )
                                .foregroundColor(.black)
                                .frame(width: 117, height: 22, alignment: .topLeading)
                            
                            Stepper("", value: $value, in: 0...10)
                            
                        }
                        Text("\(value) a day")              
                            .font(
                            .system( size: 11)
                            .weight(.light)
                        )
                            .foregroundColor(.black)
                    }.padding(.leading)
                        .padding(.trailing)
                        .padding(.vertical, geometry.size.height / 1.5)
                    
                    
                    HStack(spacing: geometry.size.width / 10) {
                        
                        Text("Duration")
                          .font(
                            Font.custom("SF Pro", size: 15)
                              .weight(.semibold)
                          )
                          .foregroundColor(.black)
                          .frame(width: 117, height: 22, alignment: .topLeading)
                        
                        Picker("Segmented Control", selection: $selectedSegment) {
                            Text("Week").tag(0)
                            Text("Month").tag(1)
                            Text("Year").tag(2)
                        }
                        
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }.padding(.leading)
                        .padding(.trailing)
                        .padding(.vertical, geometry.size.height / 1.3)
                    
                    
                    
                }
                

                .presentationDetents([.medium])
                
            }//GeometryReader
        }
    }
}

#Preview {
    bottomSheet()
}
