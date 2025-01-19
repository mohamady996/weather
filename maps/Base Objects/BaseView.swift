//
//  BaseView.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation
import UIKit

class BaseView: UIView {
    let label = UILabel()
    let stack = UIStackView()
    
    ///programatically sets the View to be in a stack view and adds a hidden label below it
    func readyErrorMessage(){
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        label.isHidden = true
        label.numberOfLines = 2
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        
//         Add the label to the same stack view as the view
        if let stackView = superview as? UIStackView{
            if let index = stackView.arrangedSubviews.firstIndex(of: self) {
                // 'index' now contains the position of 'self' in the stack view
                stackView.insertArrangedSubview(stack,at: index)
                stack.addArrangedSubview(self)
                stack.addArrangedSubview(label)
            }
        }
    }
    
    ///shows an error message below the UIView
    func showErrorMessageBelow(message:String){
        label.isHidden = (message == "")
        self.layer.borderColor = message == "" ? UIColor.gray.cgColor : UIColor.red.cgColor
        label.text = message
    }
}
