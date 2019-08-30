//
//  TableViewController.swift
//  Task Manager
//
//  Created by Виталий Субботин on 21.09.2018.
//  Copyright © 2018 Виталий Субботин. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func pushEditButton(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
    }
    

    @IBAction func pushAddPlan(_ sender: Any) {
        
        
        let alertController = UIAlertController.init(title: "Create new task", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New task"
        }
        
        let alertAction1 = UIAlertAction.init(title: "Cancel", style: .cancel) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction.init(title: "Create", style: .default) { (alert) in
            if let newTask = alertController.textFields![0].text{
                if newTask != ""{
                    addTask(nameItem: newTask)
                    self.tableView.reloadData()
                }
            }
        }
        
        
        alertController.addAction(alertAction2)
        alertController.addAction(alertAction1)
        
        present(alertController, animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        //cell.backgroundColor = newColor
        
        let currentPlan = tasks[indexPath.row]
        cell.textLabel?.text = currentPlan["Name"] as? String
        
        if (currentPlan["isComplited"] as? Bool) == true {
           
            //cell.accessoryType = .checkmark
            //cell.imageView?.image = doneIcon.image
            cell.imageView?.image = UIImage(named: "doneIcon.png")
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        }
        else {
            //cell.accessoryType = .none
            //cell.imageView?.image = notDoneIcon.image
            cell.imageView?.image = UIImage(named: "notDoneIcon.png")
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            //tableView.cellForRow(at: indexPath)?.imageView?.image = doneIcon.image
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "doneIcon.png")
            
            let myIdentifier = tasks[indexPath.row]["Name"] as! String + String(indexPath.row)
            removeNotification(withIdentifiers: [myIdentifier])
            
            //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.blue
            tableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.italicSystemFont(ofSize: 17)
            
        }
        else {
            //tableView.cellForRow(at: indexPath)?.accessoryType = .none
            //tableView.cellForRow(at: indexPath)?.imageView?.image = notDoneIcon.image
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "notDoneIcon.png")
            
            tableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            
        }
        //tableView.reloadData()
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveTasks(from: fromIndexPath, to: to)
        
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nc = segue.destination as! UINavigationController
        if let cell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                if let vc = nc.topViewController as? DetailViewController {
                    //vc.task = tasks[indexPath.row]
                    vc.index = indexPath.row
                }
                else{
                    print("error of getting view controller")
                }
            }
        }
        else {
            print("error of getting cell")
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

