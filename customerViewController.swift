//
//  customerViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Bolts
import Parse

// first, we will define a state, which will be updated from the server at viewDidAppear()
// if this state is true, it will show the details of the coffee that has been ordered, otherwise the app will simply offer the user the option to order coffee.x
var coffeeOrdered = false

var currentOrderDetails = [String:String]()


class customerViewController: UIViewController {
        // this variable will simply deal with the menu moving in and out
    @IBAction func viewCurrentOrders(sender: AnyObject) {
        customerIsViewingOrders = true
        performSegueWithIdentifier("viewCurrentOrdersSegue", sender: nil)
        
    }
    var menuOut = false
    @IBOutlet weak var rewardPointsDisplay: UILabel!
    
    // defining some IBOutlets for the menu, such that it can move in and out

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuBackground: UIImageView!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var promotionsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBAction func bringUpMenu(sender: AnyObject) {
        bringUpMenu()
    }
    
    //depending on whether the user chooses preorder or delivery as
    
    @IBAction func chosePreorder(sender: AnyObject) {
        
        currentOrderDetails["deliveryMethod"] = "preorder"
        performSegueWithIdentifier("deliveryMethodSelectedSegue", sender: nil)
        
    }
    @IBAction func choseDelivery(sender: AnyObject) {
        
        currentOrderDetails["deliveryMethod"] = "delivery"
        performSegueWithIdentifier("deliveryMethodSelectedSegue", sender: nil)
        
    }
    
    
    
    
    
    
    
    
    func getTime() -> String {
        
        let date = NSDate()
        let strDate = NSString(string: String(date))
        let time = strDate.substringWithRange(NSRange(location: 11, length: 8))
        return time
    }
    
    
    
    
    @IBOutlet weak var viewOrdersButton: UIButton!
    
    
    func bringUpMenu() {
        if menuOut==false {
    menuOut = true
    // all this does is pull the menu out by translating all the components by 294 in the x direction
    UIView.animateWithDuration(1, animations: { () -> Void in
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x + 294, self.nameLabel.frame.origin.y, self.nameLabel.frame.width, self.nameLabel.frame.height)
    self.menuBackground.frame = CGRectMake(0, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
    self.promotionsButton.frame = CGRectMake(self.promotionsButton.frame.origin.x + 294, self.promotionsButton.frame.origin.y, self.promotionsButton.frame.width, self.promotionsButton.frame.height)
    self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x + 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
    self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x + 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
    self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x + 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
    })

        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //set up background
        
        
    }
    
    @IBOutlet weak var rewardExplainationDisplay: UIButton!
    override func viewDidLoad() {
        PFUser.currentUser()?.fetch()
        
            
            let currentPoints = PFUser.currentUser()!["rewardPoints"] as! Int
        rewardPointsDisplay.text = String(currentPoints)
        rewardExplainationDisplay.setTitle(String(10-currentPoints) + " More Coffees Until Reward", forState: .Normal)
        
        
        //freeze view while it loads up
        
        //establish from updateOrders() as to whether the user should be able to click on the orders button
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        viewOrdersButton.layer.cornerRadius = 100
        
        
        
        
        
        
        
        
        
        
        if favouritesButtonShouldBeShown() {
            showFavouritesButton()
        } else {
            if isUsersFirstTimeOnSorsha() {
            showInitScreen()
            
            }
        }
        
        super.viewDidLoad()
        nameLabel.text = currentUser
        
        //we need to reset the variable currentcustomerorders
        currentCustomerOrders = []
        
    // first, lets ensure that the interface can register a tap, as it is required to dismiss the menu
       
        let tap = UITapGestureRecognizer(target: self, action: Selector("dismissMenu:"))
        view.addGestureRecognizer(tap)
        
        let formattedUsername =
        (PFUser.currentUser()!.username!.stringByReplacingOccurrencesOfString("@", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)).stringByReplacingOccurrencesOfString(".", withString: "nrjviongrv", options: NSStringCompareOptions.LiteralSearch, range: nil) //entered something long that know one would have
        
        print(formattedUsername)
        PFPush.subscribeToChannelInBackground("\(formattedUsername)") { (succeeded, error) in
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.", error)
            }
        }
        PFInstallation.currentInstallation().channels = ["\(formattedUsername)"]
        PFInstallation.currentInstallation().saveInBackground()
                
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
    

    
        func dismissMenu(recognizer: UITapGestureRecognizer){
        if menuOut {
        menuOut = false
        
       
        if menuBackground.frame.origin.x == 0 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x - 294, self.nameLabel.frame.origin.y, self.nameLabel.frame.width, self.nameLabel.frame.height)
                self.menuBackground.frame = CGRectMake(self.menuBackground.frame.origin.x - 294, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
                self.promotionsButton.frame = CGRectMake(self.promotionsButton.frame.origin.x - 294, self.promotionsButton.frame.origin.y, self.promotionsButton.frame.width, self.promotionsButton.frame.height)
                self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x - 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
                self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x - 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
                self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x - 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
            })
        }
        }
    }


    
    //animate marker


    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    //-------------------------------
    // Mark: set state of opening screen
    //-------------------------------
    func showFavouitesButton() {
        
    }
    func showInitScreen() {
        
    }
    
    
    
    
    
    
    //-------------------------------
    // Mark: Coding memory
    //-------------------------------
    // Basic principles: 1. Memory is deleted on logout.
    //                   2. Favourites button only shows if the favourites data store != nil
    //                   3. data is stored in an array
    
    func favouritesButtonShouldBeShown() -> Bool {
        var favouritesShouldBeShown = false
        let query = PFQuery(className: "favourites")
        query.fromLocalDatastore()
        query.findObjectsInBackground().continueWithBlock {
            (task: BFTask!) -> AnyObject in
            if task.error == nil {
                if task.result == nil {
                    print("Retrieved \(task.result.count)")
                    favouritesShouldBeShown = false
                    return task
                } else {
                    print("currently showing favourites")
                    favouritesShouldBeShown = true
                    return task
                }
                
            } else {
                favouritesShouldBeShown = false
                return task
            }
            
        }
        return favouritesShouldBeShown
    }
    
    func isUsersFirstTimeOnSorsha() -> Bool {
      return true
    }
    func showFavouritesButton() {
        //something like favouritesbutton.hidden = false
    }
    
    
    
    //--------------------------------------------------
    // MARK: update orders
    //--------------------------------------------------
    
    func updateOrders() {
        
        
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
            print("the current User is ", PFUser.currentUser()!.username)
            print("attempting to get orders online")
            let predicate = NSPredicate(format: "user = '\(PFUser.currentUser()!.username!)'")
            let query = PFQuery(className:"deliveryOrders", predicate: predicate)
            //get the orders
            query.findObjectsInBackgroundWithBlock({ (orderArray, error) -> Void in
                if error == nil {
                    if orderArray != nil {
                        
                        print("the current orders are " + "\(currentCustomerOrders)")
                        downloadedOrders = orderArray!
                        
                        if anOrderIsComplete(downloadedOrders as! [PFObject]) {
                            self.changeMainViewControllerStateToPostOrder()
                        }
                        
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
            print("the current User is ", PFUser.currentUser()!.username)
            print("attempting to get orders online")
            let predicate = NSPredicate(format: "user = '\(PFUser.currentUser()!.username!)'")
            let query = PFQuery(className:"deliveryOrders", predicate: predicate)
            //get the orders
            query.findObjectsInBackgroundWithBlock({ (orderArray, error) -> Void in
                if error == nil {
                    if orderArray != nil {
                        print("the current orders are " + "\(currentCustomerOrders)")
                        downloadedOrders = orderArray!
                        if anOrderIsComplete(downloadedOrders as! [PFObject]) {
                        self.changeMainViewControllerStateToPostOrder()
                        }
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
    
    
    
    func changeMainViewControllerStateToPostOrder() {
       // configure screen to say stuff
    }
    
    
    
    
  
    
    
    
    
}
