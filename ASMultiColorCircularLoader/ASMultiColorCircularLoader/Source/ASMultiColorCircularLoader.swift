//
//  ASMultiColorCircularLoader.swift
//  CircularSpinner
//
//  Created by Arijit Sarkar on 29/07/20.
//  Copyright © 2020 Arijit Sarkar. All rights reserved.
//

import UIKit

public class ASMultiColorCircularLoader: UIView, CAAnimationDelegate {

    public var lineWidth: CGFloat = 5.0
    public var lineCap: CAShapeLayerLineCap = .round
    public var colors: [UIColor] = [UIColor(rOS: 0.965, g: 0.659, b: 0.788), UIColor(rOS: 0.212, g: 0.675, b: 0.878), UIColor(rOS: 0.043, g: 0.714, b: 0.702)]
    public var drawDurations: [Double] = [1.0, 0.6, 0.4]
    public var drawDelays: [Double] = [0.0, 0.5, 0.8]
    public var withdrawDurations: [Double] = [0.8, 0.6, 0.4]
    public var withdrawDelays: [Double] = [0.3, 0.1, 0.0]
    public var startAngle: CGFloat = CGFloat.pi + CGFloat.pi / 2
    public var endAngle: CGFloat = CGFloat.pi * 3 + CGFloat.pi / 2
    public var delayBetweenDrawAndWithdrawAnimation: Double = 0.2
    public var delayBetweenAnimationSets: Double = 0.2
    public var rotationAnimationDuration: Double = 10.0
    public var lineDrawWithdrawValue: Double = 0.98
    
    private var spinnerLayers = [CAShapeLayer]()
    private var circularPath: UIBezierPath!
    private var shouldShowDrawAnimation = true
    private var animationCount = 0
    private var oneDrawAnimationTotalDuration: Double = 0.0
    private var oneWithdrawAnimationTotalDuration: Double = 0.0
    private var isSetupComplete = false
    private var stopAnimation = false
    
    private func assertValidityOfUIParameterss() {
        guard colors.count == drawDurations.count else {
            fatalError("Colors array size is not equal to Draw durations array")
        }
        guard colors.count == drawDelays.count else {
            fatalError("Colors array size is not equal to Draw delays array")
        }
        guard colors.count == withdrawDurations.count else {
            fatalError("Colors array size is not equal to Withdraw durations array")
        }
        guard colors.count == withdrawDelays.count else {
            fatalError("Colors array size is not equal to Withdraw delays array")
        }
    }
    
    private func setup() {
        assertValidityOfUIParameterss()
        calculateOneDrawAndWithdrawAnimationTotalDurations()
        setupUI()
        isSetupComplete = true
    }
    
    private func calculateOneDrawAndWithdrawAnimationTotalDurations() {
        oneDrawAnimationTotalDuration = getMaxDuration(durations: drawDurations, delays: drawDelays)
        oneWithdrawAnimationTotalDuration = getMaxDuration(durations: withdrawDurations, delays: withdrawDelays)
        print(oneDrawAnimationTotalDuration)
        print(oneWithdrawAnimationTotalDuration)
    }
    
    private func getMaxDuration(durations: [Double], delays: [Double]) -> Double {
        var totalDurations = [Double]()
        for index in 0..<durations.count {
            totalDurations.append(durations[index] + delays[index])
        }
        return totalDurations.max() ?? 0.0
    }
    
    private func setupUI() {
        circularPath = getCircularPath(withStartAngle: startAngle, andEndAngle: endAngle)
        setupSpinnerLayers()
    }
    
    private func getCircularPath(withStartAngle startAngle: CGFloat, andEndAngle endAngle: CGFloat) -> UIBezierPath {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path
    }
    
    private func setupLayerColors() {
        for (index, layer) in spinnerLayers.enumerated() {
            layer.strokeColor = colors[index].cgColor
        }
    }
    
