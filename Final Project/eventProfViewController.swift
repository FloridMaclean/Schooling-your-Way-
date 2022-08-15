//
//  eventProfViewController.swift
//  Final Project
//
//  Created by Group#15 on 2022-08-15.
//

import UIKit
import FirebaseFirestore

class eventProfViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var events:[Dictionary<String, Any>] = []
    private var datePicker: UIDatePicker?
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func loadData(){
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if err != nil {
                print("Error getting documents: (err)")
            } else {
                self.events = []
                for document in querySnapshot!.documents {
                    let tests = document.data()
                    self.events.append(tests)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func onAddEventButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Add Grades", message: "Enter Grades Data", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Event Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "DD/MM/YYYY"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let eventNameTextField = alertController.textFields?[0] as? UITextField, let eventDateTextField = alertController.textFields?[1] as? UITextField
            {
                
                let name = eventNameTextField.text
                let date = eventDateTextField.text
                
                let newTestData = [
                    "eventName": name,
                    "eventDate": date,
                ]

                self.db.collection("events").document(name!).setData(newTestData as [String : Any]) { err in
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
}

extension eventProfViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventProfCell", for: indexPath)
        let item = events[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item["eventName"] as? String
        content.secondaryText = item["eventDate"] as? String
        cell.contentConfiguration = content
        return cell
    }
}

struct Event{
    var eventName:String
    var eventDate:String
}
