//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore // For my stormtrooper animation that doesn't refresh json data anymore, but it used to.


class ViewController: UIViewController, CAAnimationDelegate {
    // Outlets
    @IBOutlet weak var characterIconButton: UIButton!
    @IBOutlet weak var vehicleIconButton: UIButton!
    @IBOutlet weak var starshipIconButton: UIButton!
    
    @IBOutlet weak var refreshIconButton: UIButton!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var shineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingScreen()
      //  getData()
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
     //   checkConnection() Used to check connection a very outdated way, but thanks to URLError handling I can check it another way now
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
        DispatchQueue.main.async {
            PeopleManager.fetchPeople()
            VehicleManager.fetchVehicle()
            StarshipManager.fetchStarship()
            //   JSONDownloader.semaphore.signal()
        }
        UIView.animate(withDuration: 1, delay: 0.2, options: [.autoreverse, .repeat], animations: {
            self.animateLabel()
            UIView.setAnimationRepeatCount(5)
            self.shineView.transform = CGAffineTransform(translationX: 0, y: -800)
        }) { (success) in
            
            self.hideLoadingScreen()
        }
    }
    
    func hideLoadingScreen() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: 10)
        }) { (success) in
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView.transform = CGAffineTransform(translationX: 0, y: -800)
            })
        }
    }
    
    func getData() { // For testing Purposes
        DispatchQueue.main.async {
            PeopleManager.fetchPeople()
            VehicleManager.fetchVehicle()
            StarshipManager.fetchStarship()
        }
    }
    // Animates not really the label, but the dots/bars in the loading screen
    func animateLabel() {
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: 225, y: 460, width: 100, height: 20)  // CGRect(0,0,100,20)
        let bar = CALayer()
        bar.frame = CGRect(x: 0, y: 0, width: 5, height: 5)  // CGRect(0,0,10,20)
        bar.backgroundColor = UIColor.red.cgColor
        lay.addSublayer(bar)
        lay.instanceCount = 4
        lay.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        bar.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        self.loadingView.layer.addSublayer(lay)
    }
    
    // I would disable Icon Buttons if there was no interenet connection
    func disableIconButtons() {
        let iconButtons = [characterIconButton, vehicleIconButton, starshipIconButton]
        for button in iconButtons {
            button?.isEnabled = false
        }
    }
    // I would then enable them if there was internet connection
    func enableIconButtons() {
        let iconButtons = [characterIconButton, vehicleIconButton, starshipIconButton]
        for button in iconButtons {
            if button?.isEnabled == false {
                button?.isEnabled = true
            }
        }
    }
    
}













