//
//  BaseViewController.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation
import UIKit
import RxSwift
import SideMenu

class BaseViewController: UIViewController{
    let disposeBag = DisposeBag()
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupSideMenu(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "menu") ,style: .plain, target: self, action: #selector(menuTapped))

        menu = SideMenuNavigationController.init(rootViewController: SideMenuController())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    ///handles clicking on the side menu Button
    @objc
    func menuTapped(){
        present(menu!, animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func pauseInteraction() {
        self.view.isUserInteractionEnabled = false
    }
    
    func resumeInteraction() {
        self.view.isUserInteractionEnabled = true
    }
}
