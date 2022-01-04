//
//  CustomButton.swift
//  Xapo
//
//  Created by sabaz shereef on 03/01/22.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
      
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    private func setUpView() {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
    }
    
    
    

}
