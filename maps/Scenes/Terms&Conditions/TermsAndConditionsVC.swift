//
//  ProfileVC.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import UIKit

class TermsAndConditionsVC: BaseViewController {
    
    var viewModel: TermsAndConditionsVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = TermsAndConditionsVM()
        setupSideMenu()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
