//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    var orderMinutes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
        MenuController.shared.order.menuItems.removeAll()
        }
    }
}
