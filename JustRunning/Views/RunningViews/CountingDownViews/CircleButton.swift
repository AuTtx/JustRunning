
import SwiftUI

struct CircleButton: View {
    
    enum ButtonStyle {
        case start
        case pause
        case reset
        
        var title: String {
            switch self {
            case .start:
                return "开始"
            case .pause:
                return "暂停"
            case .reset:
                return "重置"
            }
        }
        
        var fillColor: Color {
            switch self {
            case .start:
                return Color(.systemGreen)
            case .pause:
                return Color(.systemOrange)
            case .reset:
                return Color(.secondarySystemBackground)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .start:
                return Color(.white)
            case .pause:
                return Color(.white)
            case .reset:
                return Color(.label)
            }
        }
    }
    
    var style: ButtonStyle
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style.fillColor, lineWidth: 1)
                .frame(width: 88, height: 88)
            
            Circle()
                .fill(style.fillColor)
                .frame(width: 80, height: 80)
                .overlay(
                    Text(style.title)
                        .font(.headline)
                        .foregroundColor(style.foregroundColor)
                )
        }
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(style: .start)
    }
}
