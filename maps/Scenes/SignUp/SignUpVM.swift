//
//  SignUpMVVM.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

class SignUpVM: BaseViewModel{
    
    ///checks the validity of the first name
    func validateFirstName(name:String)->Bool{
        return name.count>0
    }
    
    ///checks the validity of the last name
    func validateLastName(name:String)->Bool{
        return name.count>0
    }
    
    ///checks the validity of the age
    func validateAge(age:Int)->Bool{
        return age>=18
    }
    
    ///checks the validity of the email address
    func validateEmail(email:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    ///checks the validity of the password
    func validatePassword(password:String)->Bool{
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8}$"
        
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    ///checks the validity of all the input Fields
    func validateALlFields(firstName: String,
                               LastName: String,
                               age: Int,
                               email: String,
                               password: String) -> Bool{
        
        return ( validateFirstName(name: firstName) &&
            validateLastName(name: LastName) &&
            validateAge(age: age) &&
            validateEmail(email: email) &&
            validatePassword(password: password) )
    }
    
    ///handles the logic of tapping on the sugn up button
    func signUpAction(firstName: String,
                      LastName: String,
                      age: Int,
                      email: String,
                      password: String ){
        
        let user = User(firstName: firstName, lastName: LastName, age: age, email: email, password: password)
        saveUserToUserDefaults(user: user, name: .savedUser)
    }
}
