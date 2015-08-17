//
//  ViewController.swift
//  TinderSimpleSwipeCardsSwift
//
//  Created by sydneyuser on 17/08/2015.
//  Copyright (c) 2015 sydneyuser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var draggableBackground:DraggableViewBackground?

  override func viewDidLoad() {
    super.viewDidLoad()
    draggableBackground = DraggableViewBackground(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
    self.view.addSubview(draggableBackground!)
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

