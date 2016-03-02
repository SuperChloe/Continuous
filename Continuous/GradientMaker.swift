//
//  GradientMaker.swift
//  Continuous
//
//  Created by Chloe on 2016-02-24.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

struct GradientMaker {
    
    static func gradientBackground(view: UIView) {
        let topColor = UIColor(red: 73.0/255.0, green: 10.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 189.0/255.0, green: 21.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        let viewGradient = CAGradientLayer()
        viewGradient.colors = [topColor.CGColor, bottomColor.CGColor]
        viewGradient.frame = view.bounds
        view.layer.insertSublayer(viewGradient, atIndex: 0)
    }
    
    static func gradientYellow(view: UIView) {
        let topColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 0.85)
        let bottomColor = UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 0.85)
        let viewGradient = CAGradientLayer()
        viewGradient.colors = [topColor.CGColor, bottomColor.CGColor]
        viewGradient.frame = view.bounds
        view.layer.insertSublayer(viewGradient, atIndex: 0)
    }
}
