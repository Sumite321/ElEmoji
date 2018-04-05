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
    
    
    @IBOutlet weak var player: DraggedImageView!
    @IBOutlet weak var scoreText: UITextField!
    
    @IBOutlet weak var timerText: UITextField!
    var score = 0
    
    //obstacle cars variables
    var obstacleCars: [UIImage]!
    
    // timer, game loop
    var timer: Timer!
    var timer1: Timer!
    var timer3: Timer!
    var gameOverImage: UIImageView!
    
    var playAgainButton:UIButton!
    var count = 20
    var i = 0
    var popup:UILabel!
    var showScore:UILabel!
    
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
        changePlayerImage()
        
    
        
        
        // **********
        player.myDelegate = self
        player.tag = 200
        //player.center = self.view.c
        obstacleCars = [UIImage(named: "snow.png")!,
                        UIImage(named: "rain.png")!,
                        UIImage(named: "hammer.png")!
                        ]
        
     
        
        // timer for obstacles to fall
        let date = Date().addingTimeInterval(3.5)
        timer = Timer(fireAt: date, interval: 1.1, target: self, selector: #selector(startObstacleAnimation), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        // timer for continuos score update
        let date1 = Date().addingTimeInterval(0.5)
        timer1 = Timer(fireAt: date1, interval: 0, target: self, selector: #selector(calculateScore), userInfo: nil, repeats: true)
        RunLoop.main.add(timer1, forMode: RunLoopMode.commonModes)
        
        // game over screen
        let when = DispatchTime.now() + 22
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.gameOver(timer: self.timer)
        }
        
        // behaviours
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior()
        collisionBehavior = UICollisionBehavior()
        
        
        
        
        // customise the view
        popup = UILabel(frame: CGRect(x:0, y:0, width:280, height:31))
        popup.center = self.view.center
        popup.text = "You have 20 seconds"
        popup.textColor = UIColor.white
        popup.font = popup.font.withSize(30)
        popup.alpha = 0
        
        popup.fadeIn(completion: {
            (finished: Bool) -> Void in
            self.popup.fadeOut()
        })
        
        
        
            // show on screen
            self.view.addSubview(popup)
            
            // timer for alert
            Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)

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
            let randomWidth = Int(arc4random_uniform(UInt32(15))) + 30
            let c = Int(arc4random_uniform(3))
            obstacle.image = obstacleCars[c]
            obstacle.frame = CGRect(x: random, y: 0, width: randomWidth, height: 60)
            self.view.addSubview(obstacle)
        
            dynamicItemBehavior.addItem(obstacle)
            
            //Make the obstacle come down
            // random speeds, some faster some slower
            let speed = Int(arc4random_uniform(240)) + 120
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
        gameOverImage.image = UIImage(named: "gameOver.png")
        gameOverImage.frame = UIScreen.main.bounds
        self.view.addSubview(gameOverImage)
        
        self.view.bringSubview(toFront: gameOverImage)
        
        playAgainButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 130, y: UIScreen.main.bounds.size.height - 90, width: 100, height: 50))
        playAgainButton.backgroundColor = .green
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //playAgainButton.center = self.view.center
//        // customise the view
        showScore = UILabel(frame: CGRect(x:20, y:20, width:200, height:21))
        //showScore.center = self.view.center
        showScore.text = "Your final score is " + String(score)
        showScore.textColor = UIColor.white
        showScore.font = showScore.font.withSize(20)
        
        
        // show on screen
        self.view.addSubview(showScore)
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
        showScore.removeFromSuperview()
        startAgain()
    }
    
    func startAgain(){
        self.viewDidLoad()
        score = 0
        i = 0
        count = 20
        timer3.invalidate()
    }
    
    @objc func calculateScore(){
        
    
        for view in self.view.subviews{
            if(view.tag == 50 && player.frame.intersects(view.frame)){
                
                //score = score - (i/1000)
                i = i+1
                //print(score)
                print("i is " ,i/500)
                //print(score - (i/300))
                player.image = UIImage(named:"redface.png")
                scoreText.text = String(score - (i/20))
            }
        
            
                //view.removeFromSuperview()}
            if(view.tag == 50 && view.frame.origin.y > UIScreen.main.bounds.size.height-5){
                changePlayerImage()
                view.removeFromSuperview()
            }
            scoreText.text = String(score - (i/20))
            
        }
        
    }
    
    @objc func update() {
        if(count >= 0){
            let minutes = String(count / 60)
            let seconds = String((count % 60))
            if(count < 5){timerText.fadeIn()
                timerText.textColor = UIColor.red
                count -= 1
                timerText.text = minutes + ":" + seconds
            }else{
            timerText.text = minutes + ":" + seconds
            count -= 1
                timerText.textColor = UIColor.black}
        }
}

    
    @objc func dismissAlert(){
        if popup != nil { // Dismiss the view from here
            popup.removeFromSuperview()
            timer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
    }
    
    func changePlayerImage(){
 
        var imageArray: [UIImage]!
        imageArray = [UIImage(named: "frame1.gif")!,
                      UIImage(named: "frame2.gif")!,
                      UIImage(named: "frame3.gif")!,
                      UIImage(named: "frame4.gif")!,
                      UIImage(named: "frame5.gif")!,
                      UIImage(named: "frame6.gif")!,
                      UIImage(named: "frame7.gif")!,
                      UIImage(named: "frame8.gif")!,
                      UIImage(named: "frame9.gif")!,
                      UIImage(named: "frame10.gif")!]
        
        
        
        //animate the road images
        player.image = UIImage.animatedImage(with: imageArray, duration: 1.4)
        
        
        
        
        // you can change the content mode:
        player.contentMode = UIViewContentMode.scaleAspectFill
        
    }
}
