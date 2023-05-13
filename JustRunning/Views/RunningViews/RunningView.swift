//
//  RunningView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import SwiftUI
import MapKit

struct RunningView: View {
    @StateObject private var vm = MapViewModel()
    @State private var trackingMode: MapUserTrackingMode = .follow
    var body: some View{
        VStack{
            VStack(spacing: 0){
                Map(coordinateRegion: $vm.region,showsUserLocation: true,userTrackingMode: $trackingMode)
                    .ignoresSafeArea()
                    .frame(width: 350,height: 140)
                    .cornerRadius(30)
                    .padding(.top, 50)
                CountDownView().environmentObject(CountdownModel())
            }
        }.ignoresSafeArea()
        
        

    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}


