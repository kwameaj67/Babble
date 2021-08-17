//
//  WelcomeViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyles()
     
    }
    
    
    func buttonStyles(){
        roundCorners(button: loginButton)
        roundCorners(button: getStartedButton)
        loginButton.layer.backgroundColor = .none
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = CGColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }

    @IBAction func onPressGetStartedButton(_ sender: Any) {
        animatePulseButton(getStartedButton)
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.genderController) as! GenderViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onPressloginButton(_ sender: Any) {
        animatePulseButton(loginButton)
        modalPresentationStyle = .fullScreen
    }
    
}
