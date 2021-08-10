//
//  OnboardingViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class OnboardingViewController: UIViewController {

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
        swiperCollectionView.delegate = self
        swiperCollectionView.dataSource = self
        
    }
    
    func setupViews(){
      roundCorners(button: getStartedButton)
    }
   
    @IBAction func onPressGetStartedButton(_ sender: UIButton){
        PresenterManager.shared.showViewController(vc: .authInit)
    }
   

}

extension OnboardingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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
