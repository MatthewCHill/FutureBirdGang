//
//  UIViewControllers.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenDone() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
