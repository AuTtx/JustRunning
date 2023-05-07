//
//  RunningAnimation.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/4/28.
//

import SwiftUI
import Lottie

struct RunningAnimation: UIViewRepresentable {
    
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<RunningAnimation>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named("RunningAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([ animationView.heightAnchor.constraint(equalTo: view.heightAnchor), animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<RunningAnimation>) {
        
    }
}
