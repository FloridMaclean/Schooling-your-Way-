//
//  ViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    private var parentView = "goToParentViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
        navigateToParentView()
    }
    
    func navigateToParentView() {
        performSegue(withIdentifier: parentView, sender: self)
    }
}

