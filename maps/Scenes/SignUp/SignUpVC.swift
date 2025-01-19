//
//  SignUpVC.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpVC: BaseViewController {
    
    var signUpVM: SignUpVM!

    @IBOutlet weak var firstNameView: BaseView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameView: BaseView!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var ageView: BaseView!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var emailView: BaseView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: BaseView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpBtn: BaseButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        signUpVM = SignUpVM()
        setupViews()
        bindViews()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        signUpVM.signUpAction(firstName: firstNameTF.text ?? "",
                                LastName: lastNameTF.text ?? "",
                                age: Int(ageTF.text ?? "") ?? 0,
                                email: emailTF.text ?? "",
                                password: passwordTF.text ?? "")
        //returns to the login page after creating an account
        goToLogIn()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        goToLogIn()
    }
    
    
    ///setups up the views
    private func setupViews(){
        signUpBtn.isActive(false)
        
        firstNameView.readyErrorMessage()
        lastNameView.readyErrorMessage()
        ageView.readyErrorMessage()
        emailView.readyErrorMessage()
        passwordView.readyErrorMessage()
    }
    
    ///binds the views using RX
    private func bindViews(){
        self.firstNameTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.firstNameTF.text ?? ""
                let message = self.signUpVM.validateFirstName(name: text) ? "" : "First Name is required"
                self.firstNameView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
        
        self.lastNameTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.lastNameTF.text ?? ""
                let message = self.signUpVM.validateLastName(name: text) ? "" : "Last Name is required"
                self.lastNameView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
        
        self.ageTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.ageTF.text ?? ""
                let message = self.signUpVM.validateAge(age: Int(text) ?? 0) ? "" : "Invalid age"
                self.ageView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
        
        self.emailTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.emailTF.text ?? ""
                let message = self.signUpVM.validateEmail(email:text) ? "" : "Invalid email address"
                self.emailView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
        
        self.passwordTF.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                let text = self.passwordTF.text ?? ""
                let message = self.signUpVM.validatePassword(password:text) ? "" : "Invalid password"
                self.passwordView.showErrorMessageBelow(message: message)
                
                self.checkButtonValidity()
            })
            .disposed(by: disposeBag)
    }
    
    ///returns to the Log In Page
    private
    func goToLogIn(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    ///enables or disables  the button activity based on the validation of all fields
    private
    func checkButtonValidity(){
        let btnvalidity = self.signUpVM.validateALlFields(firstName: firstNameTF.text ?? "",
                                                          LastName: lastNameTF.text ?? "",
                                                          age: Int(ageTF.text ?? "") ?? 0,
                                                          email: emailTF.text ?? "",
                                                          password: passwordTF.text ?? "")
        signUpBtn.isActive(btnvalidity)
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
