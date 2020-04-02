//
//  Task.swift
//  NList
//
//  Created by Shahan Nedadahandeh on 2020-04-01.
//  Copyright © 2020 Shahan Nedadahandeh. All rights reserved.
//

import Foundation

class Task : Codable{
    var content : String;
    static let TASK_STORAGE_KEY = "NLIST-TASK-STORAGE";
    
    init(content : String) {
        self.content = content;
    }
    
    public static func saveTasks(tasks : [Task] ){
        let taskData  = try! JSONEncoder().encode(tasks);
        UserDefaults.standard.set(taskData, forKey: TASK_STORAGE_KEY);
    }
    public static func getTasks() -> [Task]{
        guard let tasksData = UserDefaults.standard.data(forKey: TASK_STORAGE_KEY) else{
            print("DID NOT FIND DATA< RETURNING EMPTY");
          return [Task]()
        }
        let decoded  = try! JSONDecoder().decode([Task].self, from: tasksData);
        return decoded;
        
    }
}

//class TaskList : Codable{
//    var TaskLists = [[Task]];
//}
