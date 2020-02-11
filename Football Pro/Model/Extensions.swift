//
//  Extensions.swift
//  Football Pro
//
//  Created by tarek bahie on 9/22/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
extension UILabel{
    func setupBasicAttributes(){
        if #available(iOS 13.0, *) {
            textColor = .systemIndigo
        } else {
            textColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
        }
        textAlignment = .center
        numberOfLines = 0
    }
    func setupGrayColor(){
        textAlignment = .center
        if #available(iOS 13.0, *){
        textColor = .systemGray
        } else{
            textColor = .lightGray
        }
    }
    func setupSelectedColor()->UIColor{
        if #available(iOS 13.0, *){
            return .systemIndigo
        } else{
            return #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
        }
    }
    func setupUnselectedColor()->UIColor{
        if #available(iOS 13.0, *){
           return .systemGray
        } else{
            return .lightGray
        }
    }
    func setupCreditsAttributes(){
        numberOfLines = 0
        textAlignment = .center
        if #available(iOS 13.0, *){
            backgroundColor = .systemGray2
        }else{
            backgroundColor = #colorLiteral(red: 0.9003337026, green: 0.9099357128, blue: 0.9227717519, alpha: 1)
        }
    }
    func setupOutline(){
        layer.borderWidth = 1.0
        if #available(iOS 13.0, *){
            layer.borderColor = UIColor.systemIndigo.cgColor
        }else{
            layer.borderColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1).cgColor
        }
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
    func setupShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.9
        layer.masksToBounds = false
    }
    
}
extension UIImageView{
    func setupTintColor() {
        if #available(iOS 13.0, *){
            tintColor = .systemIndigo
        }else{
            tintColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
        }
    }
    func setupTabImageTint(){
        if #available(iOS 13.0, *){
            tintColor = .systemGray2
        }else{
            tintColor = .lightGray
        }
    }
    func setupOutline(){
        layer.borderWidth = 1.0
        if #available(iOS 13.0, *){
            layer.borderColor = UIColor.systemIndigo.cgColor
        }else{
            layer.borderColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1).cgColor
        }
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
}
extension UITextView{
    func setupAttrib(){
        if #available(iOS 13.0, *){
            textColor = UIColor.systemIndigo
            backgroundColor = .systemBackground
        }else{
            textColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1)
            backgroundColor = .white
        }
        
        textAlignment = .justified
        isScrollEnabled = true
        isEditable = false
        
    }
}
extension UIView{
    @objc func setupBgColor(){
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
    }
    func setupGradientLayer(){
        layer.masksToBounds = true
        layer.cornerRadius = 16.0
        layer.borderWidth = 2
//        layer.borderColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.03137254902, alpha: 1)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGreen
        } else {
            backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
        }
    }
    func setupBackGroundColor(){
        layer.masksToBounds = true
        layer.cornerRadius = 16.0
        layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGreen
        } else {
            backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
        }
        layer.borderColor = UIColor.lightGray.cgColor
        //scorer cell,squad cell,comp cell
    }
    func setupCVOutline(){
        layer.borderWidth = 1.0
        if #available(iOS 13.0, *){
            layer.borderColor = UIColor.systemIndigo.cgColor
        }else{
            layer.borderColor = #colorLiteral(red: 0.03137254902, green: 0.2549019608, blue: 0.3607843137, alpha: 1).cgColor
        }
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
}
extension UISearchBar {
    
    func tfBackgroundColor(){
        for view in self.subviews {
            for subview in view.subviews {
                if subview is UITextField {
                    let textField: UITextField = subview as! UITextField
                    if #available(iOS 13.0, *) {
                        textField.backgroundColor = .systemGreen
                    } else {
                        textField.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.5058823529, blue: 0.2901960784, alpha: 1)
                    }
                    
                }
            }
        }
    }
}
extension UIAlertController{
    func setupAlertTintColor(){
        if #available(iOS 13.0, *) {
            self.view.tintColor = .systemRed
        } else {
            self.view.tintColor = #colorLiteral(red: 0.6509803922, green: 0.1803921569, blue: 0.2549019608, alpha: 1)
        }
        
    }
}
