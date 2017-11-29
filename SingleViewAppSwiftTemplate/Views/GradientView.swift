//
//  GradientView.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/21/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
// I use these to add addtional features to the IB credit to Mark Moeykins
@IBDesignable

class ThreePointGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor ]
        
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
    }
}
