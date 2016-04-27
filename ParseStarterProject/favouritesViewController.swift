//
//  favouritesViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 8/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import Bolts

var userIsOrderingAFavourite = false


class favouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var favouritesArray = [PFObject]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavouritesFromMemory()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getFavouritesFromMemory() {

        let query = PFQuery(className: "favourites")
        query.fromLocalDatastore()
        query.findObjectsInBackground().continueWithBlock {
            (task: BFTask!) -> AnyObject in
            if task.error == nil {
                if task.result == nil {
                    print("Retrieved no favourites")
                    return task
                } else {
                    self.favouritesArray = task.result as! [PFObject]
                    print("the current saved favourites are", self.favouritesArray)
                    self.tableView.reloadData()
                    return task
                }
                
            } else {
                print("there was an error retrieving favourites")
                return task
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        
        return favouritesArray.count
        
        
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        currentCustomerOrders = [favouritesArray[indexPath.row]]
        userIsOrderingAFavourite = true
        performSegueWithIdentifier("chosenFavouriteSegue", sender: nil)
        
        // MARK: CONFIGURE ORDER HERE
        //very important to make sure everything is added
        
        return indexPath
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("favouriteCell", forIndexPath: indexPath) as! favouriteTableViewCell
        cell.orderLabel?.text = favouritesArray[indexPath.row]["order"] as? String
        cell.sizeLabel?.text = favouritesArray[indexPath.row]["size"] as? String
        cell.cafeLabel?.text = favouritesArray[indexPath.row]["cafe"] as? String
        
        return cell
        
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            favouritesArray[indexPath.row].unpin()
            favouritesArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
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
