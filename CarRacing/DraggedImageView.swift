//
//  DraggedImageView.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 21/03/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.
//

import UIKit

class DraggedImageView: UIImageView {
    
    var myDelegate: subviewDelegate?
    
    //global variable
    var startLocation = CGPoint(x: 0, y: 0)
    
    //when touches begin, record the touch's beginning
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startLocation = (touches.first?.location(in: self))!
        
    }
    
    //when the touch moves, find the coodinate of the current touch
    //and set the center position  the image
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Calculate offset
        let pt: CGPoint? = touches.first?.location(in: self)
        let dx: Float = Float((pt?.x)! - startLocation.x)
        let dy: Float = Float((pt?.y)! - startLocation.y)
        var newcenter = CGPoint(x: CGFloat((center.x + CGFloat(dx) )), y: CGFloat((center.y + CGFloat(dy) )))
        
        // Constrain movement into parent bounds
        let halfx: Float = Float(bounds.midX)
        newcenter.x = CGFloat(max(halfx, Float(newcenter.x)))
        newcenter.x = min((superview?.bounds.size.width)! - CGFloat(halfx), CGFloat(newcenter.x))
        let halfy: Float = Float(bounds.midY)
        newcenter.y = CGFloat(max(halfy, Float(newcenter.y)))
        newcenter.y = min((superview?.bounds.size.height)! - CGFloat(halfy), CGFloat(newcenter.y))
        
        self.center = newcenter
        
        self.myDelegate?.changeSomething()
        
    }
    
    //    //restricting car to not cross right or left screen boundry (x axes)
    //    func constraintX(dx:CGFloat) -> Float {
    //        let screenSize = UIScreen.main.bounds
    //
    //        var cx = self.center.x+dx
    //        if (cx > screenSize.width - 20 ) {
    //            cx = screenSize.width - 20
    //        }
    //        if (cx < (0 + 20)) {
    //            cx = 0+20
    //        }
    //
    //        return Float(cx)
    //    }
    //
    //    //restricting car to not cross bottom or
    //    //top certian part of the screen boundry (y axes)
    //    func constraintY(dy:CGFloat) -> Float {
    //        let screenSize = UIScreen.main.bounds
    //
    //        var cy = self.center.y+dy
    //        if (cy > screenSize.height - 50) {
    //            cy = screenSize.height - 50
    //        }
    //        if (cy < 0 + 230) {
    //            cy = 0 + 230
    //        }
    //
    //        return Float(cy)
    //    }
    
}

