//
//  gradeAddProfessorViewController.swift
//  Final Project
//
//  Created by Group#15 on 2022-08-14.
//

import UIKit
import FirebaseFirestore

class gradeAddProfessorViewController: UIViewController {

    let db = Firestore.firestore()
    
    var studentName:String?
    var tests:[Dictionary<String, Any>] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        let docRef = db.collection("student").document(self.studentName!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.tests = document.data()!["Tests"]! as AnyObject as! [Dictionary<String, Any>]
                self.tableView.reloadData()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onAddGradesTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Grades", message: "Enter Grades Data", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Course"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Type"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter obtained Marks"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Weight Marks"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let courseTextField = alertController.textFields?[0] as? UITextField, let typeTextField = alertController.textFields?[1] as? UITextField,let obtainedMarksTextField = alertController.textFields?[2] as? UITextField, let weightTextField = alertController.textFields?[3] as? UITextField
            {
                
                let course = courseTextField.text
                let type = typeTextField.text
                let obtainedMarks = obtainedMarksTextField.text
                let weight = weightTextField.text
                
                let newTestData = [
                    "course": course,
                    "type": type,
                    "obtained": obtainedMarks,
                    "grades": weight
                ]
                
                self.tests.append(newTestData as [String : Any])
                
                self.db.collection("student").document(self.studentName!).updateData([
                    "Tests": self.tests
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        self.loadData()
                    }
                }
            }
        }))
        self.present(alertController, animated: true)
    }
}

extension gradeAddProfessorViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeViewProfessorCell", for: indexPath)
        let item = tests[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        let course = item["course"] as! String
        let type = item["type"] as! String
        content.text = "\(course)-\(type)"
        
        let obtained = item["obtained"] as! String
        let grades = item["grades"] as! String
        content.secondaryText = "\(obtained) / \(grades)"
        cell.contentConfiguration = content
        return cell
    }
}
