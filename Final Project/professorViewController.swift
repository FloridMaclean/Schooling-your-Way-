//
//  professorViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit

class professorViewController: UIViewController {
    
    private var goToAddGrades = "goToAddGradesViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func onAddGradesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToAddGrades, sender: self)
    }
}
