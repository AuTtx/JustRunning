//
//  ContentView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct CountDownView: View {
    
    @EnvironmentObject private var model: CountdownModel
    @State private var showSettings = false
    @State private var timerpicker: TimerPicker = .countdown
    
    var body: some View {
        
        
        VStack {
            TimerPickerView(value: $timerpicker).padding(.top, 0)
                .padding(.bottom, 0)
            ZStack {
                CircularProgressView()
                ClockView()
            }
            
            HStack {
                Button(action: { model.resetTimer() }) {
                    CircleButton(style: .reset)
                }
                Spacer()
                Button(action: { model.playPauseAction() }) {
                    CircleButton(style: model.isRunning ? .pause : .start)
                }.disabled(model.disabledAction())
                Spacer()
                Button(action: {
                    showSettings.toggle()
                    model.isRunning = false
                }) {
                    Label("设置", systemImage: "gearshape.fill")
                        .bold().font(.title2)
//                        .labelStyle(IconOnlyLabelStyle())
                }
                .sheet(isPresented: $showSettings, onDismiss: {
                    model.storedDuration = model.duration
                }) {
                    SettingsView()
                        .environmentObject(model)
                }
            }
            .padding()
            HStack{
                Button {
                    //拍照或从相册拿
                } label: {
                    Text("拍照打卡")
                        .font(.headline)
                        .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(12)
                        .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
                }.padding(.trailing, 35)
                
                Button {
                    //save
                } label: {
                    Text("保存记录")
                        .font(.headline)
                        .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(12)
                        .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
                }
            }
        }
        .onReceive(model.timer) { time in
            model.receiveTimerUpdate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
            .environmentObject(CountdownModel())
    }
}
