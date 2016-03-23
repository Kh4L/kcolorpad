//
//  ViewController.swift
//  DrawPad
//
//  Created by Jean-Pierre Distler on 13.11.14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlet
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var tempImageView: UIImageView!

  // MARK: - Prorieties
  var lastPoint = CGPoint.zero
  var red: CGFloat = 0.0
  var green: CGFloat = 0.0
  var blue: CGFloat = 0.0
  var brushWidth: CGFloat = 10.0
  var opacity: CGFloat = 1.0
  var swiped: Bool = false
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    swiped = false
    if let touch = touches.first {
      lastPoint = touch.locationInView(self.view)
      debugPrint(lastPoint)
    }
  }
  
  // MARK: - Drawing
  
  func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
    
    // 1
    UIGraphicsBeginImageContext(view.frame.size)
    let context = UIGraphicsGetCurrentContext()
    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
    
    // 2
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
    
    // 3
    CGContextSetLineCap(context, CGLineCap.Round)
    
    CGContextSetLineWidth(context, brushWidth)
    CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
    CGContextSetBlendMode(context, CGBlendMode.Normal)
    
    // 4
    CGContextStrokePath(context)
    
    // 5
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    tempImageView.alpha = opacity
    UIGraphicsEndImageContext()
    
  }
  
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    // 6
    swiped = true
    if let touch = touches.first as? UITouch {
      let currentPoint = touch.locationInView(view)
      drawLineFrom(lastPoint, toPoint: currentPoint)
      
      // 7
      lastPoint = currentPoint
    }
  }
  
  // MARK: - Actions
  
  @IBAction func reset(sender: AnyObject) {
  }

  @IBAction func share(sender: AnyObject) {
  }
  
  @IBAction func pencilPressed(sender: AnyObject) {
  }
  
}

