//
//  Login PageViewController.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit
import Alamofire
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class LoginPage: UIViewController {
    
    private let POST_LOGIN_DATA = "https://student.valuxapps.com/api/login"
    var username:String=""
    var pass:String = ""
    var delegate:DataLoaded?
    static let ID = String(describing: LoginPage.self)
    
    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    
    
    
    
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
        let headers:HTTPHeaders = [
             "lang": "en"
         ]
        var params = ["email":emailTf.text,"password":passTF.text]
            

        AF.request(POST_LOGIN_DATA, method: .post,parameters: params, encoder: .json, headers: headers as? HTTPHeaders).responseDecodable(of: loginRes.self){res in
                if res.response?.statusCode == 200{
                    
                    switch res.result{
                    case .success(let logRes):
                        print(logRes.message!)
                        if logRes.status{
                            
                            self.navigate(SucessPage.ID)
                            self.delegate?.isSucces()
                        }
                        if logRes.message == "This credentials does not meet any of our records, please make sure you have entered the right credentials"{
                            let alertController = UIAlertController(title: "Alert", message: "Please Check your Email or password", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                                self.emailTf.text = ""
                                self.passTF.text = ""
                                self.emailTf.becomeFirstResponder()
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }else if logRes.message == "Incorrect email format"{
                            let alertController = UIAlertController(title: "Alert", message: "Incorrect email format", preferredStyle: .alert)
                           let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                               self.emailTf.text = ""
                               self.passTF.text = ""
                               self.emailTf.becomeFirstResponder()
                           }
                           alertController.addAction(okAction)
                           self.present(alertController, animated: true, completion: nil)
                         
                       }
                            
                        
                    case .failure(let er):
                        self.delegate?.isFailure()
                        print(er)
                    }
                }
            }
        
        
    }
    
    
    
    @IBAction func googleBtn(_ sender: Any) {
        signInWithGoogle()
    }
    
    func signInWithGoogle(){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { res, error in
            
            guard error == nil else{
                print(error!)
                return
            }
            
            guard let user = res?.user,let idToken = user.idToken?.tokenString else{
                
                print(error!)
                print("user invalid")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                
                guard error == nil else {
                    print("error in auth \(error)")
                    return
                }
                let user = res?.user
                
                self.setupUI(user: user)
            }
            
        }
        
        
    }
    
    
    

}
