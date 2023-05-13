//
//  TimerPickerView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/14.
//

import SwiftUI


enum TimerPicker {
    case countdown
    case timer
}

struct TimerPickerView: View {
    @Binding var value: TimerPicker

    var body: some View {
        Picker("TimerPicker", selection: $value.animation(.easeInOut)) {
            Text("倒计时").tag(TimerPicker.countdown)
            Text("计时").tag(TimerPicker.timer)
        }
        .pickerStyle(.segmented)
        .frame(width: 120,height: 120)
    }
}

