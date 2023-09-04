//
//  OnBoarding.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 04/04/2023.
//

import UIKit

class OnBoarding: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    static let ID = String(describing: OnBoarding.self)
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    @IBOutlet var PageController: UIPageControl!
    
    var pageCells:[PageItem] = []
    
    var pageTitles = ["20% Discount New Arrival Product","Take Advantage Of The Offer Shopping ","All Types Offers Within Your Reach"]
    var pageDesc = ["Publish up your selfies to make yourself more beautiful with this app.", "Publish up your selfies to make yourself more beautiful with this app.","Publish up your selfies to make yourself more beautiful with this app."]
    var pageImgs = ["onboard1","onboard2","onboard3",]
    
    var currentPage = 0 {
        didSet {
            print("currentPage updated to \(currentPage)")
            PageController.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.isPagingEnabled = true
    }
    
    
    
    
    //MARK: collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.ID, for: indexPath) as! PageCollectionViewCell
        
        cell.setup(with: pageCells[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        print(currentPage)
    }
    

   func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
     let width = scrollView.frame.width
       PageController.currentPage = Int(scrollView.contentOffset.x / width)
   }
    
    
    
    @IBAction func nextBtn(_ sender: Any) {
        if currentPage == pageCells.count - 1 {
                print("Navigate")
                self.navigate(SignUpPage.ID)
            } else {
                currentPage += 1
                let xOffset = CGFloat(currentPage) * pageCollectionView.frame.width
                pageCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            }
    }
    

    // MARK: My methods
    func setupData(){
        for i in 1...pageTitles.count{
            pageCells.append(PageItem(pageImg: pageImgs[i - 1], pageTitle: pageTitles[i - 1], pageDesc: pageDesc[i - 1]))
        }
    }
}
