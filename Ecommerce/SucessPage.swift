//
//  SucessPage.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 11/04/2023.
//

import UIKit

class SucessPage: UIViewController {
    static let ID = String(describing: SucessPage.self)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startBtn(_ sender: Any) {
        navigate(HomePage.ID)
    }
    

}
