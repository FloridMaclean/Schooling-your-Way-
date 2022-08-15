//
//  gradesViewController.swift
//  Final Project
//
//  Created by Florid Maclean on 2022-08-14.
//

import UIKit
import FirebaseFirestore

class gradesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    
    private var studGrades: [studGrade] = []
    
    var studentId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        fetchConciseData()
    }
    
    private func fetchConciseData() {
        let docRef = db.collection("student").document(studentId ?? "stud1")

        docRef.getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        let tests = document.data()!["Tests"]! as AnyObject as! [Dictionary<String, Any>]
                        
                        for test in tests {
                            let courseTest = "\(test["course"]!) - \(test["type"]!)"
                            let grades = "\(test["obtained"]!)/\(test["grades"]!)"
                            studGrades.append(studGrade(courseTest: courseTest, grades: grades))
                        }
                        print(studGrades)
                        tableView.reloadData()
                    } else {
                        print("Document does not exist")
                    }
                }
    }
    
    
    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension gradesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studGrades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studGradeCell", for: indexPath)
        let studGrade = studGrades[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = studGrade.courseTest
        content.secondaryText = studGrade.grades
        
        cell.contentConfiguration = content
        return cell
    }
}

struct studGrade {
    var courseTest: String
    var grades: String
}
