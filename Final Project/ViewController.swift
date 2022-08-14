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
    
    private var parentView = "goToParentViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
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
        if email == "\("")@student.ca" {
            navigateToParentView()
        }
        
    }
    
    func navigateToParentView() {
        performSegue(withIdentifier: parentView, sender: self)
    }
}
}
