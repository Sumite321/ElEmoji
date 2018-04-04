//
//  responsiveBackground.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 04/04/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.
//

import UIKit

extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:width, height:height))
        //imageViewBackground.image = UIImage(named: "YOUR IMAGE NAME GOES HERE")
        
        //Create an array
        //and add all the road images to it
        var imageArray: [UIImage]!
        imageArray = [UIImage(named: "color23.png")!,
                      UIImage(named: "color22.png")!,
                      UIImage(named: "color21.png")!,
                      UIImage(named: "color20.png")!,
                      UIImage(named: "color19.png")!,
                      UIImage(named: "color18.png")!,
                      UIImage(named: "color17.png")!,
                      UIImage(named: "color16.png")!,
                      UIImage(named: "color15.png")!,
                    UIImage(named: "color14.png")!,
                    UIImage(named: "color13.png")!,
                    UIImage(named: "color12.png")!,
                    UIImage(named: "color11.png")!,
                    UIImage(named: "color10.png")!,
                    UIImage(named: "color9.png")!,
                    UIImage(named: "color8.png")!,
                    UIImage(named: "color7.png")!,
                    UIImage(named: "color6.png")!,
                    UIImage(named: "color5.png")!,
                    UIImage(named: "color4.png")!,
                    UIImage(named: "color3.png")!,
                    UIImage(named: "color2.png")!,
                    UIImage(named: "color1.png")!
        ]
        
        
        
        //animate the road images
        imageViewBackground.image = UIImage.animatedImage(with: imageArray, duration: 1.4)
        imageViewBackground.tag = 300
        
        
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }}
