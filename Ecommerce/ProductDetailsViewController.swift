import Alamofire

import UIKit
import Kingfisher
class ProductDetailsViewController:UIViewController{
    
    
    
    @IBOutlet weak var productDetailsImg: UIImageView!
    static let ID = String(describing: ProductDetailsViewController.self)
    
    @IBOutlet weak var productdetailsdesc: UILabel!
    
    @IBOutlet weak var productdetailsPrice: UILabel!
    @IBOutlet weak var productDetailsName: UILabel!
    
    private let GET_PRODUCTS_DATA = "https://student.valuxapps.com/api/products"
    var productDetailsID: Int?
    var productDetails: DataClass3?
    var productsdata:DataClass3?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productId = productDetailsID {
            getProductDetails(with: productId)
        }
        print(productDetailsID)
        updateUI()
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        navigate(HomePage.ID)
    }
    
    
    func getProductDetails(with id: Int) {
        let headers: HTTPHeaders = [
            "lang": "en"
        ]
        let url = "\(GET_PRODUCTS_DATA)/\(id)"
        print(url)
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ProductDetails.self) { response in
            switch response.result {
            case .success(let productDetails):
                self.productsdata = productDetails.data
                self.updateUI()
                print(productDetails)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func cartbtn(_ sender: Any) {
       
    }
    
    
    
    func updateUI() {
        if let product = productsdata {
            productDetailsName.text = product.name
            productdetailsdesc.text = product.description
            productdetailsPrice.text = "$\(product.price)"
            productDetailsImg.kf.setImage(with: URL(string: product.image))
        }
        
        
        
    }
}
