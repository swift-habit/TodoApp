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

class TaskFormController: UIViewController {

    var delegate: TaskAction?
    var todo: Todo?
    var pfTodo: PFObject?
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskCompleted: UISwitch!
    @IBOutlet weak var taskDeleteButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
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
        
        let alertController = UIAlertController(title: "할 일을 삭제하시겠습니까？",message: "삭제하게 되면 복구가 불가능합니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            self.pfTodo?.deleteInBackground {
                ( success : Bool, error:Error? ) in
                if ( success ) {
                    self.delegate?.reloadData()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        self.present(alertController,animated: true,completion: nil)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.layer.borderColor = UIColor.gray.cgColor
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 5
        
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
