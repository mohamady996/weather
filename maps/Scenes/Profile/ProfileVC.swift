//
//  ProfileVC.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import UIKit

class ProfileVC: BaseViewController {

    var viewModel: ProfileVM!
    @IBOutlet weak var firstNameValueLabel: UILabel!
    @IBOutlet weak var lastNameValueLabel: UILabel!
    @IBOutlet weak var ageValueLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = ProfileVM()
        setupSideMenu()
        setupUI()
    }
    
    private
    func setupUI(){
        firstNameValueLabel.text = viewModel.getFirstName()
        lastNameValueLabel.text = viewModel.getLastName()
        ageValueLabel.text = viewModel.getAge()
        emailValueLabel.text = viewModel.getemail()
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
