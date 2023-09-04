
//  api.swift
//  Project_Task
//
//  Created by Andrew Ihab on 11/03/2023.
//

import Foundation
import Alamofire

protocol DataLoaded{
    func isSucces()
    func isFailure()
}


class API{
    
    private let GET_CATEGORIES_DATA = "https://student.valuxapps.com/api/categories"
    private let GET_PRODUCTS_DATA = "https://student.valuxapps.com/api/home"
    private let GET_BANNERS_DATA="https://student.valuxapps.com/api/home"
    private let GET_PRODUCTS_BY_CATEGORY = "https://student.valuxapps.com/api/categories/44"
    
    var delegate:DataLoaded?
    
    var categoriesdata:[Data2] = []
    var productsdata:[Product] = []
    var bannersdata:[Bannersdata] = []
    var productsData: [Product] = []
    var productsCat:[Datum] = []

    
    func getCategories(){
        
        let headers:HTTPHeaders = [
             "lang": "en"
         ]
        AF.request(GET_CATEGORIES_DATA ,method: .get,headers: headers as? HTTPHeaders).responseDecodable(of: Categories.self){ res in
          
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let categorieRes):
                    self.categoriesdata = categorieRes.data.data
                    print("success")
                    self.delegate?.isSucces()
                    
                case .failure(let er):
                    self.delegate?.isFailure()
                    print(er)	
                }
            }
        }
    }
    func getProductsByCategory(categoryID: Int) {
        let url = "https://student.valuxapps.com/api/categories/\(categoryID)"
        
        let headers: HTTPHeaders = [
            "lang": "en"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoriesID.self) { response in
            
            if response.response?.statusCode == 200 {
                
                switch response.result {
                case .success(let productCat):
                    self.productsCat = productCat.data.data
                    print("Products data fetched successfully")
                    print(productCat)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getProducts(){
        
        let headers:HTTPHeaders = [
             "lang": "en"
         ]
        AF.request(GET_PRODUCTS_DATA ,method: .get,headers: headers as? HTTPHeaders).responseDecodable(of: Products.self){ res in
          
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let productRes):
                    self.productsdata = productRes.data.products
                    print("success data is here")
                    self.delegate?.isSucces()
                    
                case .failure(let er):
                    self.delegate?.isFailure()
                    print(er)
                }
            }
        }
    }
    func getProductDetails(with id: Int) {
        let headers: HTTPHeaders = [
            "lang": "en"
        ]
        let url = "https://student.valuxapps.com/api/products/\(id)"
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Products.self) { res in
            if res.response?.statusCode == 200 {
                switch res.result {
                case .success(let productRes):
                    self.productsdata = productRes.data.products
                    print("success data is here")
                    self.delegate?.isSucces()
                    
                case .failure(let er):
                    self.delegate?.isFailure()
                    print(er)
                }
            }
        }
    }
    
    
    func getBanners(){
        
        AF.request(GET_BANNERS_DATA ,method: .get).responseDecodable(of: Banner.self){ res in
          
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let bannerRes):
                    self.bannersdata = bannerRes.data.banners
                    print("success data is here")
                    self.delegate?.isSucces()
                    
                case .failure(let er):
                    self.delegate?.isFailure()
                    print(er)
                }
            }
        }
    }
    
    
    
    
   // private let POST_LOGIN_DATA = "https://student.valuxapps.com/api/login"
    
   
    
   // var loginCred:[loginData] = []
    
   // func postLoginData(){
        
        
       // AF.request(POST_LOGIN_DATA , method: .post).responseDecodable(of: [loginCred].self){ res in
            
          //  if res.response?.statusCode == 200{
                
              //  switch res.result{
              /*  case .success(let categories):
                    self.categoriesdata = categories
                    print("success")
                    self.delegate?.isSucces()
                    
                case .failure(let er):
                    self.delegate?.isFailure()
                    print(er)
                }
            }
        }
    }*/
    
    
}

