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
        
    static let noteColor1 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.noteColor1Dark } else {
                return MyColors.noteColor1Light
                
             }
        }
    }()
    
    static let noteColor2 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.noteColor2Dark } else {
                return MyColors.noteColor2Light
                
             }
        }
    }()
    
    static let noteColor3 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.noteColor3Dark } else {
                return MyColors.noteColor3Light
                
             }
        }
    }()
    static let noteColor4 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return MyColors.noteColor4Dark } else {
                return MyColors.noteColor4Light
                
             }
        }
    }()
    static let noteColor5 = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return MyColors.noteColor5Dark } else {
                    return MyColors.noteColor5Light
                    
                 }
        }
        
    }()
    
    static func getColor(number: Int) -> UIColor {
        switch number {
        case 1:
            return .noteColor1
        case 2:
            return .noteColor2
        case 3:
            return .noteColor3
        case 4:
            return .noteColor4
        case 5:
            return .noteColor5
        default:
            return .noteColor1
        }
    }
}
