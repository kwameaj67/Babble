//
//  ProfileViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 03/10/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var name = userDefaultManager.userDetails.name
    var email = userDefaultManager.userDetails.email
    var gender = userDefaultManager.userDetails.gender
    var identity = userDefaultManager.userDetails.identity
    
    
    
    let profileList: [ActorDetails] = [
        ActorDetails(title: "\(ActorEnum.name.rawValue)", desc: userDefaultManager.userDetails.name),
        ActorDetails(title: "\(ActorEnum.email.rawValue)", desc: userDefaultManager.userDetails.email),
        ActorDetails(title: "\(ActorEnum.gender.rawValue)", desc: userDefaultManager.userDetails.gender),
        ActorDetails(title: "\(ActorEnum.hearingProfile.rawValue)", desc: userDefaultManager.userDetails.identity),
    ]
    
    @IBOutlet var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.dataSource = self
        profileTableView.delegate  = self
        title = "Profile"
        print("name is\( userDefaultManager.userDetails.name)")
        profileTableView.layer.cornerRadius = 10
    }
    

}
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.profile) as! ProfileTableViewCell
        let row = profileList[indexPath.row]
        cell.setupProfileDetails(with: row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    
}
