//
//  ViewController.swift
//  maps
//
//  Created by mohamad ghonem on 17/01/2025.
//

import UIKit

class SignInVC: BaseViewController {
    
    var viewModel: SignInVM!

    @IBOutlet weak var emailView: BaseView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: BaseView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInBtn: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = SignInVM()
        setupViews()
        bindViews()
    }

    ///handles when the sign in button is tapped
    @IBAction func signInTapped(_ sender: Any) {
        //the following comment checks if the credentials are the same as the saved registered account
//        if (self.signInVM.validateCredentials(email: emailTF.text ?? "",
//                                              password: passwordTF.text ?? "" )){
            self.goToDashBoard()
//        }
    }
    
    ///handles when the sign up button is tapped
    @IBAction func signUpTapped(_ sender: Any) {
        goToSignUP()
    }
    
    ///setups up the views
    private func setupViews(){
//        signInBtn.isActive(false)
        
        emailView.readyErrorMessage()
        passwordView.readyErrorMessage()
    }
    
    ///binds the views using RX
    private func bindViews(){
        self.emailTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.emailTF.text ?? ""
                let message = self.viewModel.validateEmail(email:text) ? "" : "Invalid email address"
                self.emailView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
        
        self.passwordTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.passwordTF.text ?? ""
                let message = self.viewModel.validatePassword(password:text) ? "" : "Invalid password"
                self.passwordView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
    }
    
    ///enables or disables  the button activity based on the validation of all fields
    private
    func checkButtonValidity(){
        let btnvalidity = self.viewModel.validateALlFields(email: emailTF.text ?? "",
                                                          password: passwordTF.text ?? "")
        signInBtn.isActive(btnvalidity)
    }
    
    ///handles the navigation to the sign up view controller
    private
    func goToSignUP(){
        let vc = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///handles the navigation to the dashboard
    private
    func goToDashBoard(){
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

