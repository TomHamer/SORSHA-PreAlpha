//
//  createProfileViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class createProfileViewController: UIViewController {
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var levelNo: UITextField!
    
    @IBOutlet weak var officeNo: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
    @IBOutlet weak var firstNameBox: UITextField!
    @IBAction func next(sender: AnyObject) {
       
       
        if firstNameBox.text != "" && lastNameBox.text != "" && officeNo.text != "" && levelNo.text != "" && companyName.text  != "" {
            
            var user = PFUser()
            user.username = customerRegistrationDetails["email"]!.lowercaseString
            user.password = customerRegistrationDetails["password"]
            user["mobile"] = customerRegistrationDetails["mobileNo"]
            user["firstName"] = firstNameBox.text
            user["lastName"] = lastNameBox.text
            user["officeNo"] = officeNo.text
            user["levelNo"] = levelNo.text
            user["companyName"] = companyName.text
            user["buildingName"] = customerRegistrationDetails["buildingName"]
            user["isACustomer"] = true
            user["isABarista"] = false
            user["isAWaiter"] = false
            
            
            

            
            
            
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    print(error)
                } else {
                    currentUser = self.firstNameBox.text! + " " + self.lastNameBox.text!
                    PFPush.subscribeToChannelInBackground("\(PFUser.currentUser()!.username!)")
        
                    
                    
                    
                    self.performSegueWithIdentifier("userDidCreateAccount", sender: nil)
                    print("success")
                    
                    
                }
        }
        } else {
            alertUser("Woops", message: "Please fill out all the feilds in the form")
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
