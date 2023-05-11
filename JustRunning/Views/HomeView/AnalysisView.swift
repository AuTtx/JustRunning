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
    var body: some View {
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
            .background(.brown).opacity(0.7)
            .cornerRadius(20)
            LazyVStack {
                ForEach(0..<10, id: \.self) { item in
                    HStack {
                        Image("visaIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding(5)
                        VStack(alignment: .leading) {
                            Text("Dribble")
                                .font(.headline)
                            Text("12 Nov 2020  11:08")
                                .font(.caption)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        Spacer()
                        Text("-$60.0")
                            .font(.headline)
                    }
                    .padding(8)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.horizontal)
    }
}

struct TransactionsView_Previews: PreviewProvider {

    static var previews: some View {
        AnalysisView()
            .previewLayout(.sizeThatFits)
    }
}
