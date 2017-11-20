//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore


class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var characterIconButton: UIButton!
    @IBOutlet weak var vehicleIconButton: UIButton!
    @IBOutlet weak var starshipIconButton: UIButton!
    
    @IBOutlet weak var refreshIconButton: UIButton!
    @IBOutlet weak var refreshIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkConnection()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func characterDataBase(_ sender: UIButton) {
        JSONDownloader.characterDownloader()
        dataType = DataType.character
    }
    
    @IBAction func vehicleDataBase(_ sender: UIButton) {
        JSONDownloader.vehilceDownload()
        dataType = DataType.vehicle
    }
    @IBAction func starshipDataBase(_ sender: UIButton) {
        JSONDownloader.starshipDownload()
        dataType = DataType.starship
    }
    
    @IBAction func refreshView(_ sender: UIButton) {
        checkConnection()
        toggleRefresh()
    }
    
    // Refresh Animation
    func toggleRefresh() {
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.delegate = self
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.duration = 0.5
        fullRotation.repeatCount = 5
        refreshIconButton.layer.add(fullRotation, forKey: "360")
    }
    
    // Helper Methods
    func checkConnection() {
        if InternetChecker.isConnectedToNetwork() {
            print("Yes Internet")
            JSONDownloader.characterDownloader()
            JSONDownloader.vehilceDownload()
            JSONDownloader.starshipDownload()
            enableIconButtons()
        } else {
            let alert = UIAlertController(title: "Error!", message: "No Internet Connection", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            disableIconButtons()
            print("No Internet")
        }
        
    }
    
    func test() {
        JSONDownloader.starshipDownload()
    }
    
    func disableIconButtons() {
        let iconButtons = [characterIconButton, vehicleIconButton, starshipIconButton]
        for button in iconButtons {
            button?.isEnabled = false
        }
    }
    
    func enableIconButtons() {
        let iconButtons = [characterIconButton, vehicleIconButton, starshipIconButton]
        for button in iconButtons {
            if button?.isEnabled == false {
                button?.isEnabled = true
            }
        }
    }
    
}













