//
//  OnboardingViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class OnboardingViewController: UIViewController {

    var img_index: Int = 0
    @IBOutlet weak var swipePageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var swiperCollectionView: UICollectionView!
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupPageControls()
        swiperCollectionView.delegate = self
        swiperCollectionView.dataSource = self
//        getStartedButton.setTitle("Get started", for: .normal)
        
    }
    
    func setupViews(){
      roundCorners(button: getStartedButton)
    }
   
    private func setupPageControls(){
        swipePageControl.numberOfPages = Swipe.swipeData.count
    }
    @IBAction func onPressGetStartedButton(_ sender: UIButton){
        swiperCollectionView.scrollToNextItem()
        let index = Int(swiperCollectionView.contentOffset.x) / Int(swiperCollectionView.frame.width)
        print(index)
        if index == 0{
            self.swipePageControl.allowsContinuousInteraction = true
            getStartedButton.setTitle("Next", for: .normal)
        }else if index == 1{
            self.swipePageControl.currentPage = index
            getStartedButton.setTitle("Next", for: .normal)
        }else{
            self.swipePageControl.currentPage = index
                getStartedButton.setTitle("Get started 👊🏽", for: .normal)
                PresenterManager.shared.showViewController(vc: .authInit)
        }
    }
}

extension OnboardingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Swipe.swipeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = swiperCollectionView.dequeueReusableCell(withReuseIdentifier: "swiper", for: indexPath) as! SwiperCollectionViewCell
        cell.configureSwiper(item: Swipe.swipeData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return swiperCollectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(swiperCollectionView.contentOffset.x) / Int(swiperCollectionView.frame.width)
        print(index)
        self.swipePageControl.currentPage = index
       if index == 1{
            getStartedButton.setTitle("Next", for: .normal)
        }else if index == 2{
            getStartedButton.setTitle("Get started 👊🏽", for: .normal)
        }
    }
    func setupCollectionView(){
        swiperCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.swiperCollectionView.collectionViewLayout = layout
        swiperCollectionView.isPagingEnabled = true
        swiperCollectionView.showsHorizontalScrollIndicator = false
    }
    
    
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
        
    }
    func moveToFrame(contentOffset : CGFloat) {
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
