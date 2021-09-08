//
//  TranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class TranscriptionsViewController: UIViewController {
    
    var transcriptionArray:[TranscriptModel] = TranscriptModel.transcriptData
    var myDate:String = ""
    var myTitle:String = ""
    var myDescription:String = ""
    @IBOutlet var transcriptionTableVIew: UITableView!
   
    let searchBar = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        transcriptionTableVIew.delegate = self
        transcriptionTableVIew.dataSource = self
        transcriptionTableVIew.layer.cornerRadius = 10
        navigationItem.searchController = searchBar
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailedTranscriptionViewController
        destinationVC.noteDate = myDate
        destinationVC.noteDescription = myDescription
        destinationVC.noteTitle = myTitle
        
    }
}

extension TranscriptionsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transcriptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TranscriptionTableViewCell
        cell.selectionStyle = .none
        let row = transcriptionArray[indexPath.row]
        cell.setupTranscriptionCell(item: row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var row = transcriptionArray[indexPath.row]
//        print("\(row.title)")
        myTitle = row.title
        myDescription =  row.description
        myDate = row.date
        let data = [
            "date": myDate,
            "title": myTitle,
            "description":myDescription
        ]
        print("\(data)")
        
//        move to new screen
//        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.detailedTranscriptViewController) as! DetailedTranscriptionViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
// MARK:- edits search bar
    func styles(){
        let searchTextAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextAppearance.font = UIFont(name: "Avenir", size: 18)
        searchTextAppearance.textColor = .black
        
        let attributes:[NSAttributedString.Key: Any] = [  // edits cancel button
            .foregroundColor: Constants.Colors.green,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }

    
}
