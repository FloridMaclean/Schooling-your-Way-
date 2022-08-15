//
//  ViewController.swift
//  Final Project
//
//  Created by Group#15 on 2022-08-14.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailMissingLabel: UILabel!
    @IBOutlet weak var passwordMissingLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var parentView = "goToParentViewController"
    private let profView = "goToProfessorViewController"
    
    var studentId: String?

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("login_page", parameters: nil)
        emailMissingLabel.isHidden = true
        passwordMissingLabel.isHidden = true
        loginButton.isEnabled = false
    }
    
    @IBAction func emailTextFeildMissing(_ sender: UITextField) {
        if(emailText.text == "") {
               emailMissingLabel.isHidden = false
        } else {
               emailMissingLabel.isHidden = true
           }
    }
    
    
    @IBAction func passwordTextFieldMissing(_ sender: UITextField) {
        if(passwordText.text == "") {
            passwordMissingLabel.isHidden = false
        } else {
            passwordMissingLabel.isHidden=true
        }
        
        if(emailText.text != "" && passwordText.text != "") {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
        let email = emailText.text  ?? ""
        var password = passwordText.text ?? ""
    
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard self != nil else {
            return
        }
        if error != nil {
            Analytics.logEvent("login_success", parameters: [
                "message": error ?? "Login Error"
            ])
            let message = "Try Again! Wrong id or password."
        let alert = UIAlertController(title: "Authentication", message: message, preferredStyle: .alert)

            let okButton = UIAlertAction(title: "OK", style: .default){ _ in
            }
            alert.addAction(okButton)
            self?.show(alert, sender: nil)
        password = ""
        }
        Analytics.logEvent("login_success", parameters: nil)
        if email.contains("@student.ca") {
            self!.navigateToParentView()
        } else {
            self!.navigateToProfView()
        }
        self!.emailText.text = ""
        self!.passwordText.text = ""
        self!.loginButton.isEnabled = false
    }
    }
    
    func navigateToParentView() {
        Analytics.logEvent("navigate_to_parentView", parameters: nil)
        performSegue(withIdentifier: parentView, sender: self)
    }
        
    func navigateToProfView() {
        Analytics.logEvent("navigate_to_profView", parameters: nil)
        performSegue(withIdentifier: profView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == parentView {
            let destination = segue.destination as! parentViewController
            destination.userName = emailText.text ?? "That's me!"
        }
        
        if segue.identifier == parentView {
            let destination = segue.destination as! parentViewController
            destination.studentEmail = emailText.text ?? "stud1"
        }
    }
}
