//
//  ViewController.swift
//  Project2
//
//  Created by Alexander Thompson on 19/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: nil)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var alertText: String
        questionsAsked += 1
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            alertText = "Your score is \(score)."
        } else {
            title = "Wrong"
            score -= 1
            alertText = "Wrong! Thats the flag of \(countries[sender.tag]). Your score is \(score)"
        }
        if questionsAsked < 10 {
        let ac = UIAlertController(title: title, message: alertText , preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        }
        if questionsAsked == 10 {
        let endGame = UIAlertController(title: "Game Over", message: "Your final score is \(score) out of 10", preferredStyle: .alert)
        endGame.addAction(UIAlertAction(title: "New Game", style: .default, handler: askQuestion))
        present(endGame, animated: true, completion: nil)
            score = 0
            questionsAsked = 0
        }
    }

}