    private func setupSpinnerLayers() {
        for index in 0..<colors.count {
            let layer = CAShapeLayer()
            layer.path = circularPath.cgPath
            layer.strokeColor = colors[index].cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeStart = 0
            layer.strokeEnd = 0
            layer.lineWidth = lineWidth
            layer.lineCap = lineCap
            spinnerLayers.append(layer)
        }
        positionSpinnerLayers()
    }
    
    private func positionSpinnerLayers() {
        for layer in spinnerLayers {
            self.layer.addSublayer(layer)
            layer.bounds = bounds
            layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    private func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = rotationAnimationDuration
        rotation.isCumulative = true
        rotation.repeatCount = .infinity
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    public func startAnimation() {
        
        if !isSetupComplete {
            setup()
            rotate()
        }
        var delay = 0.0
        
        for (index, layer) in spinnerLayers.enumerated() {
            
            if shouldShowDrawAnimation {
                
                print("Stroke End -- \(index)")
                layer.strokeStart = 0
                layer.strokeEnd = 0
                let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
                strokeEndAnimation.delegate = self
                strokeEndAnimation.duration = drawDurations[index]
                strokeEndAnimation.beginTime = CACurrentMediaTime() + drawDelays[index]
                strokeEndAnimation.fromValue = 0
                strokeEndAnimation.toValue = lineDrawWithdrawValue
                strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                strokeEndAnimation.isRemovedOnCompletion = false
                strokeEndAnimation.fillMode = .forwards
                layer.add(strokeEndAnimation, forKey: "strokeEnd\(animationCount)")
                delay = oneDrawAnimationTotalDuration//1.2
                
            } else {
                
                print("Stroke Start -- \(index)")
                layer.strokeEnd = CGFloat(lineDrawWithdrawValue)
                layer.strokeStart = 0
                let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
                strokeStartAnimation.delegate = self
                strokeStartAnimation.duration = withdrawDurations[index]
                strokeStartAnimation.beginTime = CACurrentMediaTime() + withdrawDelays[index]
                strokeStartAnimation.fromValue = 0
                strokeStartAnimation.toValue = lineDrawWithdrawValue
                strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                strokeStartAnimation.isRemovedOnCompletion = false
                strokeStartAnimation.fillMode = .forwards
                layer.add(strokeStartAnimation, forKey: "strokeStart\(animationCount)")
                delay = oneWithdrawAnimationTotalDuration//1.1
            }
        
            animationCount += 1
        }
        
        let isOneAnimationSetComplete = self.animationCount.isMultiple(of: 2)
        let additionalDelay = isOneAnimationSetComplete ? delayBetweenAnimationSets : delayBetweenDrawAndWithdrawAnimation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay + additionalDelay) {
            
            self.spinnerLayers.forEach { $0.removeAllAnimations() }
            
            self.shouldShowDrawAnimation = !self.shouldShowDrawAnimation
            
            if self.animationCount.isMultiple(of: 2) {
                
                self.setupSpinnerLayers()
                for index in 0..<self.spinnerLayers.count/2 {
                    self.spinnerLayers[index].removeFromSuperlayer()
                }
                self.spinnerLayers = Array(self.spinnerLayers.dropFirst(self.spinnerLayers.count/2))
                
            } else {
                
                // Do Nothing
            }
            
            if self.stopAnimation {
                self.stopAnimation = false
            } else {
                self.startAnimation()
            }
        }
    }
    
    
    public func endAnimation() {
        self.stopAnimation = true
        self.layer.removeAllAnimations()
        self.spinnerLayers.forEach {
            $0.removeFromSuperlayer()
            $0.removeAllAnimations()
        }
        self.spinnerLayers.removeAll()
        isSetupComplete = false
    }
}

extension UIColor {
    
    convenience init(rOS: CGFloat,g: CGFloat,b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: rOS, green: g, blue: b, alpha: alpha)
    }
}
