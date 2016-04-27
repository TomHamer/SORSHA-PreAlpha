//
//  currentOrdersViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 27/03/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var currentCustomerOrders = [PFObject]()
var customerIsViewingOrders = false


class customerOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBAction func returnFromOrdering(sender: AnyObject) {
        if customerIsViewingOrders == false {
            alertUserAndCancelOrders()
        } else {
            customerIsViewingOrders = false
            self.performSegueWithIdentifier("cancelAllOrdersSegue", sender: nil)
        }
    }
  
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var orderMoreButton: UIButton!
    
    //add the IBAction swipe up to refresh
    
    
   
    
    @IBOutlet weak var tableView: UITableView!
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if customerIsViewingOrders == true {
            confirmButton.hidden = true
            orderMoreButton.hidden = true
           updateOrders()
        
        } else {
            tableView.reloadData()
        }
        //getOrdersOnlineForTable()
        
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
       
        return currentCustomerOrders.count //change later (plus the ones that are already on the server
        
        
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
                return indexPath
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        //let dateRecieved = self.orderArray[indexPath.row]["createdAt"] as? NSString
        //let timeStamp = NSDateFormatter.localizedStringFromDate((dateRecieved)!, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customerOrderCell", forIndexPath: indexPath) as! customerOrderTableViewCell
        
        cell.orderLabel?.text = currentCustomerOrders[indexPath.row]["order"] as? String
        cell.sizeLabel?.text = currentCustomerOrders[indexPath.row]["size"] as? String
        cell.deliveryMethod?.text = currentCustomerOrders[indexPath.row]["deliveryMethod"] as? String
        cell.blendTypeTag?.text = currentCustomerOrders[indexPath.row]["blend"] as? String
        cell.milkTypeTag?.text = currentCustomerOrders[indexPath.row]["milk"] as? String
        cell.strengthTypeTag?.text = currentCustomerOrders[indexPath.row]["strength"] as? String// + " strength"
        //cell.coffeeImage?.image = getImageForOrder(currentCustomerOrders[indexPath.row]["order"] as! String)
        cell.addToFavouritesButton.tag = indexPath.row
        cell.addToFavouritesButton.addTarget(self, action: Selector("addOrderToFavourites:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
        
        
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            currentCustomerOrders.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    func alertUserAndCancelOrders() {
        let alert = UIAlertController(title: "Are you sure?", message: "Your current progress will be deleted", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            ///////////////////////////////////////
            //here, we delete the orders and perform a segue
            ///////////////////////////////////////
        
            currentCustomerOrders = []
            customerIsViewingOrders = false
            self.performSegueWithIdentifier("cancelAllOrdersSegue", sender: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func getImageForOrder(order: String) -> UIImage {
        print("finding image...")
        var image = UIImage(named: "capaccino - 320-01 (2).png")
        if order == "cappucino" {
            image = UIImage(named: "capaccino - 320-01 (2).png")
            
        }
        return image!
    }
    
    @IBAction func addOrderToFavourites(sender: UIButton) {
        
        //-----------------------------------------------------------
        // MARK: add an order to favourites
        //-----------------------------------------------------------
        
        
        //---------------------------------
        // 1. Recreate the order from the tag
        
        //the button has been encoded with a tag that is equal to 1+(the section number) concatinated with 1+(the row number). From here we need to recreate the object that it is referencing
        
        let orderToAdd  = currentCustomerOrders[sender.tag]
        //---------------------------------
        // 2. retreive orders from favourites
        let newFavourite = PFObject(className: "favourites")
        newFavourite["order"] = orderToAdd["order"]
        newFavourite["cafe"] = orderToAdd["cafe"]
        newFavourite["size"] = orderToAdd["size"]
        newFavourite.pinInBackground()
        print("added \(newFavourite) to the favourites list")
    }
    //--------------------------------------------------
    // MARK: update functions
    //--------------------------------------------------
    
    func updateOrders() {
    
        //--------------------------------------------------
        // MARK: update functions
        //--------------------------------------------------
        //1. Check if any orders are complete
        
        func anOrderIsComplete(orderList: [PFObject]) -> Bool {
            var anOrderHasCompleted = false
            for order in orderList {
                if order["delivered"] != nil {
                    anOrderHasCompleted = order["delivered"] as! Bool || anOrderHasCompleted
                } else {
                    anOrderHasCompleted = order["readyForCustomer"] as! Bool || anOrderHasCompleted
                }
            }
            return anOrderHasCompleted
        }
        
        //Perform a parse query
        
        func downloadDeliveryOrdersOnline() -> [PFObject] {
            var downloadedOrders = []
            print("the current User is ", PFUser.currentUser()!.username!)
            print("attempting to get orders online")
            let predicate = NSPredicate(format: "user = '\(PFUser.currentUser()!.username!)'")
            let query = PFQuery(className:"prepaidOrders", predicate: predicate)
            //get the orders
            query.findObjectsInBackgroundWithBlock({ (orderArray, error) -> Void in
                if error == nil {
                    if orderArray != nil {
                        
                        
                        currentCustomerOrders = orderArray as! [PFObject]
                        print("the current orders are " + "\(currentCustomerOrders)")
                        self.tableView.reloadData()
                    } else {
                        print("There were no orders to be found on the server for this user")
                    }
                    
                } else {
                    print("error recieving orders")
                    print("there could be an internet issue")
                }
            })
            return downloadedOrders as! [PFObject]
        }
        func downloadPrepaidOrdersOnline() -> [PFObject] {
            var downloadedOrders = []
            print("the current User is ", PFUser.currentUser()!.username!)
            print("attempting to get orders online")
            let predicate = NSPredicate(format: "user = '\(PFUser.currentUser()!.username!)'")
            let query = PFQuery(className:"deliveryOrders", predicate: predicate)
            //get the orders
            query.findObjectsInBackgroundWithBlock({ (orderArray, error) -> Void in
                if error == nil {
                    if orderArray != nil {
                        
                        currentCustomerOrders = orderArray as! [PFObject]
                        print("the current orders are " + "\(currentCustomerOrders)")
                        self.tableView.reloadData()
                    } else {
                        print("There were no orders to be found on the server for this user")
                    }
                    
                } else {
                    print("error recieving orders")
                    print("there could be an internet issue")
                }
            })
            return downloadedOrders as! [PFObject]
        }
        
        
        //set the current order
        currentCustomerOrders = downloadDeliveryOrdersOnline() + downloadPrepaidOrdersOnline()
        print("the main customer orders variable was set to", currentCustomerOrders)
        
        
    }
    

    
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    

}
