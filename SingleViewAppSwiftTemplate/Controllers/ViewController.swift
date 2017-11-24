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
    @IBOutlet var loadingView: UIView!
    @IBOutlet var shineView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PeopleManager.fetchPeople()
        //showLoadingScreen()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func characterDataBase(_ sender: UIButton) {
        
        dataType = DataType.character
    }
    
    @IBAction func vehicleDataBase(_ sender: UIButton) {
        
        dataType = DataType.vehicle
    }
    @IBAction func starshipDataBase(_ sender: UIButton) {
        
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
    
    func showLoadingScreen() {
        loadingView.bounds.size.width = view.bounds.width - 25
        loadingView.bounds.size.height = view.bounds.height - 40
        
        loadingView.center = view.center
        loadingView.alpha = 0
        
        view.addSubview(loadingView)
        UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
            self.loadingView.alpha = 1
        }) { (success) in
            self.animateShineView()
        }
        
    }
    
    func animateShineView() {
        UIView.animate(withDuration: 1, delay: 0.2, options: [], animations: {
            self.shineView.transform = CGAffineTransform(translationX: 0, y: -800)
        }) { (success) in
            
        //    self.hideLoadingScreen()
            DispatchQueue.main.async {
                self.checkConnection()
            }
            
        }
    }
    
    func hideLoadingScreen() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: 10)
        }) { (sucsess) in
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView.transform = CGAffineTransform(translationX: 0, y: -800)
            })
        }
    }
    
    
    
    func checkConnection() {
        func do_stuff(completion:(() -> Void)?) -> () {
            if InternetChecker.isConnectedToNetwork() {
                print("Yes Internet")
                PeopleManager.fetchPeople()
                JSONDownloader.vehilceDownload()
                JSONDownloader.starshipDownload()
                enableIconButtons()
                if completion != nil {
                    return completion!()
                }
            } else {
                let alert = UIAlertController(title: "Error!", message: "No Internet Connection", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
                disableIconButtons()
                print("No Internet")
            }
        }
        
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













