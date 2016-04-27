//
//  selectCafeViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 8/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class selectCafeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var cafeArray = []
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        super.viewDidLoad()
        findCafes()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cafeArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        customerIsViewingOrders = false
        currentOrderDetails["cafe"] = cafeArray[indexPath.row]["cafeName"] as! String
        print(currentOrderDetails["cafe"])
        if cafeArray[indexPath.row]["currentlyOfferingDelivery"] as! Bool {
            performSegueWithIdentifier("cafeSelectedSegue", sender: nil)
        } else {
            performSegueWithIdentifier("cafeNotOfferingDelivery", sender: nil)
        }
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cellIdentifier = "cafeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! cafeTableViewCell
        if cafeArray[indexPath.row]["currentlyOfferingDelivery"] as! Bool {
        cell.cafeName.text = (cafeArray[indexPath.row]["cafeName"] as? String)
        } else {
           cell.cafeName.text = (cafeArray[indexPath.row]["cafeName"] as? String)! + " (delivery unavailable"
        }
        return cell
        
        
    }
    func findCafes() {
        print("the current cafe's building is ", PFUser.currentUser()!["buildingName"]!)
    let predicate = NSPredicate(format: "buildingName = '\(PFUser.currentUser()!["buildingName"]!)' AND isACafe = true")
    let query = PFUser.queryWithPredicate(predicate)
    query!.findObjectsInBackgroundWithBlock {
    (cafeDownloadedArray, error) -> Void in
        print("fetching relevant cafes...")
        if error == nil {
        if let cafeDownloadedArray = cafeDownloadedArray {
        self.cafeArray = cafeDownloadedArray
        print("Cafe's retrieved are:")
        print(cafeDownloadedArray)
        self.tableView.reloadData()
    
    }
        } else {
    // Log details of the failure
    print("No cafe's were retrieved, due to an error")
    print("Error: \(error!) \(error!.userInfo)")
    }
    }
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
