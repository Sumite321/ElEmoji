//
//  ViewController.swift
//  CarRacing
//
//  Created by Sumite Ramchande on 21/03/2018.
//  Copyright © 2018 Sumite Ramchande. All rights reserved.

import UIKit
import Foundation

//This protocol explains what actions this delegate will involve.
protocol helperDelegate {
    func setUpCollisionBoundary()
}

class ViewController: UIViewController, helperDelegate{
    
    //Images variables
    @IBOutlet weak var player: DraggedImageView!
    
    @IBOutlet weak var scoreText: UITextField!
    
    @IBOutlet weak var timerText: UITextField!
    var score = 0
    
    //obstacle cars variables
    var obstacleCars: [UIImage]!
    
    // timer, game loop
    var timer: Timer!
    var timer1: Timer!
    var gameOverImage: UIImageView!
    
    var playAgainButton:UIButton!
    var count = 20
    var i = 0
    
    //Behaviour variables
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    func setUpCollisionBoundary() {
        // clear out all the boundaries from the behaviour
        collisionBehavior.removeAllBoundaries()
        // create a boundary around the player frame
        collisionBehavior.addBoundary(withIdentifier: "boundary" as
            NSCopying, for: UIBezierPath(rect: player.frame))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        scoreText.text = "0"
        scoreText.tag = 300
        timerText.tag = 400
        //Assign viewController.swift as the delegate for the car image view
        player.myDelegate = self
        player.tag = 200
        //player.center = self.view.c
        obstacleCars = [UIImage(named: "car1.png")!,
                        UIImage(named: "car2.png")!,
                        UIImage(named: "car3.png")!,
                        UIImage(named: "car4.png")!,
                        UIImage(named: "car5.png")!,
                        UIImage(named: "car6.png")!]
        
     
        
        let date = Date().addingTimeInterval(0.5)
        timer = Timer(fireAt: date, interval: 1.7, target: self, selector: #selector(startObstacleAnimation), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        let date1 = Date().addingTimeInterval(0.5)
        timer1 = Timer(fireAt: date1, interval: 0, target: self, selector: #selector(calculateScore), userInfo: nil, repeats: true)
        RunLoop.main.add(timer1, forMode: RunLoopMode.commonModes)
        
        let when = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.gameOver(timer: self.timer)
        }
        
        //START > Behaviour code
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior()
        collisionBehavior = UICollisionBehavior()
        
        var timer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func startObstacleAnimation() -> Void {
        
        
        let tillThree = Int(arc4random_uniform(3))
        //Randomely select how many cars will appear at the same time out of three
        for _ in 0...tillThree {
            
            //add all the obstacles cars to the display
            let obstacle = UIImageView(image: nil)
            obstacle.tag = 50
            score += 5
            
            let random = Int(arc4random_uniform(UInt32(243))) + 53
            let c = Int(arc4random_uniform(6))
            obstacle.image = obstacleCars[c]
            obstacle.frame = CGRect(x: random, y: 0, width: 30, height: 60)
            self.view.addSubview(obstacle)
        
            dynamicItemBehavior.addItem(obstacle)
            
            //Make the obstacle cars move down
            let speed = Int(arc4random_uniform(140)) + 120
            dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: speed), for: obstacle)
            dynamicAnimator.addBehavior(dynamicItemBehavior)
            
            collisionBehavior.addItem(obstacle)
            
            //add the behaviour to the dynamic animator
            dynamicAnimator.addBehavior(collisionBehavior)
           
        }
        
    }
    
    func gameOver(timer: Timer) -> Void {
        timer.invalidate() //Stop the loop that calls the startObstacleAnimation()
        timer1.invalidate()
        gameOverImage = UIImageView(image: nil)
        gameOverImage.image = UIImage(named: "game_over.jpg")
        gameOverImage.frame = UIScreen.main.bounds
        self.view.addSubview(gameOverImage)
        
        self.view.bringSubview(toFront: gameOverImage)
        
        playAgainButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        playAgainButton.backgroundColor = .green
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        playAgainButton.center = self.view.center
        self.view.addSubview(playAgainButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        for view in self.view.subviews{
            print(view.tag)
            if(view.tag <= 100){
            view.removeFromSuperview()
            }
        }
        //self.view.removeFromSuperview();
        playAgainButton.removeFromSuperview();
        gameOverImage.removeFromSuperview();
        startAgain()
    }
    
    func startAgain(){
        self.viewDidLoad()
        score = 0
        i = 0
        count = 20
    }
    
    @objc func calculateScore(){
        
    
        for view in self.view.subviews{
            if(view.tag == 50 && player.frame.intersects(view.frame)){
                
                //score = score - (i/1000)
                i = i+1
                //print(score)
                print("i is " ,i/500)
                //print(score - (i/300))
                
                scoreText.text = String(score - (i/20))
            }
        
            
                //view.removeFromSuperview()}
            if(view.tag == 50 && view.frame.origin.y > UIScreen.main.bounds.size.height-5){
                print("You got a point")
                view.removeFromSuperview()
            }
            scoreText.text = String(score - (i/20))
        }
        
    }
    
    @objc func update() {
        
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String((count % 60))
            timerText.text = minutes + ":" + seconds
            count -= 1
        }
}
}
