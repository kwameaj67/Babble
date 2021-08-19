//
//  TranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class TranscriptionsViewController: UIViewController {
    
    let searchBar = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchBar
        
        
        
       
    }
    


}

extension TranscriptionsViewController{
    func styles(){
//        edits search bar
        let searchTextAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextAppearance.font = UIFont(name: "Avenir", size: 18)
        searchTextAppearance.textColor = .black
        searchTextAppearance.autocapitalizationType = .none
        searchTextAppearance.autocorrectionType = .no
        
        let attributes:[NSAttributedString.Key: Any] = [  // edits cancel button
            .foregroundColor: Constants.Colors.green,
            .font: UIFont.systemFont(ofSize: 16)
            
                
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
}
