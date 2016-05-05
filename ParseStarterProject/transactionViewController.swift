//
//  transactionViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 2/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

//this file is most important
import UIKit
import Parse

var successfullyUploadedOrders = true

class transactionViewController: UIViewController {
    @IBOutlet weak var transactionDisplay: UITextView!
    
    @IBOutlet weak var transactionSum: UILabel!
 
    
    @IBAction func confirmPayment(sender: AnyObject) {
          placeOrder()
    }
    
    
   
    @IBOutlet weak var paymentString: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentString.text = "(" + PFUser.currentUser()!.username! + ")"
        var deliveryMethod = ""
        var transactionString = ""
        for order in currentCustomerOrders {
            print("----------------------------- new order -----------------------------")
            print(order)
            let cafeName = order["cafeName"] as! String
            let size = order["size"] as! String
            let orderType = order["order"] as! String
            deliveryMethod = order["deliveryMethod"] as! String
            transactionString = transactionString + "\n" + (cafeName + " - " + size + " " + orderType + ". tags: " + (order["blend"] as! String) + " " + "blend" + " " + (order["strength"] as! String))  + " Strength" + ", $3"
        }
        transactionDisplay.text = transactionString + "\n" + deliveryMethod + " $2"
        

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
    func placeOrder() {
        
        //--------------------------------------------------
        // MARK: pay for coffees
        //--------------------------------------------------
        
        
        //payments here managed by the stripe api or paypal
        
        
        
    
        //--------------------------------------------------
        // MARK: update the server
        //--------------------------------------------------
    //if payment was successful
        
    PFUser.currentUser()!["rewardPoints"] = PFUser.currentUser()!["rewardPoints"] as! Int + 1
    
    if currentOrderDetails["deliveryMethod"] == "delivery" {
    print(currentCustomerOrders)
    
    for customerOrder in currentCustomerOrders {
    let order = PFObject(className:"deliveryOrders")
    
    print(customerOrder)
    order["size"] = customerOrder["size"]
    order["order"] = customerOrder["order"]
    order["user"] = PFUser.currentUser()!.username!
    order["cafeName"] = customerOrder["cafeName"]
    order["blend"] = customerOrder["blend"]
    order["milk"] = customerOrder["milk"]
    order["strength"] = customerOrder["strength"]
    order["deliveryMethod"] = "delivery"
    //adding any other features
        let push = PFPush()
        let cafe = order["cafeName"] as! String
        push.setChannel(cafe)
        push.setMessage("New Order - \(order["size"]), \(order["order"])")
        push.sendPushInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                print("push was successful")
            } else {
                print(error)
            }
        })
    
    order.saveInBackgroundWithBlock {
    (success: Bool, error: NSError?) -> Void in
    if (success) {
    successfullyUploadedOrders = successfullyUploadedOrders && success
    //display alert
    
    
    } else {
    print(error?.description)
    }
    
    
    
    }
    }
    
    } else {
        for customerOrder in currentCustomerOrders {
            let order = PFObject(className:"prepaidOrders")
    
            order["size"] = customerOrder["size"]
            order["order"] = customerOrder["order"]
            order["name"] = customerOrder["name"]
            order["user"] = PFUser.currentUser()!.username!
            order["inCurrentSession"] = false
            order["deliveryMethod"] = "preorder"
            order["cafeName"] = customerOrder["cafeName"]
            order["blend"] = customerOrder["blend"]
            order["milk"] = customerOrder["milk"]
            order["strength"] = customerOrder["strength"]
            
            order.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                if (success) {
                    successfullyUploadedOrders = successfullyUploadedOrders && success
    //display alert
    
                
    } else {
    print(error?.description)
    }
            }
        }
        }
    
    if successfullyUploadedOrders == true {
    //remove  any global variables
    userIsOrderingAFavourite = false
    
    var alert = UIAlertController(title: "Success", message: "Your coffee will be delivered within 30 minutes", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        
        self.performSegueWithIdentifier("coffeeOrderSuccess", sender: nil)
    alert.dismissViewControllerAnimated(true, completion: { () -> Void in 
        
    })
    
    }))
    self.presentViewController(alert, animated: true, completion: nil)
    
    
        }
        
        //--------------------------------------------------
        // MARK: send a push through to the barista
        //--------------------------------------------------
        
        
    
    }
    
}
