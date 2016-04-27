//
//  selectDeliveryMethodViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 7/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class selectDeliveryMethodViewController: UIViewController {
 
    @IBAction func chosePreorder(sender: AnyObject) {
        if userIsOrderingAFavourite {
            performSegueWithIdentifier("userIsOrderingAFavouiteDeliveryMethodSelectedSegue", sender: nil)
        } else {
        currentOrderDetails["deliveryMethod"] = "preorder"
        performSegueWithIdentifier("deliveryMethodSelectedSegue", sender: nil)
        }
    }
    @IBAction func choseDelivery(sender: AnyObject) {
        
        currentOrderDetails["deliveryMethod"] = "delivery"
        performSegueWithIdentifier("deliveryMethodSelectedSegue", sender: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

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
