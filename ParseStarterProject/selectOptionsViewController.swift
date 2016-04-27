//
//  selectOptionsViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 12/04/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class selectOptionsViewController: UIViewController {
    var sizeSelected = false
    var strengthSelected = false
    var milkSelected = false
    var blendSelected = false
 
    @IBAction func confirm(sender: AnyObject) {
        if sizeSelected && strengthSelected && milkSelected && blendSelected {
            if currentOrderDetails["deliveryMethod"] == "delivery" {
            let order = PFObject(className: "deliveryOrders")
                
            //need function that converts dicts to PFObjects
            
                
            print("the current order details are")
            print(currentOrderDetails)
                
                
            order["order"] = currentOrderDetails["order"]
            order["deliveryMethod"] = currentOrderDetails["deliveryMethod"]
            order["milk"] = currentOrderDetails["milk"]
            order["strength"] = currentOrderDetails["strength"]
            order["blend"] = currentOrderDetails["blend"]
            order["size"] = currentOrderDetails["size"]
            order["cafeName"] = currentOrderDetails["cafe"]
                currentCustomerOrders.append(order)
            } else {
              let order = PFObject(className: "prepaidOrders")
                order["order"] = currentOrderDetails["order"]
                order["deliveryMethod"] = currentOrderDetails["deliveryMethod"]
                order["milk"] = currentOrderDetails["milk"]
                order["strength"] = currentOrderDetails["strength"]
                order["blend"] = currentOrderDetails["blend"]
                order["size"] = currentOrderDetails["size"]
                order["cafeName"] = currentOrderDetails["cafe"]
            currentCustomerOrders.append(order)
            }
            
            performSegueWithIdentifier("optionsSelectedSegue", sender: nil)
        }
    }
    
    //initialize with some sort of blur view that stops users selecting options that are not applicable to certain coffees

    @IBOutlet weak var selectMediumIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectRegularStrengthIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectStrongStrengthIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectWeakStrengthIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectRegularBlendIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectLargeIsSelectedIndicator: UIImageView!
    
    @IBOutlet weak var selectSmallIsSelectedIndicator: UIImageView!
    @IBOutlet weak var selectDecafIsSelectedIndicator: UIImageView!
    @IBAction func selectLarge(sender: AnyObject) {
        currentOrderDetails["size"] = "large"
        selectLargeIsSelectedIndicator.hidden = false
        selectMediumIsSelectedIndicator.hidden = true
        selectSmallIsSelectedIndicator.hidden = true
        sizeSelected = true
    }
    @IBAction func selectMedium(sender: AnyObject) {
        selectMediumIsSelectedIndicator.hidden = false
        selectLargeIsSelectedIndicator.hidden = true
        selectSmallIsSelectedIndicator.hidden = true
        currentOrderDetails["size"] = "medium"
         sizeSelected = true
    }
    @IBAction func selectSmall(sender: AnyObject) {
        selectMediumIsSelectedIndicator.hidden = true
        selectLargeIsSelectedIndicator.hidden = true
        selectSmallIsSelectedIndicator.hidden = false
        currentOrderDetails["size"] = "small"
         sizeSelected = true
    }
    @IBAction func selectWeak(sender: AnyObject) {
        selectWeakStrengthIsSelectedIndicator.hidden = false
        selectStrongStrengthIsSelectedIndicator.hidden = true
        selectRegularStrengthIsSelectedIndicator.hidden = true
        currentOrderDetails["strength"] = "weak"
        strengthSelected = true
    }
    @IBAction func selectRegular(sender: AnyObject) {
        selectWeakStrengthIsSelectedIndicator.hidden = true
        selectStrongStrengthIsSelectedIndicator.hidden = true
        selectRegularStrengthIsSelectedIndicator.hidden = false
        currentOrderDetails["strength"] = "regular"
        strengthSelected = true
    }
    @IBAction func selectStrong(sender: AnyObject) {
        selectWeakStrengthIsSelectedIndicator.hidden = true
        selectStrongStrengthIsSelectedIndicator.hidden = false
        selectRegularStrengthIsSelectedIndicator.hidden = true
        currentOrderDetails["strength"] = "strong"
        strengthSelected = true
    }
    @IBAction func selectRegularBlend(sender: AnyObject) {
        selectRegularBlendIsSelectedIndicator.hidden = false
        selectDecafIsSelectedIndicator.hidden = true
        currentOrderDetails["blend"] = "regular"
        blendSelected = true
    }
  
    @IBOutlet weak var selectAlmondMilkButton: UIButton!
    @IBOutlet weak var selectSoyMilkButton: UIButton!
    @IBOutlet weak var selectSkimMilkButton: UIButton!
    @IBOutlet weak var selectFullCreamButton: UIButton!
    @IBAction func selectFullCreme(sender: AnyObject) {
        selectFullCreamButton.titleLabel?.textColor = UIColor(red: 0, green: 100, blue: 0, alpha: 1)
        selectSkimMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSoyMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectAlmondMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        currentOrderDetails["milk"] = "full cream"
        milkSelected = true
        
    }
    @IBAction func selectDecafBlend(sender: AnyObject) {
        
        selectRegularBlendIsSelectedIndicator.hidden = true
        selectDecafIsSelectedIndicator.hidden = false
        currentOrderDetails["blend"] = "decaf"
        blendSelected = true
    }
    @IBOutlet weak var selectFullCremeButton: UIButton!

   
    @IBAction func selectAlmondMilk(sender: AnyObject) {
        selectFullCreamButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSkimMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSoyMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectAlmondMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 100, blue: 0, alpha: 1)
        currentOrderDetails["milk"] = "almond"
        milkSelected = true
    }

    
    
    @IBAction func selectSoyMilk(sender: AnyObject) {
        selectFullCreamButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSkimMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSoyMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 100, blue: 0, alpha: 1)
        selectAlmondMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        currentOrderDetails["milk"] = "soy"
        milkSelected = true
    }

    @IBAction func selectSkimMilk(sender: AnyObject) {
        selectFullCreamButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectSkimMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 100, blue: 0, alpha: 1)
        selectSoyMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectAlmondMilkButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        currentOrderDetails["milk"] = "skim"
        milkSelected = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
            self.title =  currentOrderDetails["order"]
        
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
