//
//  TranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import MBProgressHUD

protocol TranscriptionListDelegate{
    func refreshTranscriptions()
}
class TranscriptionsViewController: UIViewController{
    
    let TimeStamp = NSDate().timeIntervalSince1970
    
    @IBOutlet var iconContainer: UIView!
    @IBOutlet var numOfNotes: UILabel!
    @IBOutlet var emptyMsgLabel: UILabel!
    var delegate: TranscriptionListDelegate?
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
        transcriptionTableVIew.tableFooterView = UIView() //hides extra empty cells in tableView
        configureSearchBar()
//        fetchData()
        fetchTranscriptions()
    }
    private func configureSearchBar(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
//    func fetchData(){
//        TranscriptionManager.shared.getTranscriptions { result in
//            switch result{
//            case .failure(let err):
//                print("\(err.localizedDescription)")
//            case .success(let data):
//                print("fetched data from firestore:\(data)")
//                let item = TranscriptModel(title: data["title"] as! String , description: data["description"] as! String, date: data["date"] as! Date)
//                self.transcriptionArray.append(item)
//            }
//        }
//    }
    
    //    fetch transcriptions
    func fetchTranscriptions(){
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(duration: 2.0) {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.transcriptionArray  = CoreDataManager.shared.fetchTranscriptions()
            self.transcriptionArray?.reverse()
            self.refreshTranscriptions()
        }
          
        }
    func goToDetailedTranscript(transcript: Transcriptions){
        //        move to new screen
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.detailedTranscriptViewController) as! DetailedTranscriptionViewController
        vc.delegate = self
        vc.transcript = transcript
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension TranscriptionsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transcriptionArray?.count ?? 0
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.TableViewCell.transcript, for: indexPath) as! TranscriptionTableViewCell
        cell.selectionStyle = .none
        let item = self.transcriptionArray![indexPath.row]
        cell.setupTranscriptionCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = transcriptionArray![indexPath.row]
        goToDetailedTranscript(transcript:item)
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
        DispatchQueue.main.async {
            self.transcriptionTableVIew.reloadData()
        }
    }
}
extension TranscriptionsViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
}
