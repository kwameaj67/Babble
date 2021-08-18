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
        
        let searchTextAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextAppearance.font = UIFont(name: "Avenir", size: 14)
        searchTextAppearance.textColor = .black
    }
    


}
