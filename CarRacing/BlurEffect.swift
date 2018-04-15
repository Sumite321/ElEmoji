//
//  BlurEffect.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 15/04/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.
//


import Foundation
import UIKit

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
