//
//  DraggableViewBackground.swift
//  blast
//
//  Created by sydneyuser on 15/08/2015.
//  Copyright (c) 2015 sydneyuser. All rights reserved.
//

import UIKit

class DraggableViewBackground: UIView, DraggableViewDelegate {
  
  let MAX_BUFFER_SIZE:Int = 2
  
  let CARD_WIDTH:Int = 290
  let CARD_HEIGHT:Int = 290
  
  
  let exampleCardLabels: NSArray = ["first","second","third","fourth","last"]
  let loadedCards: NSMutableArray = NSMutableArray()
  let allCards: NSMutableArray = NSMutableArray()
  
  var cardsLoadedIndex: Int = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    super.layoutSubviews()
    self.setupView()
    self.loadCards()
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    self.layer.borderWidth = 1
    self.backgroundColor = UIColor.lightGrayColor()
  }
  
  private func createDraggableViewAtIndex(index: NSInteger) -> DraggableView {
    let draggableView:DraggableView = DraggableView(frame: CGRectMake((CGFloat(self.frame.width) - CGFloat(CARD_WIDTH))/2, (self.frame.height - CGFloat(CARD_WIDTH))/2, CGFloat(CARD_WIDTH), CGFloat(CARD_HEIGHT)))
    draggableView.information?.text = exampleCardLabels.objectAtIndex(index) as? String
    draggableView.delegate = self
    return draggableView
  }
  
  private func loadCards() {
    if(exampleCardLabels.count > 0) {
      var numLoadedCardsCap:NSInteger?
      if (exampleCardLabels.count > MAX_BUFFER_SIZE) {
        numLoadedCardsCap = MAX_BUFFER_SIZE
      } else {
        numLoadedCardsCap = exampleCardLabels.count
      }
      for var i = 0; i < exampleCardLabels.count; i++ {
        let newCard: DraggableView = self.createDraggableViewAtIndex(i)
        
        allCards.addObject(newCard)
        
        if (i < numLoadedCardsCap) {
          
          loadedCards.addObject(newCard)
        }
      }
      
      for var i = 0; i < loadedCards.count; i++ {
        if (i > 0) {
          self.insertSubview(loadedCards.objectAtIndex(i) as! DraggableView, belowSubview: loadedCards.objectAtIndex(i-1) as! DraggableView)
        } else {
          self.addSubview(loadedCards.objectAtIndex(i) as! DraggableView)
        }
        cardsLoadedIndex++
      }
    }
  }
  
  func cardSwipedLeft(card: UIView) {
    loadedCards.removeObjectAtIndex(0)
    
    if (cardsLoadedIndex < allCards.count) {
      loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
      cardsLoadedIndex++
      self.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1)  as! DraggableView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! DraggableView)
    }
  }
  
  func cardSwipedRight(card: UIView) {
    loadedCards.removeObjectAtIndex(0)
    
    if (cardsLoadedIndex < allCards.count) {
      loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
      cardsLoadedIndex++
      println(loadedCards)
      self.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1)  as! UIView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! UIView)
    }
  }
  
  func cardSwipedUp(card: UIView) {
    loadedCards.removeObjectAtIndex(0)
    
    if (cardsLoadedIndex < allCards.count) {
      loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
      cardsLoadedIndex++
      self.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1)  as! DraggableView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! DraggableView)
    }
  }
  
  func cardSwipedDown(card: UIView) {
    loadedCards.removeObjectAtIndex(0)
    
    if (cardsLoadedIndex < allCards.count) {
      loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
      cardsLoadedIndex++
      self.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1)  as! DraggableView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! DraggableView)
    }
  }
  
  
  

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
