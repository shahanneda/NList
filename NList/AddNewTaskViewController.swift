//
//  AddNewTaskViewController.swift
//  NList
//
//  Created by Shahan Nedadahandeh on 2020-04-01.
//  Copyright © 2020 Shahan Nedadahandeh. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    @IBOutlet weak var TaskContentTextView: UITextView!
    var taskListTableViewController : TaskListTableViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        
        TaskContentTextView.layer.cornerRadius = 5
        TaskContentTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        TaskContentTextView.layer.borderWidth = 0.5
        TaskContentTextView.clipsToBounds = true
        
        let topViewController = self.navigationController!.topViewController
        topViewController?.navigationItem.title = "Create new Task"
        topViewController!.navigationItem.rightBarButtonItem = saveButton;
        topViewController!.navigationItem.leftBarButtonItem = cancelButton;

    }
    
    @objc func handleSave(){
        if let taskListTableViewController  = taskListTableViewController{
            let text =  TaskContentTextView.text!;
            //TODO:  add checks for duplicates and empty
            taskListTableViewController.addNewTask(withContent: text);
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
