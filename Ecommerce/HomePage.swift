//
//  HomePage.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit
import Kingfisher
class HomePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    static let ID = String(describing: HomePage.self)
    

    @IBOutlet weak var ProductCV: UICollectionView!
    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bannerCV: UICollectionView!
    
    var banners: [Bannersdata] = []
    var products: [Product] = []
    var filteredProducts: [Product] = []
    var api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHideKeyboard()
        
        
        api.delegate = self
        bannerCV.delegate = self
        bannerCV.dataSource = self
        ProductCV.delegate = self
        ProductCV.dataSource = self
        
        registerCell1(in: bannerCV)
        api.getBanners()
        api.getProducts()
        registerCell2(in: ProductCV)
        
        SearchTF.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCV {
            return banners.count
        } else if SearchTF.text?.isEmpty == false {
            return filteredProducts.count
        } else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCollectionViewCell.ID, for: indexPath) as! BannerCVCollectionViewCell
            
            cell.setup(with: banners[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.ID, for: indexPath) as! ProductCell
            
            let product: Product
            if SearchTF.text?.isEmpty == false {
                product = filteredProducts[indexPath.row]
            } else {
                product = products[indexPath.row]
            }
            
            cell.setup2(with: product)
            return cell
        }
    }
    
    func registerCell1(in collectionView: UICollectionView) {
        let nib = UINib(nibName: BannerCVCollectionViewCell.ID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BannerCVCollectionViewCell.ID)
    }
    
    func registerCell2(in collectionView: UICollectionView) {
        let nib = UINib(nibName: ProductCell.ID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ProductCell.ID)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            print("Product cell selected")
            let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailsViewController.ID) as! ProductDetailsViewController
            vc.productDetailsID = products[indexPath.row].id
        ProductCV.reloadData()
            navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func menubtn(_ sender: Any) {
        self.navigate(CategoriesPage.ID)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filteredProducts = products.filter { $0.name.lowercased().contains(textField.text!.lowercased()) }
        ProductCV.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredProducts.removeAll()
        ProductCV.reloadData()
        return true
    }
    
    
    @IBAction func signoutBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert", message: "You have been logged out", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        navigate(FirstVC.ID)
    }
}
    

extension HomePage: DataLoaded {
    func isSucces() {
        self.banners = api.bannersdata
        self.bannerCV.reloadData()
        self.products = api.productsdata
        self.ProductCV.reloadData()
    }
    func isFailure() {
        print("data is not here")
    }
    
    
}
