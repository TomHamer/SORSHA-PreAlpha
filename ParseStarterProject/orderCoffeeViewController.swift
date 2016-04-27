//
//  orderCoffeeViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 27/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class orderCoffeeViewController: UIViewController {
    
    @IBAction func orderCappucino(sender: AnyObject) {
        currentOrderDetails["order"] = "Cappucino"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    @IBAction func orderLatte(sender: AnyObject) {
        currentOrderDetails["order"] = "Latte"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    @IBAction func orderExpresso(sender: AnyObject) {
        currentOrderDetails["order"] = "Expresso"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    
    @IBAction func orderFlatWhite(sender: AnyObject) {
        currentOrderDetails["order"] = "Flat White"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    @IBAction func orderLongBlack(sender: AnyObject) {
        currentOrderDetails["order"] = "Long Black"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    @IBAction func orderShortBlack(sender: AnyObject) {
        currentOrderDetails["order"] = "Short Black"
    }
    
    @IBAction func orderMacchiato(sender: AnyObject) {
        currentOrderDetails["order"] = "Macchiato"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    @IBAction func orderChaiLatte(sender: AnyObject) {
        currentOrderDetails["order"] = "Chai Latte"
        performSegueWithIdentifier("selectedOrderSegue", sender: nil)
    }
    
    
    

    
    
    
    
    var sizeSelected = false
    var typeSelected = false
    @IBAction func cancelSingleOrder(sender: AnyObject) {
        
        typeSelected = false
        sizeSelected = false
        if currentCustomerOrders.count == 0 {
            performSegueWithIdentifier("backToDeliveryScreenSegue", sender: nil)
            
        } else {
            
            performSegueWithIdentifier("cancelSingleOrderToCustomerOrdersViewController", sender: nil)
            
        }
        
     
    }
    @IBAction func orderCappucinoButtonPress(sender: AnyObject) {
        orderCappucino()
    }
  
    @IBAction func orderLatteButtonPress(sender: AnyObject) {
        orderLatte()
    }

    
    
    func getTime() -> String {
        
        let date = NSDate()
        let strDate = NSString(string: String(date))
        let time = strDate.substringWithRange(NSRange(location: 11, length: 8))
        return time
    }
    
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func orderLatte() {
      currentOrderDetails["order"] = "latte"
        typeSelected = true
        sizeSelected = true
    }
    func orderCappucino() {
        currentOrderDetails["order"] = "cappucino"
        typeSelected = true
        sizeSelected = true
    }

    

    @IBAction func confirm(sender: AnyObject) {
        
        if typeSelected == true && sizeSelected == true {
       
        let order = PFObject(className:"orders")
        order["size"] = currentOrderDetails["size"]
        order["order"] = currentOrderDetails["order"]
        order["deliveryMethod"] = currentOrderDetails["deliveryMethod"]
        order["name"] = currentUser
        order["user"] = PFUser.currentUser()!.username!
        order["cafe"] = currentOrderDetails["cafe"]
        currentCustomerOrders.append(order)
        print(currentCustomerOrders.count)
    
            performSegueWithIdentifier("confirmSingleOrderSegue", sender: nil)
                
                   } else {
            alertUser("Woops!", message: "please ensure you have filled all the fields")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
