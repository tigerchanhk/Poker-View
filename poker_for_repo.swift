//
//  poker.swift
//  thirteen2
//
//  Created by Eric Chan on 15/7/31.
//  Copyright (c) 2015年 Eric Chan. All rights reserved.
//

// internal number 0 for "diamond 2", 1 for "club 2", .... 51 for "Spade A"

import UIKit


class Poker: UIView {
    
    internal var covered: Bool = false
    internal var rank : String = ""
    var suit : String = ""
    var color : UIColor = UIColor.blackColor()

    
    internal var number: Int!  {
        didSet{
           self.configrankandsuit()
        }
    }
    
    convenience init(frame: CGRect, andNumber: Int) {
        self.init(frame: frame)
        self.number = andNumber;
        self.configrankandsuit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configrankandsuit(){
        let remainder = number % 4
        var returnrank: String = ""
        
        switch remainder{
        case 0:
            self.suit = "\u{00002666}"
            color = UIColor.redColor()
        case 1:
            self.suit = "\u{00002663}"
            color = UIColor.blackColor()
        case 2:
            self.suit = "\u{00002665}"
            color = UIColor.redColor()
        case 3:
            self.suit = "\u{00002660}"
            color = UIColor.blackColor()
        default:
            break  // internal error
        }
        
        let array = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
        let r = number / 4
        let q = Int (r)
        if q >= 13 {abort()}
        returnrank = array[q]
        
        self.rank = returnrank
    }
    
    func choppedrect(frame: CGRect) ->CGRect {
        var newrect = frame
        let spacing = 2.0 as CGFloat
        
        newrect.origin.x = spacing
        newrect.origin.y = spacing
        newrect.size.height -= (2 * spacing)
        newrect.size.width -= (2 * spacing)
        return newrect
    }
    
    // MARK: - Painting
    override func drawRect(rect: CGRect) {

        let cardrect = self.choppedrect(rect)
        self.paint_backgroud(cardrect)
        
        if !self.covered {
            self.paint_openedcard()
        }
    }
    
    
    func paint_backgroud (rect: CGRect){
        
        UIColor.blackColor().setStroke()
        UIColor.whiteColor().setFill()
        
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        maskPath.lineWidth = 1.5
        maskPath.closePath()
        maskPath.stroke()
        maskPath.fill()
        
    }
    
    func paint_openedcard (){
        self.paint_text_oncard()
    }
    
    
    func paint_text_oncard(){
        
        var textsize = 20 as CGFloat
        
        
        let text = self.rank
        let font = UIFont(name: "Courier", size: textsize)
        let textColor = self.color
        let point = CGPoint(x: 10, y: 10)
        
        if let aGC = UIGraphicsGetCurrentContext() {
          

            let textFontAttributes = [
                NSForegroundColorAttributeName : textColor,
                NSFontAttributeName : font!
            ]
            text.drawAtPoint(point, withAttributes: textFontAttributes)
            var point2 = CGPoint(x: 9, y: 26)
            if isIpad! {
                point2  = CGPoint(x: 9, y: 46)
            }
            
            
            suit.drawAtPoint (point2, withAttributes: textFontAttributes)
            
            
            let spacing = 22 as CGFloat
            let aRect = CGRect(x: spacing ,y: spacing , width: bounds.size.width - 2 * spacing, height: bounds.size.height - 2 * spacing)
            
            if((self.number > 35 ) && (self.number < 48)){
                
                CGContextSetStrokeColorWithColor(aGC, color.CGColor)
                CGContextSetFillColorWithColor(aGC, UIColor.clearColor().CGColor)
                CGContextSetLineWidth(aGC, 0.5)
                CGContextStrokeRect(aGC,aRect)
                
            }
         
            let width = self.bounds.width
            let height = self.bounds.height
            CGContextTranslateCTM(aGC,  width  , height   );
              CGContextRotateCTM(aGC, 3.14);

            rank.drawAtPoint (point, withAttributes: textFontAttributes);
            suit.drawAtPoint (point2, withAttributes: textFontAttributes)
            
        }
        
    }
    
    
}
