//
//  splashViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 27/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

import Parse

func isConnectedToNetwork()->Bool{
    
    var Status:Bool = false
    let url = NSURL(string: "http://google.com/")
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "HEAD"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: NSURLResponse?
    do {
    var data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response) as NSData?
    } catch { }
    if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == 200 {
            Status = true
        }
    }
    
    return Status
}


class splashViewController: UIViewController {
    
    
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBOutlet weak var webView: UIWebView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let filePath = NSBundle.mainBundle().pathForResource("ezgif.com-resize-2", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        
        webView.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL(fileURLWithPath: filePath!))
        webView.userInteractionEnabled = false;
        
        let seconds = 1.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
           self.webView.hidden = false
        })
        if isConnectedToNetwork() == true {
        print("tested network connection - network is active")
        var user = PFUser.currentUser()
        print("set user equal to ", user)
            if user != nil {
                print("there is a user logged in, but testing if they are a barista")
                // Do any additional setup after loading the view.
                
                    let isACustomer = PFUser.currentUser()!["isACustomer"] as? Bool
                print("there is a user logged in, but testing if they are a barista")

                    if isACustomer == true {
                        currentUser = (user!["firstName"] as! String) + " " + (user!["lastName"] as! String)
                        self.performSegueWithIdentifier("loginSuccessfulFromSplash", sender: nil)
                    } else {
                        self.performSegueWithIdentifier("loginUnsuccessful", sender: nil)
                }
                
                print("success")
            } else {
                print("performing segue to main screen")
                    self.performSegueWithIdentifier("loginUnsuccessful", sender: nil)
                
            }
        } else {
            alertUser("RUSH requires Internet", message: "Please check your connection")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
