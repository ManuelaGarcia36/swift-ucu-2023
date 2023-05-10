//
//  ExtensionColor.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 7/5/23.
//
import Foundation
import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// set colors project fast
let blueLogoView = UIColor(hex: 0x161b28)
let blueBackgroundTableView = UIColor(hex: 0x202045)
let lightBlueTableViewDetails = UIColor(hex: 0x5c77c2)
let blueBackgroundPickerCard = UIColor(hex: 0x4d4c72)
let greenBackgroundCard = UIColor(hex: 0x396765)
let greenBackgroundLabelCard = UIColor(hex: 0x029A53)
let redBackgroundCard = UIColor(hex: 0x78283a)
let redBackgroundLabelCard = UIColor(hex: 0xD1002F)
let blueBackgroundCard = UIColor(hex: 0x3A4B8C)
let blueBackgroundLabelCard = UIColor(hex: 0x1a36a3)
let blueBackgroundViewPendingCard = UIColor(hex: 0x96A4DC)
let greyBackgroundCard = UIColor(hex: 0x9A9CA5)
let greyBackgroundLabelCard = UIColor(hex: 0x5B5D66)
