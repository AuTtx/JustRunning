//
//  ContentView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct CountDownView: View {
    @EnvironmentObject var vmRunning: ViewModel
    @EnvironmentObject private var model: CountdownModel
    @State private var showSettings = false
    
    
    var body: some View {
        
        VStack {
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
        }
        .onReceive(model.timer) { time in
            model.receiveTimerUpdate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
            .environmentObject(CountdownModel()).environmentObject(ViewModel())
    }
}
