//
//  parentViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit

class parentViewController: UIViewController {
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    private var goToGrades = "goToGradesViewController"
    private var goToEvents = "goToEventsViewController"

    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        studentNameLabel.text = userName
    }
 
    @IBAction func onGradesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToGrades, sender: self)
    }
    
    @IBAction func onEventsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToEvents, sender: self)
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
    }
}
