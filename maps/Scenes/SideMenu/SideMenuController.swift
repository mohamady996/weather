//
//  SideMenuController.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation
import UIKit

class SideMenuController: UITableViewController{
    var items = ["Home", "Profile", "Terms & Conditions", "Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sideMenuCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            navigateToViewController(storyboard: "Home",identifier: "HomeVC")
        case 1:
            navigateToViewController(storyboard: "Profile",identifier: "ProfileVC")
        case 2:
            navigateToViewController(storyboard: "TermsAndConditions",identifier: "TermsAndConditionsVC")
        case 3:
            handleLogout()
        default:
            print("default cell tapped")
        }
    }
    
    private
    func navigateToViewController(storyboard: String, identifier: String) {
        if let navigationController = self.presentingViewController as? UINavigationController {
            self.dismiss(animated: true)
            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
            if let targetVC = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController {
                navigationController.pushViewController(targetVC, animated: false)
            }
        }
    }
    
    private
    func handleLogout() {
        if let navigationController = self.presentingViewController as? UINavigationController {
            self.dismiss(animated: true)
            navigationController.popToRootViewController(animated: false)
        }
    }
}
