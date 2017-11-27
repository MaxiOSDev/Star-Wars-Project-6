//
//  AVPopUpController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class AVPopUpController: UIViewController {

    @IBOutlet weak var avLabel: UILabel!
    
    var avLabelText: String? = nil
    
    let characterValues = PeopleManager.profileAttributes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avLabel.text = avLabelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
