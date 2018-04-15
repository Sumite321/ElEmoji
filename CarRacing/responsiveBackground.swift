//
//  responsiveBackground.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 04/04/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.
//

import UIKit

// screen width and height:
let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height
let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:width, height:height))
let homeImage = UIImageView(frame: CGRect(x:0, y:0, width:width, height:height))



extension UIView {
    
   
    
    func removeHomeImage(){
        
            homeImage.removeFromSuperview()
        
    }
    
    func addHomeBackground(){
        homeImage.image = UIImage(named:"emoji.jpg" )
        homeImage.tag = 600
        
        
        
        // you can change the content mode:
        homeImage.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(homeImage)
        self.sendSubview(toBack: homeImage)
        
    }
    
    func addBackground() {
      
        
        //let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:width, height:height))
        //imageViewBackground.image = UIImage(named: "YOUR IMAGE NAME GOES HERE")
        
        //Create an array
        //and add all the road images to it
        var imageArray: [UIImage]!
        imageArray = [
            UIImage(named: "c80.gif")!,
            UIImage(named: "c79.gif")!,
            UIImage(named: "c78.gif")!,
            UIImage(named: "c77.gif")!,
            UIImage(named: "c76.gif")!,
            UIImage(named: "c75.gif")!,
            UIImage(named: "c74.gif")!,
            UIImage(named: "c73.gif")!,
            UIImage(named: "c72.gif")!,
            UIImage(named: "c71.gif")!,
            UIImage(named: "c70.gif")!,
            UIImage(named: "c69.gif")!,
            UIImage(named: "c68.gif")!,
            UIImage(named: "c67.gif")!,
            UIImage(named: "c66.gif")!,
            UIImage(named: "c65.gif")!,
            UIImage(named: "c64.gif")!,
            UIImage(named: "c63.gif")!,
            UIImage(named: "c62.gif")!,
            UIImage(named: "c61.gif")!,
            UIImage(named: "c60.gif")!,
            UIImage(named: "c59.gif")!,
            UIImage(named: "c58.gif")!,
            UIImage(named: "c57.gif")!,
            UIImage(named: "c56.gif")!,
            UIImage(named: "c55.gif")!,
            UIImage(named: "c54.gif")!,
            UIImage(named: "c53.gif")!,
            UIImage(named: "c52.gif")!,
            UIImage(named: "c51.gif")!,
            UIImage(named: "c50.gif")!,
            UIImage(named: "c49.gif")!,
            UIImage(named: "c48.gif")!,
            UIImage(named: "c47.gif")!,
            UIImage(named: "c46.gif")!,
                      UIImage(named: "c45.gif")!,
                      UIImage(named: "c44.gif")!,
                      UIImage(named: "c43.gif")!,
                      UIImage(named: "c42.gif")!,
                      UIImage(named: "c41.gif")!,
                      UIImage(named: "c40.gif")!,
                      UIImage(named: "c39.gif")!,
                      UIImage(named: "c38.gif")!,
                      UIImage(named: "c37.gif")!,
                      UIImage(named: "c36.gif")!,
                      UIImage(named: "c35.gif")!,
                      UIImage(named: "c34.gif")!,
                      UIImage(named: "c33.gif")!,
                      UIImage(named: "c32.gif")!,
                      UIImage(named: "c31.gif")!,
                      UIImage(named: "c30.gif")!,
                      UIImage(named: "c29.gif")!,
                      UIImage(named: "c28.gif")!,
                      UIImage(named: "c27.gif")!,
                      UIImage(named: "c26.gif")!,
                      UIImage(named: "c25.gif")!,
                      UIImage(named: "c24.gif")!,
                        UIImage(named: "c23.gif")!,
                      UIImage(named: "c22.gif")!,
                      UIImage(named: "c21.gif")!,
                      UIImage(named: "c20.gif")!,
                      UIImage(named: "c19.gif")!,
                      UIImage(named: "c18.gif")!,
                      UIImage(named: "c17.gif")!,
                      UIImage(named: "c16.gif")!,
                      UIImage(named: "c15.gif")!,
                    UIImage(named: "c14.gif")!,
                    UIImage(named: "c13.gif")!,
                    UIImage(named: "c12.gif")!,
                    UIImage(named: "c11.gif")!,
                    UIImage(named: "c10.gif")!,
                    UIImage(named: "c9.gif")!,
                    UIImage(named: "c8.gif")!,
                    UIImage(named: "c7.gif")!,
                    UIImage(named: "c6.gif")!,
                    UIImage(named: "c5.gif")!,
                    UIImage(named: "c4.gif")!,
                    UIImage(named: "c3.gif")!,
                    UIImage(named: "c2.gif")!,
                    UIImage(named: "c1.gif")!
        ]
        
        
        
        //animate the road images
        imageViewBackground.image = UIImage.animatedImage(with: imageArray, duration: 3.4)
        imageViewBackground.tag = 300
        
        
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
    
    func removeAnimatedImage(){
        
        imageViewBackground.removeFromSuperview()
    }

}


