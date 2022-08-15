//
//  parentViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit
import FirebaseAuth

class parentViewController: UIViewController {
    
    @IBOutlet weak var studentNameLabel: UILabel!
    private let gradesView = "goToGradesViewController"
    private let eventsView = "goToEventsViewController"

    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        studentNameLabel.text = userName
    }
 
    @IBAction func onGradesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: gradesView, sender: self)
    }
    
    @IBAction func onEventButtonTapped(_ sender: UIButton) {
       performSegue(withIdentifier: eventsView, sender: self)
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
