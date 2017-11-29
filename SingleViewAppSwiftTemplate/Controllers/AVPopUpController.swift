//
//  AVPopUpController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
// Model Popups are neat!
class AVPopUpController: UIViewController {

    @IBOutlet weak var avLabel: UILabel!
    
    var avLabelText: String? = nil
    
    let characterValues = PeopleManager.profileAttributes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avLabel.text = avLabelText // I love using something i used in a previous project
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
