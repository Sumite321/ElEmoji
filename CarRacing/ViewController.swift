//
//  ViewController.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 21/03/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
 
    @IBOutlet weak var roadImage: UIImageView!
    
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    
    @IBOutlet weak var car: UIImageView!
    var cars = ["car1.png","car2.png", "car3.png"]
    let carArray = [1,2,3,4,5]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Animation of walking
        var imageArray: [UIImage]!
        
        imageArray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!,
                      UIImage(named: "road11.png")!,
                      UIImage(named: "road12.png")!,
                      UIImage(named: "road13.png")!,
                      UIImage(named: "road14.png")!,
                      UIImage(named: "road15.png")!,
                      UIImage(named: "road16.png")!,
                      UIImage(named: "road17.png")!,
                      UIImage(named: "road18.png")!,
                      UIImage(named: "road19.png")!,
                      UIImage(named: "road20.png")!]
        
        roadImage.image = UIImage.animatedImage(with: imageArray, duration: 1)
       
        
        
        //randomImgPicker() // getting a random image
        /*
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        dynamicItemBehavior = UIDynamicItemBehavior(items: [car])
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: 300), for: car)
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        */
        
        for index in 0...2{
            
            let delay = Double(carArray[index])
            
            let when = DispatchTime.now() + delay
            
            DispatchQueue.main.asyncAfter(deadline: when){
                let carView = UIImageView(image:nil)
                carView.image = UIImage(named: self.cars[index])
                carView.frame = CGRect(x: 0, y: 300, width: 30 , height: 50)
                self.view.addSubview(carView)
                
                self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
                
                self.dynamicItemBehavior = UIDynamicItemBehavior(items: [self.car])
                self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0,y: 300), for:self.car)
                self.dynamicAnimator.addBehavior(self.dynamicItemBehavior)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomImgPicker() {
        let randomNumber = Int(arc4random_uniform(UInt32(cars.count))) // generating random number
        car.image = UIImage(named: cars[randomNumber])
    }
    
}

