//
//  UIColor.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
// MARK: - UIColor
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let blueAct = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.blueActDark } else {
                return MyColors.blueActLight
                
                }
        }
    }()
   static let backgroundColor = {
       return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
           if UITraitCollection.userInterfaceStyle == .dark {
               return MyColors.backgroudColorDark } else {
               return MyColors.backgroudColorLight
               
            }
       }
   }()
    
   static let blueOff = {
       return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
           if UITraitCollection.userInterfaceStyle == .dark {
               return MyColors.blueClearDark } else {
               return MyColors.blueClearLight
               
            }
       }
   }()
    
    static let backViewColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.backColorDark } else {
                return MyColors.backColorLight
                
             }
        }
    }()
        
    static let nota1 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.nota1Dark } else {
                return MyColors.nota1Light
                
             }
        }
    }()
    
    static let nota2 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.nota2Dark } else {
                return MyColors.nota2Light
                
             }
        }
    }()
    
    static let nota3 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.nota3Dark } else {
                return MyColors.nota3Light
                
             }
        }
    }()
    static let nota4 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.nota4Dark } else {
                return MyColors.nota4Light
                
             }
        }
    }()
    static let nota5 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return MyColors.nota5Dark } else {
                    return MyColors.nota5Light
                    
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
