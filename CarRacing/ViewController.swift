//
//  ViewController.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 21/03/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.

import UIKit
import Foundation

//This protocol explains what actions this delegate will involve.

class ViewController: UIViewController{
    
    //Images variables
    @IBOutlet weak var roadImage: UIImageView!
    @IBOutlet weak var player: DraggedImageView!
    
    
    //display score and score variable
    @IBOutlet weak var displayScore: UILabel!
    var score = 0
    
    //obstacle cars variables
    var obstacleCars: [UIImage]!
    
    //Behaviour variables
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign viewController.swift as the delegate for the car image view
        player.myDelegate = self
        
        obstacleCars = [UIImage(named: "car1.png")!,
                        UIImage(named: "car2.png")!,
                        UIImage(named: "car3.png")!,
                        UIImage(named: "car4.png")!,
                        UIImage(named: "car5.png")!,
                        UIImage(named: "car6.png")!]
        
        //Create an array
        //and add all the road images to it
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
        
        
        
        //animate the road images
        roadImage?.image = UIImage.animatedImage(with: imageArray, duration: 0.4)
        
        
        let date = Date().addingTimeInterval(0.5)
        let timer = Timer(fireAt: date, interval: 1.7, target: self, selector: #selector(startObstacleAnimation), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        
        let when = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.gameOver(timer: timer)
        }
        
        //START > Behaviour code
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func startObstacleAnimation() -> Void {
        
        
        let many = Int(arc4random_uniform(3))
        //Randomely select how many cars will appear at the same time out of three
        for _ in 0...many {
            
            //add all the obstacles cars to the display
            let oCar = UIImageView(image: nil)
            let random = Int(arc4random_uniform(UInt32(243))) + 53
            let c = Int(arc4random_uniform(6))
            oCar.image = obstacleCars[c]
            oCar.frame = CGRect(x: random, y: 0, width: 30, height: 50)
            self.view.addSubview(oCar)
            
//            score = score + 1
//            displayScore.text = String(score)
            
            dynamicItemBehavior.addItem(oCar)
            
            //Make the obstacle cars move down
            let speed = Int(arc4random_uniform(140)) + 120
            dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: speed), for: oCar)
            dynamicAnimator.addBehavior(dynamicItemBehavior)
            
            
            
            
        }
        
    }
    
    func gameOver(timer: Timer) -> Void {
        timer.invalidate() //Stop the loop that calls the getCar function
        let over = UIImageView(image: nil)
        over.image = UIImage(named: "game_over.jpg")
        over.frame = UIScreen.main.bounds
        self.view.addSubview(over)
        
        self.view.bringSubview(toFront: over)
    }
    
}

