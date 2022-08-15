//
//  professorViewController.swift
//  Final Project
//
//  Created by Group#15 on 2022-08-14.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

class professorViewController: UIViewController {
    
    private var goToAddGrades = "goToAddGradesViewController"
    private var goToAddEvent = "goToEventProfView"
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onAddGradesButtonTapped(_ sender: UIButton) {
        Analytics.logEvent("add_grades_button_tapped", parameters: nil)
        performSegue(withIdentifier: goToAddGrades, sender: self)
    }
    
    @IBAction func onAddEventButtonTapped(_ sender: UIButton) {
        Analytics.logEvent("add_events_button_tapped", parameters: nil)
        performSegue(withIdentifier: goToAddEvent, sender: self)
    }
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        Analytics.logEvent("professor_logout", parameters: nil)
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            dismiss(animated: true)
        } catch let signOutError as NSError {
            Analytics.logEvent("professor_logout_error", parameters: [
                "errorMessage": signOutError
            ])
            print("Error signing out \(signOutError)")
        }
    }
}
