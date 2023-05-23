//
//  CardView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/11.
//

import SwiftUI

struct CardView: View {
    @State var isSelected: Bool = false
    var color = #colorLiteral(red: 0.3526380062, green: 0.6078233123, blue: 0.9825491309, alpha: 1)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("RunningLogo") // logo
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(isSelected ? .white : .black)
                    .padding()
            }
//            Spacer()
            HStack{
                Image(systemName: "calendar.badge.clock")
                Text("5 月 20 日")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.caption)
                    .bold()
                    .padding(.bottom, 2)
            }
            
            HStack{
                Image(systemName: "location")
                Text("武汉大学桂操")
                    .font(.system(size: 15))
                    .foregroundColor(isSelected ? .white : .black)
            }
            HStack(alignment: .center) {
                Text("路程")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.caption)
                Text("2.5km")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.headline)
                    .fontWeight(.heavy)
            }
            .padding(.bottom, 2)
//            Spacer()
            HStack{
                Text("用时")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.caption)
                    .padding(.bottom)
                Text("15min40s")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.caption)
                    .padding(.bottom)
                    .bold()
            }
            
            
        }
        .frame(width: 150, height: 180)
        .padding(8)
        .background(Color(isSelected ? color : .white))
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(isSelected: true)
                .previewLayout(.sizeThatFits)
            CardView()
                .previewLayout(.sizeThatFits)
        }
    }
}
