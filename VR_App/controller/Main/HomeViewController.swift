//
//  HomeViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
   
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        animation(recordButton)
        let user = Auth.auth().currentUser?.email
        print(user ?? "user no found")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func styles(){
        roundCorners(button: recordButton)
        recordButton.layer.shadowColor = Constants.Colors.CGgreen
        recordButton.layer.shadowRadius = 35
        recordButton.layer.shadowOpacity = 1
        recordButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    func animation(_ animateTo: UIButton){
        UIButton.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0.0, options: [.autoreverse,.repeat,.curveEaseIn]) {
            animateTo.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { (_) in
            UIButton.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.repeat, .autoreverse, .curveEaseIn], animations: {
                animateTo.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
            }, completion:nil)
        }
    }

  
    @IBAction func onTapRecordBustton(_ sender: UIButton) {
        print("Tapped")
        
    }
}
