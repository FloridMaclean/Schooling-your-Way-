//
//  parentViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class parentViewController: UIViewController {
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentIdLabel: UILabel!
    @IBOutlet weak var studentEmailLabel: UILabel!
    @IBOutlet weak var studentAddressLael: UILabel!
    
    let db = Firestore.firestore()
    
    private var goToGrades = "goToGradesViewController"
    private var goToEvents = "goToEventsViewController"
    
    var studentEmail: String?
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudentProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToGrades {
            let destination = segue.destination as! gradesViewController
            destination.studentId = studentEmail
        }
    }
    
    private func fetchStudentProfile() {
        let docRef = db.collection("student").document(studentEmail ?? "stud1")

        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let address = document.data()!["Address"]! as AnyObject as! String
                let name = document.data()!["name"]! as AnyObject as! String
                let studentId = document.data()!["studentId"]! as AnyObject as! String
                
                studentNameLabel.text = name
                studentEmailLabel.text = studentEmail
                studentIdLabel.text = studentId
                studentAddressLael.text = address
                
            } else {
                print("Document does not exist")
            }
        }
    }
 
    @IBAction func onGradesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToGrades, sender: self)
    }
    
    @IBAction func onEventsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: goToEvents, sender: self)
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
