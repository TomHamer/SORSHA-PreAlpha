//
//  selectBuildingViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 2/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var customerRegistrationDetails = [String:String]()

class selectBuildingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var buildingArray = []
    var rowCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let query = PFQuery(className:"buildings")
        query.findObjectsInBackgroundWithBlock {
            (buildingDownloadedArray, error) -> Void in
            
            if error == nil {
                if let buildingDownloadedArray = buildingDownloadedArray {
              self.buildingArray = buildingDownloadedArray
              self.rowCount = buildingDownloadedArray.count
              print(buildingDownloadedArray)
              self.tableView.reloadData()
              
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buildingArray.count // your number of cell here
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        customerRegistrationDetails["buildingName"] = buildingArray[indexPath.row]["buildingName"] as? String
        print(customerRegistrationDetails["buildingName"])
        performSegueWithIdentifier("buildingSelectedSegue", sender: nil)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cellIdentifier = "buildingCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! buildingTableViewCell
        cell.buildingNameLabel.text = buildingArray[indexPath.row]["buildingName"] as? String
        
        return cell
        
        
    }


}
