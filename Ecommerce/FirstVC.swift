//
//  ViewController.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 04/04/2023.
//

import UIKit

class FirstVC: UIViewController {
    static let ID = String(describing: FirstVC.self)
    @IBOutlet var SignUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
      
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.navigate(LoginPage.ID)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        self.navigate(OnBoarding.ID)
    }
    
}
