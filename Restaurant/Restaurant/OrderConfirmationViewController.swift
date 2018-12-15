//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    // Initlialize outlet
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    // Initlialize minutes until order is ready
    var minutes: Int!
    var orderMinutes = 0
    
    // When the view did load, set text label.
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
    
    // When unwinding, remove all items of order list.
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
        MenuController.shared.order.menuItems.removeAll()
        }
    }
}
