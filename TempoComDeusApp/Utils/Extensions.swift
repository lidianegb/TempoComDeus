//
//  Extensions.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView,
                 rightAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingRight: CGFloat? = nil,
                 constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let rightAnchor = rightAnchor, let padding = paddingRight {
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }

}

// MARK: - UIColor

class Style {
    static let blueActLight = UIColor.rgb(red: 6, green: 181, blue: 209)
    static let backgroudColorLight = UIColor.rgb(red: 228, green: 246, blue: 250)
    static let blueClearLight = UIColor.rgb(red: 148, green: 223, blue: 235)
    static let backColorLight = UIColor.rgb(red: 255, green: 255, blue: 255)
       
    static let blueActDark = UIColor.rgb(red: 0, green: 188, blue: 217)
    static let backgroudColorDark = UIColor.rgb(red: 0, green: 0, blue: 0)
    static let blueClearDark = UIColor.rgb(red: 106, green: 138, blue: 144)
    static let backColorDark = UIColor.rgb(red: 19, green: 20, blue: 21)
    
    static let nota1Light = UIColor.rgb(red: 254, green: 231, blue: 231)
    static let nota2Light = UIColor.rgb(red: 230, green: 235, blue: 246)
    static let nota3Light = UIColor.rgb(red: 217, green: 216, blue: 216)
    static let nota4Light = UIColor.rgb(red: 206, green: 224, blue: 213)
    static let nota5Light = UIColor.rgb(red: 255, green: 224, blue: 207)
    
    static let nota1Dark = UIColor.rgb(red: 184, green: 122, blue: 122)
    static let nota2Dark = UIColor.rgb(red: 122, green: 142, blue: 184)
    static let nota3Dark = UIColor.rgb(red: 77, green: 76, blue: 75)
    static let nota4Dark = UIColor.rgb(red: 64, green: 99, blue: 91)
    static let nota5Dark = UIColor.rgb(red: 222, green: 126, blue: 74)
       
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let blueAct = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.blueActDark } else {
                return Style.blueActLight
                
                }
        }
    }()
   static let backgroundColor = {
       return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
           if UITraitCollection.userInterfaceStyle == .dark {
               return Style.backgroudColorDark } else {
               return Style.backgroudColorLight
               
            }
       }
   }()
    
   static let blueOff = {
       return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
           if UITraitCollection.userInterfaceStyle == .dark {
               return Style.blueClearDark } else {
               return Style.blueClearLight
               
            }
       }
   }()
    
    static let backViewColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.backColorDark } else {
                return Style.backColorLight
                
             }
        }
    }()
        
    static let nota1 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.nota1Dark } else {
                return Style.nota1Light
                
             }
        }
    }()
    
    static let nota2 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.nota2Dark } else {
                return Style.nota2Light
                
             }
        }
    }()
    
    static let nota3 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.nota3Dark } else {
                return Style.nota3Light
                
             }
        }
    }()
    static let nota4 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return Style.nota4Dark } else {
                return Style.nota4Light
                
             }
        }
    }()
    static let nota5 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return Style.nota5Dark } else {
                    return Style.nota5Light
                    
                 }
        }
        
    }()
    
    static func getColor(name: String) -> UIColor {
        switch name {
        case "nota1":
            return .nota1
        case "nota2":
            return .nota2
        case "nota3":
            return .nota3
        case "nota4":
            return .nota4
        case "nota5":
            return .nota5
        default:
            return .nota1
        }
    }
}
