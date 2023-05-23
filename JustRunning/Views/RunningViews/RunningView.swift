//
//  RunningView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import SwiftUI
import MapKit

struct RunningView: View {
    @EnvironmentObject var vmRunning: ViewModel
    @StateObject private var vm = MapViewModel()
    @State private var trackingMode: MapUserTrackingMode = .follow
    @State private var choosePicker: TimerPicker = .countdown
    var body: some View{
        VStack{
            NavigationView {
                VStack(spacing: 0){
                    Map(coordinateRegion: $vm.region,showsUserLocation: true,userTrackingMode: $trackingMode)
                        .ignoresSafeArea()
                        .frame(width: 350,height: 140)
                        .cornerRadius(30)
                        .padding(.top, 0)
                    TimerPickerView(value: $choosePicker).padding(.top, 0)
                        .padding(.bottom, 0)
                    switch choosePicker{
                    case .countdown:
                        CountDownView()
                            .environmentObject(CountdownModel())
    //                        .environmentObject(vmRunning)
                    case .timer:
                        TimerView()
                    }
                    
                    HStack{
                        NavigationLink {
                            ImageView().environmentObject(vmRunning)
                        } label: {
                            Text("拍照打卡")
                                .font(.headline)
                                .padding()
                                .background(Color.secondaryBackground)
                                .cornerRadius(12)
                                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
                        }
                    }
                    Spacer()
                }
            }
        }.ignoresSafeArea()
        
        

    }
}

struct RunningView_Previews: PreviewProvider {
//    @EnvironmentObject var vmRunning: ViewModel

    static var previews: some View {
        RunningView().environmentObject(ViewModel())
    }
}


