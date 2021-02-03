//
//  UIAlertController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {
    func removeErrorConstraints() {
        self.view.subviews.flatMap({$0.constraints}).filter { (one: NSLayoutConstraint) -> (Bool)  in
        return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
}
