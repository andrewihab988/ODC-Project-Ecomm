//
//  CategoriesPageViewController.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit

class CategoriesPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    static let ID = String(describing: CategoriesPage.self)

    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var CategoriesCV: UICollectionView!

    var categories: [Data2] = []
    var filteredCategories: [Data2] = []
    var api = API()

    override func viewDidLoad() {
        super.viewDidLoad()

        api.delegate = self
        CategoriesCV.delegate = self
        CategoriesCV.dataSource = self
        SearchTF.delegate = self
        registerCell1(in: CategoriesCV)
        api.getCategories()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.ID, for: indexPath) as! CategoriesCell
        cell.setup2(with: filteredCategories[indexPath.row])
        return cell
    }

    func registerCell1(in collectionView: UICollectionView) {
        let nib = UINib(nibName: CategoriesCell.ID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CategoriesCell.ID)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: CategoriesViewController.ID) as! CategoriesViewController
        vc.productDetailsID = filteredCategories[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
        print("pushed")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        filterCategories(for: updatedText)
        return true
    }

    func filterCategories(for searchText: String) {
        if searchText.isEmpty {
            filteredCategories = categories
        } else {
            filteredCategories = categories.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
        CategoriesCV.reloadData()
    }
    @IBAction func backbtn(_ sender: Any) {
          self.navigate(HomePage.ID)
      }
}

extension CategoriesPage: DataLoaded {

    func isSucces() {
        self.categories = api.categoriesdata
        self.filteredCategories = categories
        self.CategoriesCV.reloadData()
    }

    func isFailure() {
        print("data is not here")
    }
}
