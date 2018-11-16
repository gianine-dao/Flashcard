//
//  CreationViewController.swift
//  Flashcard
//
//  Created by Neen on 10/27/18.
//  Copyright © 2018 Gianine Dao. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    @IBAction func didTapOnCancel(_ sender: Any) {dismiss (animated: true)
    }

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    

    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        flashcardsController.updateFlashcard(Question: questionText!, Answer: answerText!)
        dismiss(animated: true)
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
}
