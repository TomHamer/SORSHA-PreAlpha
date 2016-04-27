//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse


var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
var currentUser = ""

class titleViewController: UIViewController {


    @IBOutlet weak var backgroundDisplay: XAnimatedImageView!
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var signIn: UIButton!

    
    
    
    func fadeOut() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.register.alpha = 0
            self.signIn.alpha = 0
        })
    }
    
    
    
    
    @IBAction func registerAction(sender: AnyObject) {
        
        fadeOut()
        
        
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.performSegueWithIdentifier("registerSegue", sender: nil)
            
        })
        
    }
    
    @IBAction func signInAction(sender: AnyObject) {
        
        fadeOut()
        
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.performSegueWithIdentifier("signInSegue", sender: nil)
            
        })
        
    }
    override func viewWillDisappear(animated: Bool) {
        
        //reverse animations
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print("loading title view")
        

        self.register.alpha = 0
        self.signIn.alpha = 0

        print("setup background")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //set up background
        
   
          
        

        print("setup animation")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("now running view did appear")
        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            
                                self.register.alpha = 0.85
                                self.signIn.alpha = 0.85
               
        })
              
        

    
    
    
}

}