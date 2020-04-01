//
//  TaskListTableViewController.swift
//  NList
//
//  Created by Shahan Nedadahandeh on 2020-04-01.
//  Copyright © 2020 Shahan Nedadahandeh. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    var tasks = [Task]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSampleData();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    override func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView?{
//        tableView.frame.size.height = 2;
        let frame =  tableView.frame;
        let view = UIView(frame: CGRect(x:0,  y:0, width: frame.size.width, height: frame.size.height+10));

        view.backgroundColor = UIColor.black;
        let buttonWidth = 30;
        let addButton = UIButton(frame: CGRect( x: Int(frame.width) -  buttonWidth - 5, y:0, width: buttonWidth, height:buttonWidth));

        addButton.tag = section;
        addButton.setImage(UIImage(named: "AddButtonSymbol"), for: UIControl.State.normal);
        addButton.addTarget(self,action:#selector(addButtonClicked),for:.touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(addButton);
        
        NSLayoutConstraint.activate([
              addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              addButton.heightAnchor.constraint(equalToConstant: 50),
              addButton.widthAnchor.constraint(equalToConstant: 50)
          ])
       

//        NSLayoutConstraint(item: addButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true;
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;// this is to force it to update

        return  view;
        
    }
    
    @objc func addButtonClicked(sender:UIButton){
        
    }
    func createSampleData(){
        let task1 = Task(content: "Walk the dog.");
        let task2 = Task(content: "Practice new piano song.");
        let task3 = Task(content: "Study for upcoming test.");
        
        tasks += [task1, task2, task3];
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        guard let taskCell = cell as? TaskTableViewCell else{
            print("Failed to cast to TaskTableViewCell");
            fatalError();
        };
        
        let task = tasks[indexPath.row];
    
        print("task content: " + task.content);
        taskCell.ContentLabel.text = task.content;
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
