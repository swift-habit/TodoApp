//
//  TodoListController.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 4. 29..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit
import Parse
class TodoListController: UIViewController {
    
    var todoList:[Todo] = []


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        todoList.append(Todo(title:"test",description:"wefwefwe",completed:false))
        loadTodoList()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadTodoList() {
        let todo = PFQuery(className:"todo")
        
        todo.findObjectsInBackground {
            (todos:[PFObject]?, error:Error?) -> Void in
            if let todos = todos {
                self.todoList.removeAll()
                for temp in todos {
                    self.todoList.append(Todo(title: temp["title"] as! String, description: temp["description"] as! String, completed: false))
                }
                self.tableView.reloadData()
            } else {
                print("error")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }

}

extension TodoListController: AddTask {
    func addTask() {
        loadTodoList()
    }
}

extension TodoListController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskTitleLabel.text = todoList[indexPath.row].title
        
        if todoList[indexPath.row].completed {
            cell.checkButton.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            cell.checkButton.setBackgroundImage(#imageLiteral(resourceName: "notchecked"), for: .normal)
        }
        
        return cell
    }
    
    
}
