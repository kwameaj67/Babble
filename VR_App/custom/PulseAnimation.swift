//
//  PulseAnimation.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 21/08/2021.
//

import Foundation
import UIKit


class pulseAnimation: CALayer {
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1
    var radius: CGFloat = 200
    var numberOfPulses: Float = 10
    
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulses:Float = 10, radius:CGFloat, position:CGPoint){
        super.init()
        self.backgroundColor = UIColor.brown.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value:0)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.keyTimes = [0, 0.3, 1]
        opacityAnimation.values = [0.4, 0.8, 0]
        return opacityAnimation
    }
    
    func setupAnimationGroup(){
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numberOfPulses
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations  = [scaleAnimation(), createOpacityAnimation()]
    }
    func cancelPulseAnimation(){
        self.animationGroup.duration = 0
        self.animationGroup.repeatCount = 0
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations  = nil
    }
    
    
}






//init() {
//        super.init(frame: .zero)
//        layer.addSublayer(pulsingLayer)
//        pulsingLayer.add(animationGroup, forKey: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private let pulsingLayer:CAShapeLayer  = circleLayer(color: Constant.pulsingColor)
//
//    private lazy var animationGroup : CAAnimationGroup = {
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [expandingAnimation,fadingAnimation ]
//        animationGroup.duration = 1.5
//        animationGroup.repeatCount = .infinity
//
//        return animationGroup
//    }()
//    private lazy var expandingAnimation: CABasicAnimation = {
//        let expandingAnimation = CABasicAnimation(keyPath: "transform.scale")
//        expandingAnimation.fromValue = 1
//        expandingAnimation.toValue = 1.4
//        return expandingAnimation
//    }()
//    private lazy var fadingAnimation: CABasicAnimation = {
//        let fadingAnimation = CABasicAnimation(keyPath: "opacity")
//        fadingAnimation.fromValue = 1
//        fadingAnimation.toValue = 0
//        return fadingAnimation
//    }()
//    private static func circleLayer(color:CGColor) -> CAShapeLayer {
//        let circleLayer = CAShapeLayer()
//        circleLayer.path = Constant.bezierPath.cgPath
//        circleLayer.lineWidth = 30
//        circleLayer.strokeColor = color
//        circleLayer.fillColor = UIColor.clear.cgColor
//
//        return circleLayer
//
//    }
//
//    private enum Constant{
//        static let bezierPath: UIBezierPath = .init(arcCenter: CGPoint.zero, radius: 100.0, startAngle: -(CGFloat.pi / 2), endAngle: -(CGFloat.pi / 2) + (2 * CGFloat.pi), clockwise: true)
//
//        static let pulsingColor: CGColor = Constants.Colors.CGgreen
//    }
