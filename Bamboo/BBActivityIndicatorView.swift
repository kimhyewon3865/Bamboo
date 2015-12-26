//
//  BBActivityIndicatorView.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

public class BBActivityIndicatorView: UIView {
    class var sharedInstance: BBActivityIndicatorView {
        struct Singleton {
            static let instance = BBActivityIndicatorView(frame: CGRect.zero)
        }
        return Singleton.instance
    }
    
    private var blurEffectStyle: UIBlurEffectStyle = .Dark
    private var blurEffect: UIBlurEffect!
    private var blurView: UIVisualEffectView!
    private var vibrancyView: UIVisualEffectView!
    
    public lazy var titleLabel = UILabel()
    public var subtitleLabel: UILabel?
    
    let frameSize = CGSize(width: 200.0, height: 200.0)
    
    var defaultTitleFont = UIFont(name: "HelveticaNeue", size: 22.0)
    
    private lazy var outerCircleView = UIView()
    private lazy var innerCircleView = UIView()
    
    private let outerCicle = CAShapeLayer()
    private let innerCircle = CAShapeLayer()
    
    private var currentOuterRotation: CGFloat = 0.0
    private var currentInnerRotation: CGFloat = 0.1
    
    private var showWithDelayBlock: (() -> ())?
    private var tapHandler: (()->())?
    
    public var title: String = "" {
        didSet {
            let spinner = BBActivityIndicatorView.sharedInstance
            
            UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.titleLabel.transform = CGAffineTransformMakeScale(0.75, 0.75)
                spinner.titleLabel.alpha = 0.2
                }, completion: {_ in
                    spinner.titleLabel.text = self.title
                    UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: [], animations: {
                        spinner.titleLabel.transform = CGAffineTransformIdentity
                        spinner.titleLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            blurView.frame = bounds
            vibrancyView.frame = blurView.bounds
            titleLabel.center = vibrancyView.center
            outerCircleView.center = vibrancyView.center
            innerCircleView.center = vibrancyView.center
            if let subtitle = subtitleLabel {
                subtitle.bounds.size = subtitle.sizeThatFits(CGRectInset(bounds, 20.0, 0.0).size)
                subtitle.center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMaxY(bounds) - CGRectGetMidY(subtitle.bounds) - subtitle.font.pointSize)
            }
        }
    }
    
    public var animating: Bool = false {
        willSet(shouldAnimate) {
            if shouldAnimate && !animating {
                spinInner()
                spinOuter()
            }
        }
        
        didSet {
            if animating {
                self.outerCicle.strokeStart = 0.0
                self.outerCicle.strokeEnd = 0.45
                self.innerCircle.strokeStart = 0.5
                self.innerCircle.strokeEnd = 0.9
            } else {
                self.outerCicle.strokeStart = 0.0
                self.outerCicle.strokeEnd = 1.0
                self.innerCircle.strokeStart = 0.0
                self.innerCircle.strokeEnd = 1.0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        addSubview(vibrancyView)
        
        let titleScale: CGFloat = 0.85
        titleLabel.frame.size = CGSize(width: frameSize.width * titleScale, height: frameSize.height * titleScale)
        titleLabel.font = defaultTitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        
        vibrancyView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(vibrancyView)
        
        outerCircleView.frame.size = frameSize
        outerCicle.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: frameSize.width, height: frameSize.height)).CGPath
        outerCicle.lineWidth = 8.0
        outerCicle.strokeStart = 0.0
        outerCicle.strokeEnd = 0.45
        outerCicle.lineCap = kCALineCapRound
        outerCicle.fillColor = UIColor.clearColor().CGColor
        outerCicle.strokeColor = UIColor.whiteColor().CGColor
        outerCircleView.layer.addSublayer(outerCicle)
        
        outerCicle.strokeStart = 0.0
        outerCicle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(outerCircleView)
        
        innerCircleView.frame.size = frameSize
        
        let innerCirclePadding: CGFloat = 12
        innerCircle.path = UIBezierPath(ovalInRect: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: frameSize.width - 2*innerCirclePadding, height: frameSize.height - 2*innerCirclePadding)).CGPath
        innerCircle.lineWidth = 4.0
        innerCircle.strokeStart = 0.5
        innerCircle.strokeEnd = 0.9
        innerCircle.lineCap = kCALineCapRound
        innerCircle.fillColor = UIColor.clearColor().CGColor
        innerCircle.strokeColor = UIColor.grayColor().CGColor
        innerCircleView.layer.addSublayer(innerCircle)
        
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(innerCircleView)
        
        userInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return self
    }
    
    public class func show(title: String, animated: Bool = true) -> BBActivityIndicatorView {
        let window = UIApplication.sharedApplication().windows.first!
        let spinner = BBActivityIndicatorView.sharedInstance
        
        spinner.showWithDelayBlock = nil
        spinner.clearTapHandler()
        
        spinner.updateFrame()
        
        if spinner.superview == nil {
            spinner.alpha = 0.0
            window.addSubview(spinner)
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseInOut, animations: {
                spinner.alpha = 1.0
                }, completion: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(spinner, selector: "updateFrame", name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
        }
        
        spinner.title = title
        spinner.animating = animated
        
        return spinner
    }
    
    public class func showWithDelay(delay: Double, title: String, animated: Bool = true) -> BBActivityIndicatorView {
        let spinner = BBActivityIndicatorView.sharedInstance
        
        spinner.showWithDelayBlock = {
            BBActivityIndicatorView.show(title, animated: animated)
        }
        
        spinner.delay(seconds: delay) {
            [weak spinner] in
            if let spinner = spinner {
                spinner.showWithDelayBlock?()
            }
        }
        
        return spinner
    }
    
    public class func hide(completion: (() -> Void)? = nil) {
        let spinner = BBActivityIndicatorView.sharedInstance
        
        NSNotificationCenter.defaultCenter().removeObserver(spinner)
        
        dispatch_async(dispatch_get_main_queue(), {
            spinner.showWithDelayBlock = nil
            spinner.clearTapHandler()
            
            if spinner.superview == nil {
                return
            }
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 0.0
                }, completion: {_ in
                    spinner.alpha = 1.0
                    spinner.removeFromSuperview()
                    spinner.titleLabel.font = spinner.defaultTitleFont
                    spinner.titleLabel.text = nil
                    
                    completion?()
            })
            
            spinner.animating = false
        })
    }
    
    public class func setTitleFont(font: UIFont?) {
        let spinner = BBActivityIndicatorView.sharedInstance
        
        if let font = font {
            spinner.titleLabel.font = font
        } else {
            spinner.titleLabel.font = spinner.defaultTitleFont
        }
    }
    
    public func addTapHandler(tap: (()->()), subtitle subtitleText: String? = nil) {
        clearTapHandler()
        
        //vibrancyView.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapSpinner")))
        tapHandler = tap
        
        if subtitleText != nil {
            subtitleLabel = UILabel()
            if let subtitle = subtitleLabel {
                subtitle.text = subtitleText
                subtitle.font = UIFont(name: defaultTitleFont!.familyName, size: defaultTitleFont!.pointSize * 0.8)
                subtitle.textColor = UIColor.whiteColor()
                subtitle.numberOfLines = 0
                subtitle.textAlignment = .Center
                subtitle.lineBreakMode = .ByWordWrapping
                subtitle.bounds.size = subtitle.sizeThatFits(CGRectInset(bounds, 20.0, 0.0).size)
                subtitle.center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMaxY(bounds) - CGRectGetMidY(subtitle.bounds) - subtitle.font.pointSize)
                vibrancyView.contentView.addSubview(subtitle)
            }
        }
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if tapHandler != nil {
            tapHandler?()
            tapHandler = nil
        }
    }
    
    public func clearTapHandler() {
        userInteractionEnabled = false
        subtitleLabel?.removeFromSuperview()
        tapHandler = nil
    }
    
    private func spinOuter() {
        
        if superview == nil {
            return
        }
        
        let duration = Double(Float(arc4random()) /  Float(UInt32.max)) * 2.0 + 1.5
        let randomRotation = Double(Float(arc4random()) /  Float(UInt32.max)) * M_PI_4 + M_PI_4
        
        //outer circle
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            self.currentOuterRotation -= CGFloat(randomRotation)
            self.outerCircleView.transform = CGAffineTransformMakeRotation(self.currentOuterRotation)
            }, completion: {_ in
                let waitDuration = Double(Float(arc4random()) /  Float(UInt32.max)) * 1.0 + 1.0
                self.delay(seconds: waitDuration, completion: {
                    if self.animating {
                        self.spinOuter()
                    }
                })
        })
    }
    
    private func spinInner() {
        if superview == nil {
            return
        }
        
        //inner circle
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.currentInnerRotation += CGFloat(M_PI_4)
            self.innerCircleView.transform = CGAffineTransformMakeRotation(self.currentInnerRotation)
            }, completion: {_ in
                self.delay(seconds: 0.5, completion: {
                    if self.animating {
                        self.spinInner()
                    }
                })
        })
    }
    
    public func updateFrame() {
        let window = UIApplication.sharedApplication().windows.first!
        BBActivityIndicatorView.sharedInstance.frame = window.frame
    }
    
    // MARK: - Util methods
    
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    func didTapSpinner() {
        tapHandler?()
    }
}





























