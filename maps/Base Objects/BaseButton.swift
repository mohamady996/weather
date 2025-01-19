//
//  BaseButton.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation
import UIKit

class BaseButton: UIButton{
    
    func isActive(_ flag: Bool) {
        self.alpha = (flag ? 1 : 0.5)
        self.backgroundColor = self.backgroundColor?.withAlphaComponent( self.alpha )
        self.isEnabled = flag
        self.isUserInteractionEnabled = flag
    }
}
