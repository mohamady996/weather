//
//  SignInVM.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

class SignInVM: BaseViewModel {
    ///checks the validity of the email address
    func validateEmail(email:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    ///checks the validity of the password
    func validatePassword(password:String)->Bool{
        return password.count == 8
    }
    
    ///checks the validity of all the input Fields
    func validateALlFields(email: String,
                           password: String) -> Bool{
        
        return ( validateEmail(email: email) &&
                 validatePassword(password: password) )
    }
    
    ///checks the log in credentials
    func validateCredentials(email: String,password: String) -> Bool{
        let user = getUserFromUserDefaults(name: .savedUser)
        return (email == user?.email && password == user?.password )
    }
}
