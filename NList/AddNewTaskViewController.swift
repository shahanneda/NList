//
//  AddNewTaskViewController.swift
//  NList
//
//  Created by Shahan Nedadahandeh on 2020-04-01.
//  Copyright © 2020 Shahan Nedadahandeh. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        let topViewController = self.navigationController!.topViewController
        topViewController!.navigationItem.rightBarButtonItem = saveButton;
        topViewController!.navigationItem.leftBarButtonItem = cancelButton;

    }
    
    @objc func handleSave(){
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
