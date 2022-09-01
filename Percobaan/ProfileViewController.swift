//
//  ProfileViewController.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 01/09/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundProfile: UIView!
    @IBOutlet weak var cardViewProfile: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = " Back"
        
        //profileImage
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        //backgoudProfile
        backgroundProfile.layer.cornerRadius = 100.0
        backgroundProfile.layer.shadowColor = UIColor.gray.cgColor
        backgroundProfile.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        backgroundProfile.layer.shadowOpacity = 1.0
        
        //cardView
        cardViewProfile.layer.cornerRadius = 20.0
        cardViewProfile.layer.shadowColor = UIColor.gray.cgColor
        cardViewProfile.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardViewProfile.layer.shadowOpacity = 1.0
        cardViewProfile.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
