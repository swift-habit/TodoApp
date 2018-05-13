//
//  LoginController.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 5. 6..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit
import Parse
class LoginController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if let id = idTextField.text,
            let pw = pwTextField.text {
            self.activityIndicator.startAnimating()
            PFUser.logInWithUsername(inBackground: id, password: pw) {
                (user, error) in
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.alert(message:"오류가 발생하였습니다", title:"알림")
                } else {
                    self.alert(message:"환영합니다", title:"알림") {
                        action in
                        self.performSegue(withIdentifier: "mainSegue", sender: self)
                    }
                    
                }
            }
        }
        
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


