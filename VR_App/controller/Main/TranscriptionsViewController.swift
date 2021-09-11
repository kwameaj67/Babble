//
//  TranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

protocol TranscriptionListDelegate{
    func refreshTranscriptions()
}
class TranscriptionsViewController: UIViewController{
    
    @IBOutlet var iconContainer: UIView!
    @IBOutlet var numOfNotes: UILabel!
    @IBOutlet var emptyMsgLabel: UILabel!
//    var transcriptionArray:[TranscriptModel] = TranscriptModel.transcriptData
    var transcriptionArray:[Transcriptions]? {
        didSet {
            numOfNotes.text = "\(String(describing: transcriptionArray?.count ?? 0)) \(transcriptionArray?.count == 1 ? "Note":"Notes")"
        }
    }
    @IBOutlet var transcriptionTableVIew: UITableView!
   
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        transcriptionTableVIew.delegate = self
        transcriptionTableVIew.dataSource = self
        transcriptionTableVIew.layer.cornerRadius = 10
        configureSearchBar()
        fetchTranscriptions()
    }
    private func configureSearchBar(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    //    fetch transcriptions
        func fetchTranscriptions(){
            transcriptionArray  = CoreDataManager.shared.fetchTranscriptions()
            transcriptionArray?.reverse()
        }

}

extension TranscriptionsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transcriptionArray?.count ?? 0
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TranscriptionTableViewCell
        cell.selectionStyle = .none
        let item = self.transcriptionArray![indexPath.row]
        cell.setupTranscriptionCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = transcriptionArray![indexPath.row]
        
//        move to new screen
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.detailedTranscriptViewController) as! DetailedTranscriptionViewController
        let formatter = DateFormatter()
        let transcriptDate = formatter.string(from: row.date ?? getDate())
        vc.noteDate = transcriptDate
        vc.noteTitle = row.title ?? ""
        vc.noteDescription = row.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandlder in
//            get object to remove
            let transcriptObject = self.transcriptionArray![indexPath.row]
//            delete object
            CoreDataManager.shared.deleteTranscription(transcript: transcriptObject)
            DispatchQueue.main.async {
                self.transcriptionTableVIew.reloadData()
            }
            self.fetchTranscriptions()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let transcriptObject = self.transcriptionArray![indexPath.row]
//        if editingStyle == .delete{
//           let delete = CoreDataManager.shared.deleteTranscription(transcript: transcriptObject)
//            switch delete {
//            case .success():
//                DispatchQueue.main.async {
//                    self.transcriptionTableVIew.reloadData()
//                }
//            case .failure(_):
//                print("cannot delete item")
//            }
//
//        }
//    }
    
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

extension TranscriptionsViewController: TranscriptionListDelegate{
    func refreshTranscriptions() {
        transcriptionTableVIew.reloadData()
    }
}
extension TranscriptionsViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
}
