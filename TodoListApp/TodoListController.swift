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
    
    private var todoList:[Todo] = []
    
    public var selectedTodo: Todo?


    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addTodo(_ sender: Any) {
        self.selectedTodo = nil
        self.performSegue(withIdentifier: "taskForm", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.layer.zPosition = 999
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
        activityIndicator.startAnimating()
        todo.findObjectsInBackground {
            (todos:[PFObject]?, error:Error?) -> Void in
            self.activityIndicator.stopAnimating()
            if let todos = todos {
                self.todoList.removeAll()
                for temp in todos {
                    self.todoList.append(
                        Todo(objectId: temp.objectId! ,
                             title: temp["title"] as! String,
                             description: temp["description"] as! String,
                             completed: temp["completed"] as! Int == 1 )
                    )
                }
                self.tableView.reloadData()
            } else {
                print("error")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "taskForm" {
            let vc = segue.destination as! AddTaskController
            vc.delegate = self
            vc.todo = selectedTodo
        }
        
    }

}

extension TodoListController: TaskAction, TaskComplete {
    func reloadData() {
        loadTodoList()
    }
    
    func taskComplete(idx index: Int) {
        let todo = todoList[index]
        let pfTodo = PFObject(className: "todo")
        pfTodo.objectId = todo.objectId
        pfTodo["title"]    = todo.title
        pfTodo["description"] = todo.description
        pfTodo["completed"]   = !todo.completed
        pfTodo.saveInBackground {
            ( success: Bool, error:Error?) in
            if error == nil {
                self.loadTodoList()
            } else {
                
            }
        }
    }
}

extension TodoListController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskTitleLabel.text = todoList[indexPath.row].title
        cell.delegate = self
        cell.index = indexPath.row
        if todoList[indexPath.row].completed {
            cell.checkButton.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            cell.checkButton.setBackgroundImage(#imageLiteral(resourceName: "notchecked"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTodo = todoList[indexPath.row]
        self.performSegue(withIdentifier: "taskForm", sender: self)
    }
    
}

