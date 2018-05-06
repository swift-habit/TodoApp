//
//  AddTaskController.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 5. 6..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit
import Parse

protocol TaskAction{
    func reloadData()
}

class AddTaskController: UIViewController {

    var delegate: TaskAction?
    var todo: Todo?
    var pfTodo: PFObject?
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskCompleted: UISwitch!
    @IBOutlet weak var taskDeleteButton: UIButton!
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        if let pfTodo = pfTodo {
            pfTodo["title"] = taskTitle.text
            pfTodo["description"] = taskDescription.text
            pfTodo["completed"] = taskCompleted.isOn
            pfTodo.saveInBackground { ( success: Bool, error:Error?) in
                if ( success ){
                    self.taskTitle.text = ""
                    self.taskDescription.text = ""
                    self.delegate?.reloadData()
                    self.navigationController?.popViewController(animated: true)
                    print("success")
                } else {
                    print("error")
                }
            }
        }
    }
    
    
    @IBAction func deleteTaskAction(_ sender: Any) {
        pfTodo?.deleteInBackground {
            ( success : Bool, error:Error? ) in
            if ( success ) {
                self.delegate?.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pfTodo = PFObject(className:"todo")
        if let todo = self.todo {
            taskTitle.text = todo.title
            taskDescription.text = todo.description
            taskCompleted.setOn(todo.completed,animated: true)
            pfTodo!.objectId = todo.objectId
            taskDeleteButton.isHidden = false
        } else {
            taskDeleteButton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
