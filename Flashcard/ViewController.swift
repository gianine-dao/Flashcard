//
//  ViewController.swift
//  Flashcard
//
//  Created by Neen on 10/13/18.
//  Copyright © 2018 Gianine Dao. All rights reserved.
//

import UIKit

struct Flashcard {
    var Question: String
    var Answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    @IBOutlet weak var card: UIView!
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.Question
        backLabel.text = currentFlashcard.Answer
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete the flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)

    }
    
    func deleteCurrentFlashcard(){
    }
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(Question: "Who was the 23rd President of the United States?", Answer: "Benjamin Harrison")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
        frontLabel.isHidden = true
    }
    
    func updateFlashcard(Question: String, Answer: String) {
        let flashcard = Flashcard(Question: Question, Answer: Answer)
        frontLabel.text = Question
        backLabel.text = Answer
        flashcards.append(flashcard)
        print ("Added new flashcard")
        print ("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count -  1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveALLFlashcardsToDisk()
    }
    
    func saveALLFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["Question": card.Question, "Answer": card.Answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x:-300, y: 0.0)}, completion: {finished in
            self.updateLabels()
            self.animateCardIn()
            
        })
    }
    
    func animateCardIn(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
        
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array (forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in return Flashcard (Question: dictionary["Question"]!, Answer: dictionary["Answer"]!)}
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
}

