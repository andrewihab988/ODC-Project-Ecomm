//
//  Extensions.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 04/04/2023.
//

import Foundation
import UIKit


extension UIViewController{
    
    func navigate(_ screenID:String, _ storyBoardID:String = "Main"){
        let storyBoard = UIStoryboard(name: storyBoardID, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: screenID)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop(){
        navigationController?.popViewController(animated: true)
    }
    
    func errormessage(param:String){
        let alertController = UIAlertController(title: "Alert", message: param, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return
    }
    
    
}

@IBDesignable extension UIButton {

    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable
        var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {

                layer.shadowRadius = newValue
            }
        }
        @IBInspectable
        var shadowOffset : CGSize{

            get{
                return layer.shadowOffset
            }set{

                layer.shadowOffset = newValue
            }
        }

        @IBInspectable
        var shadowColor : UIColor{
            get{
                return UIColor.init(cgColor: layer.shadowColor!)
            }
            set {
                layer.shadowColor = newValue.cgColor
            }
        }
        @IBInspectable
        var shadowOpacity : Float {

            get{
                return layer.shadowOpacity
            }
            set {

                layer.shadowOpacity = newValue

            }
        }
    }


extension UIViewController {
    
    func initHideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}
@IBDesignable extension UITextField {

    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
