//
//  parentViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit

class parentViewController: UIViewController {
    
    @IBOutlet weak var gradesButton: UIButton!
    @IBOutlet weak var studentNameLabel: UILabel!

    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        studentNameLabel.text = userName
    }
 
}
