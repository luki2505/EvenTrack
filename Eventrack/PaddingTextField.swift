//
//  PaddingTextField.swift
//  bezline
//
//  Created by Lukas on 03.05.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
