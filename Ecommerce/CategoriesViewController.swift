import Alamofire

import UIKit

class CategoriesViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate{
    
    
    
    static let ID = String(describing: CategoriesViewController.self)
    
    @IBOutlet weak var productCV: UICollectionView!
    
  
    
    private let GET_PRODUCTS_DATA = "https://student.valuxapps.com/api/categories"
    var productDetailsID: Int?
    var productDetails: Datum?
    var productsdata:[Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCV.delegate = self
        productCV.dataSource = self
        if let productId = productDetailsID {
            getProductDetails(with: productId)
        }
        print(productDetailsID)
        updateUI()
        
    }
    
    func getProductDetails(with id: Int) {
        let headers: HTTPHeaders = [
            "lang": "en"
        ]
        let url = "\(GET_PRODUCTS_DATA)/\(id)"
        print(url)
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CategoriesID.self) { response in
            switch response.result {
            case .success(let productDetails):
                self.productsdata = productDetails.data.data
                self.productCV.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in section: \(productsdata.count)")
        return productsdata.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesDetails", for: indexPath) as! CategoriesDetails
        let product = productsdata[indexPath.row]
        cell.configure(products: productsdata[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsdata[indexPath.row]
        getProductDetails(with: product.id!)
    }
    
    func updateUI() {
        productCV.reloadData()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        navigate(CategoriesPage.ID)
    }
    
}
