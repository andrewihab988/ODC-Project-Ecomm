//
//  SignUpPage.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 10/04/2023.
//

import UIKit
import Alamofire
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class SignUpPage: UIViewController {

    private let POST_LOGIN_DATA = "https://student.valuxapps.com/api/register"
    var phone:String=""
    var pass:String = ""
    var email:String = ""
    var confirmpass:String = ""
    var name:String = ""
    var delegate:DataLoaded?
    static let ID = String(describing: SignUpPage.self)
    
    @IBOutlet weak var emaiTF: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var userTF: UITextField!
    
    @IBOutlet weak var confirmpassTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initHideKeyboard()
    }
    
    func setupUI(user:User?){
        
        navigate(HomePage.ID)
    }
    
    @IBAction func backbtn(_ sender: Any) {
        navigate(FirstVC.ID)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        if passTF.text != confirmpassTF.text{
            errormessage(param: "Password do not match")
        }else {
            let headers:HTTPHeaders = [
                 "lang": "en"
             ]
            var params = ["name":nameTF.text,"email":emaiTF.text,"password":passTF.text,"phone":userTF.text]
                

            AF.request(POST_LOGIN_DATA, method: .post,parameters: params, encoder: .json, headers: headers as? HTTPHeaders).responseDecodable(of: loginRes.self){res in
                if res.response?.statusCode == 200 {
                                switch res.result {
                                case .success(let regRes):
                                    if regRes.message == "This phone has been used before" || regRes.message == "This email has been used before"{
                                        self.errormessage(param: "This User has been registered before")
                                    }
                                    print(regRes.message!)
                                    if regRes.status {
                                        self.navigate(HomePage.ID)
                                        self.delegate?.isSucces()
                                    }
                                case .failure(let error):
                                    self.delegate?.isFailure()
                                    print(error)
                                }
                    }
                }
            
            
        }
        
       
        
        
        
        }
        
        
       
    
    
    
    
    

}




