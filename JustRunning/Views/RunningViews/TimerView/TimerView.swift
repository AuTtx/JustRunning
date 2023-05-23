//
//  TimerView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/24.
//

import SwiftUI

struct TimerView: View {
    @State private var timeElapsed = 0
    @State private var timerIsRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("\(timeElapsed/3600):\(timeElapsed/60):\(timeElapsed%60)")
                .font(.system(size: 68, weight: .bold, design: .default))
                .fontWeight(.black)
            HStack{
                if timerIsRunning {
                    Button(action: {
                        self.timerIsRunning = false
                    }) {
                        CircleButton(style: .pause)
                            .padding(.leading, 50)
                    }
                } else {
                    Button(action: {
                        self.timerIsRunning = true
                    }) {
                        CircleButton(style: .start)
                            .padding(.leading, 50)
                    }
                }
                Spacer()
                Button {
                    self.timeElapsed = 0
                    self.timerIsRunning = false
                } label: {
                    CircleButton(style: .reset)
                        .padding(.trailing, 50)
                }
            }
            Text("加油！坚持！")
                .bold()
                .multilineTextAlignment(.trailing)
                .font(.largeTitle)
                .padding(.leading, 10)
                .padding(.top, 30)
                .padding(.bottom, 30)
            
        }
        .onReceive(timer) { _ in
            if self.timerIsRunning {
                self.timeElapsed += 1
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
