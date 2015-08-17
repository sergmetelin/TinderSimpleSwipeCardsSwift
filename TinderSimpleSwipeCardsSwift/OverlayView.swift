//
//  OverlayView.swift
//  blast
//
//  Created by sydneyuser on 15/08/2015.
//  Copyright (c) 2015 sydneyuser. All rights reserved.
//

import UIKit

enum GGOverlayViewMode: Int {
  case Left
  case Right
}

class OverlayView: UIView {
  
  var mode: GGOverlayViewMode?
  private var imageView: UIImageView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    imageView = UIImageView(image: UIImage(named: "noButton"))
    self.addSubview(imageView!)
  }
  
  private func setMode(mode: GGOverlayViewMode) {
    if (self.mode == mode) {
      return
    }
    
    self.mode = mode
    
    if (mode == GGOverlayViewMode.Left) {
      imageView!.image = UIImage(named: "noButton")
    } else {
      imageView!.image = UIImage(named: "yesButton")
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView!.frame = CGRectMake(50, 50, 100, 100)
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
