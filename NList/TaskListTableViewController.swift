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
//        createSampleData();
        loadData();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    public func addNewTask(withContent content : String){

        tableView.beginUpdates();
        tasks += [Task(content: content)];
        self.tableView.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .left)
        tableView.endUpdates();
        
        saveData(withReload: false);
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func loadData(){
        tasks = Task.getTasks();
    }
    
    func saveData(withReload : Bool = true){
        Task.saveTasks(tasks: tasks);
        if(withReload){
            self.tableView.reloadData();
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil;
    }
    override func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView?{
        
        let frame =  tableView.frame;
        let view = UIView(frame: CGRect(x:0,y:0,width: frame.width, height: frame.height));

        view.backgroundColor = UIColor.systemGray6;
        let addButton = UIButton();
        let sectionTitleLabel =  UILabel();

        addButton.tag = section;
        addButton.setImage(UIImage(named: "AddButtonSymbol"), for: UIControl.State.normal);
        addButton.addTarget(self,action:#selector(addButtonClicked),for:.touchUpInside)
        addButton.imageView?.contentMode = .scaleAspectFill;
        addButton.contentVerticalAlignment = .fill
        addButton.contentHorizontalAlignment = .fill


        sectionTitleLabel.text = "To Do List:";
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        
        view.addSubview(sectionTitleLabel);
        view.addSubview(addButton);
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            
            sectionTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            sectionTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ]);
        return  view;
        
    }
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.0;
    }
    @objc func addButtonClicked(sender:UIButton){
        print("Add button clicked");
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let addPage = storyboard.instantiateViewController(withIdentifier: "addViewController") as! AddNewTaskViewController;
        let navigationController  = UINavigationController(rootViewController: addPage);
        
        addPage.taskListTableViewController = self;
        navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet;
//        navigationController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.present(navigationController, animated: true, completion: nil  )
    }
    func createSampleData(){
        let task1 = Task(content: "Walk the dog.");
        let task2 = Task(content: "Practice new piano song.");
        let task3 = Task(content: "Study for upcoming test.");
        
        tasks += [task1, task2, task3];
        saveData();
    }
    
//    func checkmarkRow(at : IndexPath, state : Bool){
//        tasks[at.row].isDone = state;
//    }
    func rowCheckMarkButtonClicked(at : IndexPath){
        tasks[at.row].isDone = !tasks[at.row].isDone
        saveData(withReload: true);
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        guard let taskCell = cell as? TaskTableViewCell else{
            print("Failed to cast to TaskTableViewCell");
            fatalError();
        };
        taskCell.tableViewController = self;
        taskCell.cellIndexPath = indexPath;
        
        let task = tasks[indexPath.row];
        
        taskCell.SetCheckMarkedState(state: task.isDone)
        taskCell.ContentLabel.text = task.content;

        print(task.content + ": " + (task.isDone ? "true" : "false" ));
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContextItem = UIContextualAction(style: .destructive, title: "Delete"){(contexualAction, view, boolValue) in
            print("index path.row = \(indexPath.row)");
            print(self.tasks);
            self.tasks.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContextItem]);
        swipeActions.performsFirstActionWithFullSwipe = false;
        return swipeActions;
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let deleteContextItem = UIContextualAction(style: .normal, title: "✔️"){(contexualAction, view, boolValue) in
            self.tasks[indexPath.row].isDone = !self.tasks[indexPath.row].isDone;
            self.saveData(withReload: true);
           }
           let swipeActions = UISwipeActionsConfiguration(actions: [deleteContextItem]);
           swipeActions.performsFirstActionWithFullSwipe = true;
           return swipeActions;
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
