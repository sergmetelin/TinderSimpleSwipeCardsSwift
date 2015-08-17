//
//  DraggableView.swift
//  blast
//
//  Created by sydneyuser on 15/08/2015.
//  Copyright (c) 2015 sydneyuser. All rights reserved.
//

import UIKit

class DraggableView: UIView {
  
  let ACTION_MARGIN:CGFloat = 120
  let SCALE_STRENGTH:CGFloat = 4
  let SCALE_MAX:CGFloat = 0.93
  let ROTATION_MAX:CGFloat = 1
  let ROTATION_STRENGTH:CGFloat = 320
  let ROTATION_ANGLE:CGFloat = CGFloat(M_PI/8)

  var xFromCenter:CGFloat?
  var yFromCenter:CGFloat?
  
  var originalPoint:CGPoint?
  
  var panGestureRecogniser: UIPanGestureRecognizer?
  var information: UILabel?
  var overlayView: OverlayView?
  
  var delegate:DraggableViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupView()
    
    information = UILabel(frame: CGRectMake(0, 50, self.frame.size.width, 100))
    information!.text = "no info given"
    information!.textAlignment = NSTextAlignment.Center
    information!.textColor = UIColor.blackColor()
    
    self.backgroundColor = UIColor.whiteColor()
    
    panGestureRecogniser = UIPanGestureRecognizer(target: self, action: "beingDragged:")
    
    self.addGestureRecognizer(panGestureRecogniser!)
    self.addSubview(information!)
    
    overlayView = OverlayView(frame: CGRectMake(self.frame.size.width/2, 0, 100, 100))
    overlayView!.alpha = 0
    self.addSubview(overlayView!)
    
  }
  
  private func setupView() {
    self.layer.cornerRadius = 4
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.2
    self.layer.shadowOffset = CGSizeMake(1, 1)
  }
  
  func beingDragged(gestureRecogniser: UIPanGestureRecognizer) {
    xFromCenter = gestureRecogniser.translationInView(self).x
    yFromCenter = gestureRecogniser.translationInView(self).y
    
    switch gestureRecogniser.state {
    case UIGestureRecognizerState.Began:
      self.originalPoint = self.center
    case UIGestureRecognizerState.Changed:
      let rotationStrength:CGFloat = min(xFromCenter!/CGFloat(ROTATION_STRENGTH), CGFloat(ROTATION_MAX))
      let rotationAngle:CGFloat = CGFloat(CGFloat(ROTATION_ANGLE) * rotationStrength)
      let scale:CGFloat = max(CGFloat(1-fabsf(Float(rotationStrength))) / CGFloat(SCALE_STRENGTH), CGFloat(SCALE_MAX))
      self.center = CGPointMake(self.originalPoint!.x + xFromCenter!, self.originalPoint!.y + yFromCenter!)
      let transform: CGAffineTransform = CGAffineTransformMakeRotation(rotationAngle)
      let scaleTransform: CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
      
      self.transform = scaleTransform
      self.updateOverlay(xFromCenter!)
    case UIGestureRecognizerState.Ended:
      self.afterSwipeAction()
    default: ()
      
    }
    
  }
  
  private func updateOverlay(distance: CGFloat) {
    if (distance > 0) {
      overlayView!.mode = GGOverlayViewMode.Right
    }
  }
  
  private func afterSwipeAction() {
    if (xFromCenter > ACTION_MARGIN) {
      self.rightAction()
    } else if (xFromCenter < -ACTION_MARGIN) {
      self.leftAction()
    } else {
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.center = self.originalPoint!
        self.transform = CGAffineTransformMakeRotation(0)
        self.overlayView?.alpha = 0
      })
    }
  }
  
  private func rightAction() {
    let finishPoint:CGPoint = CGPointMake(500, 2*yFromCenter! + self.originalPoint!.y)
    UIView.animateWithDuration(0.3, animations: { () -> Void in self.center = finishPoint }, completion: { _ in self.removeFromSuperview() })
    delegate!.cardSwipedRight(self)
    
    println("YES!")
  }

  private func leftAction() {
    let finishPoint:CGPoint = CGPointMake(-500, 2*yFromCenter! + self.originalPoint!.y)
    UIView.animateWithDuration(0.3, animations: { _ in self.center = finishPoint }, completion: { _ in self.removeFromSuperview() })
    delegate!.cardSwipedLeft(self)
    
    println("No!")
  }
  
  private func upAction() {
    let finishPoint:CGPoint = CGPointMake(2*xFromCenter! + self.originalPoint!.x, -200 )
    UIView.animateWithDuration(0.3, animations: { _ in
      self.center = finishPoint
      self.transform = CGAffineTransformMakeScale(0.3, 0.3)
      }, completion: { _ in
        self.removeFromSuperview()
    })
    delegate!.cardSwipedUp(self)
    
    println("Yes!")
  }
  
  private func downAction() {
    let finishPoint:CGPoint = CGPointMake(2*xFromCenter! + self.originalPoint!.x, 900 )
    UIView.animateWithDuration(0.3, animations: { _ in
      self.center = finishPoint
      self.transform = CGAffineTransformMakeScale(0.3, 0.3)
      }, completion: { _ in
        self.removeFromSuperview()
    })
    delegate!.cardSwipedDown(self)
    
    println("No!")
  }

  
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

protocol DraggableViewDelegate {
  func cardSwipedLeft(card: UIView)
  func cardSwipedRight(card: UIView)
  func cardSwipedUp(card: UIView)
  func cardSwipedDown(card: UIView)
}
