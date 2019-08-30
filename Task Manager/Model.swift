//
//  Model.swift
//  Task Manager
//
//  Created by Виталий Субботин on 21.09.2018.
//  Copyright © 2018 Виталий Субботин. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit



//the list of tasks [["Name": String, "isComplited": Bool, "description": String]]
var tasks : [[String:Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "tasksDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let dataArray = UserDefaults.standard.array(forKey: "tasksDataKey") as? [[String:Any]]{
            return dataArray
        } else{
            return []
        }
    }
}

//add new task to task manager
func addTask(nameItem: String, isComplited : Bool = false) {
    tasks.append(["Name" : nameItem, "isComplited" : isComplited, "description" : "", "hasNotification" : false])
    setBadge()
}

//add destription to the task
func addDescription(at index: Int, description: String) {
    tasks[index]["description"] = description
}

//move some task to other position in the list of the tasks
func moveTasks(from: IndexPath , to: IndexPath) {
    let taskFrom = tasks[from.row]
    deleteTask(at: from.row)
    tasks.insert(taskFrom, at: to.row)
    
}

//delete the task from the index
func deleteTask(at index: Int) {
    
    let myIdentifier = tasks[index]["Name"] as! String + String(index)
    
    removeNotification(withIdentifiers: [myIdentifier])
    tasks.remove(at: index)
    setBadge()
}

//change the state "isComplited" of the task at the given index
func changeState(at index: Int) -> Bool {
    tasks[index]["isComplited"] = !(tasks[index]["isComplited"] as! Bool)
    setBadge()
    return tasks[index]["isComplited"] as! Bool
}


//NOTIFICATIONS

//IDENTIFIER: tasks[index]["Name"] as! String + String(index)

//send a request to recieve notifications
func requestForNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (agree, error) in
        
    }
}

//set a badge with number of incompleted tasks
func setBadge() {
    var count = 0
    for task in tasks {
        if ((task["isComplited"] as? Bool) == false) {
            count += 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = count
}



//add notification for task
func addNotification(withDate date: Date, index: Int) {
    
    let myIdentifier = tasks[index]["Name"] as! String + String(index)
  
    let content = UNMutableNotificationContent()
    content.title = tasks[index]["Name"] as! String
    content.body = tasks[index]["description"] as! String
    content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)

    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    
    let request = UNNotificationRequest(identifier: myIdentifier, content: content, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    
    center.add(request, withCompletionHandler: nil)
   
}


//remove notification with identifier
func removeNotification(withIdentifiers identifiers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifiers)
    
}






































