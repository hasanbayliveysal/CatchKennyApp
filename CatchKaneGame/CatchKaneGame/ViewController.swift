//
//  ViewController.swift
//  CatchKaneGame
//
//  Created by Veysal on 10.09.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var buttonText: UIButton!
    
    var kennyArray = [UIImageView]()
    var lastScore = 0
    var storedScore = 0
    var timer = Timer()
    var hideKennytimer = Timer()
    var time = 11
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(onTappedPicture))
        
        image1.addGestureRecognizer(gestureRecognizer1)
        image2.addGestureRecognizer(gestureRecognizer2)
        image3.addGestureRecognizer(gestureRecognizer3)
        image4.addGestureRecognizer(gestureRecognizer4)
        image5.addGestureRecognizer(gestureRecognizer5)
        image6.addGestureRecognizer(gestureRecognizer6)
        image7.addGestureRecognizer(gestureRecognizer7)
        image8.addGestureRecognizer(gestureRecognizer8)
        image9.addGestureRecognizer(gestureRecognizer9)

        kennyArray = [image1,image2,image3,image4,image5,image6,image7,image8,image9]
    
        storedScore = UserDefaults.standard.object(forKey: "highScore") as! Int
        print(storedScore)
        highScoreLabel.text = "HighScore : \(String(storedScore))"
        hide()
        
       
        
    }
    func hide(){
        for kenny in kennyArray {
           kenny.isHidden = true
        }
    }
    
    @objc func hideKenny (){
        
        for kenny in kennyArray {
           kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count)))
        
        kennyArray[random].isHidden = false
    }

 

    @objc func onTappedPicture(){
       
        score += 1
        scoreLabel.text = "Score : \(String(score))"
      
    }
    var startGame = true
    @IBAction func onClickStart(_ sender: Any) {
        if startGame {
            
            time = 11
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimeStart), userInfo: nil, repeats: true)
            
            hideKennytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
            
            
            startGame = false
            buttonText.isUserInteractionEnabled = false
        } else {
            time = 11
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimeStart), userInfo: nil, repeats: true)
            hideKennytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
                startGame = true
            buttonText.isUserInteractionEnabled = false
        }
        
    }
    
    @objc func onTimeStart(){
        
      
        
        time -= 1
        timerLabel.text = "Time left : \(time)"
        
        if time <= 0 {
            timer.invalidate()
            hideKennytimer.invalidate()
            timerLabel.text = "Time is over"
            
            let alert = UIAlertController(title: "Time Is Over", message: "Do you want to play again", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: { (action:UIAlertAction!) in
                exit(0)
            })
            
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
            
            if score > storedScore {
                UserDefaults.standard.set(score, forKey: "highScore")
                highScoreLabel.text = "HighScore : \(String(score))"
            }
            buttonText.setTitle("Start Again", for: .normal)
            buttonText.isUserInteractionEnabled = true
            score = 0
            scoreLabel.text = "Score : \(score)"
            hide()
            

        }
    }
}

