//
//  addGradesViewController.swift
//  Final Project
//
//  Created by Sanket Patel on 2022-08-14.
//

import UIKit
import FirebaseFirestore

class addGradesViewController: UIViewController {
    
    let db = Firestore.firestore()
    private var goToGradeAddView = "goTogradeAddProfessorViewController"
    
    private var students:[String] = []
    private var student:String = "DefaultName"
    private var allData:[[Dictionary<String, Any>]] = []
    private var data:[Dictionary<String, Any>] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadData(){
        db.collection("student").getDocuments() { (querySnapshot, err) in
            if err != nil {
                print("Error getting documents: (err)")
            } else {
                self.allData = []
                self.students = []
                for document in querySnapshot!.documents {
                    let name = document.documentID
                    
                    let tests = document.data()["Tests"]! as AnyObject as! [Dictionary<String, Any>]
                    self.allData.append(tests)
                    self.students.append(name)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onAddStudentButtontapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Add Grades", message: "Enter Grades Data", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Student Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Student ID"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Student Address"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter Student email"
        }
    
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let nameTextField = alertController.textFields?[0] as? UITextField, let studentIDTextField = alertController.textFields?[1] as? UITextField,let studentAddressTextField = alertController.textFields?[2] as? UITextField,let studentEmailTextField = alertController.textFields?[3] as? UITextField
            {
                
                let name = nameTextField.text
                let studentID = studentIDTextField.text
                let studentAddress = studentAddressTextField.text
                let studentEmail = studentEmailTextField.text
                let newStudentData = [
                    "name": name!,
                    "studentId": studentID!,
                    "Address": studentAddress!,
                    "Tests":[]
                ] as [String : Any]
                
//                self.tests.append(newTestData as [String : Any])
//
//                self.db.collection("student").document(self.studentName!).updateData([
//                    "Tests": self.tests
//                ]){ err in
//                    if let err = err {
//                        print("Error updating document: \(err)")
//                    } else {
//                        print("Document successfully updated")
//                        self.loadData()
//                    }
//                }
                
                self.db.collection("student").document(studentEmail!).setData(newStudentData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.loadData()
                        }
                    }
            }
        }))
        self.present(alertController, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == goToGradeAddView {
                let destination = segue.destination as! gradeAddProfessorViewController
                destination.studentName = self.student
//                destination.tests = self.data
            }
        }
}

extension addGradesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentNameCell", for: indexPath)
        let item = students[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        return cell
    }
}
extension addGradesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.student = self.students[indexPath.row]
        self.data = self.allData[indexPath.row]
        performSegue(withIdentifier: goToGradeAddView, sender: self)
    }
}


