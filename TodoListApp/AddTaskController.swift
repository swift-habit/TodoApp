//
//  AddTaskController.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 5. 6..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit
import Parse

protocol AddTask {
    func addTask()
}

class AddTaskController: UIViewController {

    var delegate: AddTask?
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        let todo = PFObject(className:"todo")
        todo["title"] = taskTitle.text
        todo["description"] = taskDescription.text
        todo["completed"] = false
        todo.saveInBackground { ( success: Bool, error:Error?) in
            if ( success ){
                self.taskTitle.text = ""
                self.taskDescription.text = ""
                self.delegate?.addTask()
                self.navigationController?.popViewController(animated: true)
                print("success")
            } else {
                print("error")
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
