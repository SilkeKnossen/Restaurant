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
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal =
            MenuController.shared.order.menuItems.reduce(0.0)
            { (result, menuItem) -> Double in
                return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
    
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in self.uploadOrder() })
            alert.addAction(UIAlertAction(title: "Cancel",
            style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier:
                    "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
        MenuController.shared.order.menuItems.removeAll()
        }
    }
}
