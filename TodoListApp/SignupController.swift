//
//  SignupController.swift
//  TodoListApp
//
//  Created by LimHoSung on 2018. 5. 6..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import UIKit
import Parse
import FontAwesome_swift

class SignupController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        cancelButton.setTitle(String.fontAwesomeIcon(name: .times), for: .normal)
        // Do any additional setup after loading the view.
    }
    @IBAction func backLogin(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let user = PFUser()
        user.username = idTextField.text
        user.password = pwTextField.text
        // other fields can be set just like with PFObject
        activityIndicator.startAnimating()
        user.signUpInBackground(block: {
            (success, error) -> Void in
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.alert(message:"오류가 발생하였습니다", title:"알림")
                
                // Show the errorString somewhere and let the user try again.
            } else {
                
                
                self.alert(message:"가입이 완료되었습니다", title: "알림") { action in
                    self.dismiss(animated:true)
                }
    
            }
        });
    
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
