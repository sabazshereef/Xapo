//
//  Alert.swift
//  Xapo
//
//  Created by sabaz shereef on 04/01/22.
//

import Foundation
import UIKit


struct Alert {
    static func showErrorAlertWithMsg(title:String, msg:String, showOn vc:UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
   
}
