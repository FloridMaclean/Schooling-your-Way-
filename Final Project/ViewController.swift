//
//  ViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailMissingLabel: UILabel!
    @IBOutlet weak var passwordMissingLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var parentView = "goToParentViewController"
    private let profView = "goToProfessorViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
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
            let message = "Try Again! Wrong id or password."
        let alert = UIAlertController(title: "Authentication", message: message, preferredStyle: .alert)

            let okButton = UIAlertAction(title: "OK", style: .default){ _ in
            }
            alert.addAction(okButton)
            self?.show(alert, sender: nil)
        password = ""
        }
        if email.contains("@student.ca") {
            self!.navigateToParentView()
        } else {
            self!.navigateToProfView()
        }
    }
    }
    
    func navigateToParentView() {
        performSegue(withIdentifier: parentView, sender: self)
    }
        
    func navigateToProfView() {
        performSegue(withIdentifier: profView, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == parentView {
//            if let userName = Auth.auth().currentUser?.email?.contains
            let destination = segue.destination as! parentViewController
            destination.userName = "Florid"
        }
    }
}
