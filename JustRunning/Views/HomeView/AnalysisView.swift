//
//  TransactionsView.swift
//  money-manage
//
//  Created by Beau Nouvelle on 2020-12-28.
//

import Foundation
import SwiftUI

struct AnalysisView: View {
    @State private var timeRange: TimeRange = .last30Days
    var color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
//        NavigationView{
            ScrollView{
                VStack(spacing: -40) {
                    HStack {
                        Text("运动数据分析")
                            .font(.headline)
                        Spacer()
                        //                Image(systemName: "plus.circle.fill")
                        //                    .resizable()
                        //                    .foregroundColor(Color(#colorLiteral(red: 0.3097526431, green: 0.3843510449, blue: 0.7528470159, alpha: 1)))
                        //                    .frame(width: 30, height: 30)
                        //                Text("Add recipient")
                        //                    .font(.headline)
                        TimeRangePicker(value: $timeRange)
                            .padding(.bottom)
                    }
                    .padding(20)
                    .padding(.bottom, 40)
                    .foregroundColor(.white)
                    //            .background(Color(#colorLiteral(red: 0.1019468382, green: 0.1058915928, blue: 0.1333118379, alpha: 1)))
                    .background(Color(color))
                    .cornerRadius(20)
                    switch timeRange {
                    case .last30Days:
                        LazyVStack {
                            ForEach(0..<10, id: \.self) { item in
                                NavigationLink {
                                    LocationsDetails()
                                } label: {
                                    HStack {
                                        Image("runIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(5)
                                        VStack(alignment: .leading) {
                                            Text("武汉大学桂操")
                                                .font(.headline)
                                            Text("2023年5月20日 20:00")
                                                .font(.caption)
                                                .foregroundColor(Color(.secondaryLabel))
                                        }
                                        Spacer()
                                        Text("2.5km")
                                            .font(.headline)
                                    }
                                    .padding(8)
                                }
                                
                                
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                    case .last12Months:
                        LazyVStack {
                            ForEach(0..<10, id: \.self) { item in
                                HStack {
                                    Image("runIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(5)
                                    VStack(alignment: .leading) {
                                        Text("南京大学鼓楼校区")
                                            .font(.headline)
                                        Text("2022年12月24日 20:00")
                                            .font(.caption)
                                            .foregroundColor(Color(.secondaryLabel))
                                    }
                                    Spacer()
                                    Text("1.5km")
                                        .font(.headline)
                                }
                                .padding(8)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    
                }
                .padding(.horizontal)
            }
//        }
    }
}

struct TransactionsView_Previews: PreviewProvider {

    static var previews: some View {
        AnalysisView()
            .previewLayout(.sizeThatFits)
    }
}
