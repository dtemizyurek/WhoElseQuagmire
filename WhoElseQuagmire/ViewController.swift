//
//  ViewController.swift
//  WhoElseQuagmire
//
//  Created by Doğukan Temizyürek on 5.04.2023.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score=0
    var timer=Timer()
    var counter=0
    var glennArray=[UIImageView]()
    var hideTimer=Timer()
    var highScore=0
    //Views
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBOutlet weak var HighScoreLabel: UILabel!
    
    @IBOutlet weak var Glenn1: UIImageView!
    
    @IBOutlet weak var Glenn2: UIImageView!
    
    @IBOutlet weak var Glenn3: UIImageView!
    
    @IBOutlet weak var Glenn4: UIImageView!
    
    @IBOutlet weak var Glenn5: UIImageView!
    
    @IBOutlet weak var Glenn6: UIImageView!
    
    @IBOutlet weak var Glenn7: UIImageView!
    
    @IBOutlet weak var Glenn8: UIImageView!
    
    @IBOutlet weak var Glenn9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreLabel.text="Score : \(score)"
        
        //HighScore Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore==nil
        {
            highScore=0
            HighScoreLabel.text="HighScore = \(highScore)"
        }
        if let newScore=storedHighScore as? Int
        {
            highScore=newScore
            HighScoreLabel.text="HighScore : \(highScore)"
        }
        
        Glenn1.isUserInteractionEnabled=true
        Glenn2.isUserInteractionEnabled=true
        Glenn3.isUserInteractionEnabled=true
        Glenn4.isUserInteractionEnabled=true
        Glenn5.isUserInteractionEnabled=true
        Glenn6.isUserInteractionEnabled=true
        Glenn7.isUserInteractionEnabled=true
        Glenn8.isUserInteractionEnabled=true
        Glenn9.isUserInteractionEnabled=true
        
        let recognizer1=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        Glenn1.addGestureRecognizer(recognizer1)
        Glenn2.addGestureRecognizer(recognizer2)
        Glenn3.addGestureRecognizer(recognizer3)
        Glenn4.addGestureRecognizer(recognizer4)
        Glenn5.addGestureRecognizer(recognizer5)
        Glenn6.addGestureRecognizer(recognizer6)
        Glenn7.addGestureRecognizer(recognizer7)
        Glenn8.addGestureRecognizer(recognizer8)
        Glenn9.addGestureRecognizer(recognizer9)
        
        glennArray=[Glenn1,Glenn2,Glenn3,Glenn4,Glenn5,Glenn6,Glenn7,Glenn8,Glenn9]
        
                       
        //Timers
        counter=10
        TimeLabel.text=String(counter)
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGlenn), userInfo: nil, repeats: true)
                      
        hideGlenn()
        

    }
    
    @objc func hideGlenn()
    {
        for glenn in glennArray{
            glenn.isHidden=true
        }
        
        let random=Int(arc4random_uniform(UInt32(glennArray.count-1)))
        glennArray[random].isHidden=false
    }
    
@objc func increaseScore()
    {
        score += 1
        ScoreLabel.text="Score : \(score)"

        
        
    }
    
    @objc func countDown()
    {
        counter -= 1
        TimeLabel.text=String(counter)
        
        if counter == 0
        {
            timer.invalidate()
            hideTimer.invalidate()
            for glenn in glennArray{
                glenn.isHidden=true
            }
            //HighScore
            if self.score > self.highScore
            {
                self.highScore=self.score
                HighScoreLabel.text="HighScore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey:"highscore")
            }
            
            //Alert
            let alert=UIAlertController(title: "Giggity", message: "Do you wanna play again", preferredStyle: UIAlertController.Style.alert)
            let okButton=UIAlertAction(title: "Fuck off", style: UIAlertAction.Style.cancel,handler: nil)
            let replayButton=UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                self.score=0
                self.ScoreLabel.text="Score : \(self.score)"
                self.counter=10
                self.TimeLabel.text=String(self.counter)
                
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGlenn), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
        }
    }

}

