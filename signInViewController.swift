//
//  signInViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 22/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class signInViewController: UIViewController {
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
  /*  func pauseApp() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
        
        //To use this function, these two lines need to go below it
        //activityIndicator.center = self.view.center
        //view.addSubview(activityIndicator)
    }
    func restartApp() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
*/
    @IBOutlet weak var navigationBar: UINavigationBar!
    func signInUser() {
    if password.text != "" && email.text != "" {
       // activityIndicator.center = self.view.center
       // view.addSubview(activityIndicator)
        //pauseApp()
        //activityIndicator.bringSubviewToFront(view)
    PFUser.logInWithUsernameInBackground(self.email.text!, password: self.password.text!) {
    (user: PFUser?, error: NSError?) -> Void in
       // self.restartApp()
        if error == nil {
        if user!["isACustomer"] as? Bool == true {
    if user != nil {
        currentUser = (PFUser.currentUser()!["firstName"] as! String) + " " + (PFUser.currentUser()!["lastName"] as! String)
        self.performSegueWithIdentifier("signInSuccess", sender: nil)
        
    } else {
        self.alertUser("Error", message: (error?.description)!)
        }
        } else {
         self.alertUser("Error", message: "Please log in with a Sorsha customer account")
        }
        } else {
            self.alertUser("Error", message: (error?.description)!)
        }
        }
        
        }
    }
    @IBAction func done(sender: AnyObject) {
      signInUser()
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidAppear(animated: Bool) {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        emailLabel.center.x  = screenSize.width/2
        passwordLabel.center.x  = screenSize.width/2
        emailLabel.hidden = false
        passwordLabel.hidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // set up email and password labels through assigning them a position
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
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
