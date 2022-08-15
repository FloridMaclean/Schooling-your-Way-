//
//  professorViewController.swift
//  Final Project
//
//  Created by Group#15 on 2022-08-14.
//

import UIKit
import FirebaseAuth

class professorViewController: UIViewController {
    
    private var goToAddGrades = "goToAddGradesViewController"
    private var goToAddEvent = "goToEventProfView"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func onAddGradesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToAddGrades, sender: self)
    }
    
    @IBAction func onAddEventButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToAddEvent, sender: self)
    }
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            dismiss(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out \(signOutError)")
        }
    }
}
