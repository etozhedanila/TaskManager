//
//  ViewController.swift
//  Task Manager
//
//  Created by Виталий Субботин on 23.09.2018.
//  Copyright © 2018 Виталий Субботин. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var index: Int = 0
    var date: Date = Date()
    
    @IBAction func backSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    
    @IBOutlet weak var addNotificationButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var textView: UITextView!
   
    @IBAction func pushSave(_ sender: Any) {
        
        addDescription(at: index, description: textView.text)
        
        
        let alertController = UIAlertController.init(title: "Saved", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func pushAddNotification() {
        //datePicker.alpha = 1
        
        addNotificationButton.alpha = 0
        
        if tasks[index]["isComplited"] as? Bool == false {
        
        
            let alertController = UIAlertController.init(title: "Do you want to add new notification?", message: nil, preferredStyle: .actionSheet)
        
            let alertAction1 = UIAlertAction.init(title: "Yes", style: .default) {(alert) in
                addNotification(withDate: self.datePicker.date, index: self.index)
            
                let alertController2 = UIAlertController.init(title: "Notification saved", message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertController2.addAction(alertAction)
                self.present(alertController2, animated: true, completion: nil)
            
            }
            let alertAction2 = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            present(alertController, animated: true, completion: nil)
        
        }
        else {
            let alertController3 = UIAlertController.init(title: "Task is complited, you can add a notification for incomplited tasks", message: nil, preferredStyle: .alert)
            let alertAction3 = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertController3.addAction(alertAction3)
            self.present(alertController3, animated: true, completion: nil)
        }
        
        
        addNotificationButton.alpha = 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let text = tasks[index]["Name"] as? String {
            self.navigationItem.title = text
        }
        
    
        if let text = tasks[index]["description"] as? String {
            if (text == ""){
                
                textView.text = "No description"
                
            }
            else{
               
                textView.text = text
            }
        }
        
        datePicker.minimumDate = Date()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
