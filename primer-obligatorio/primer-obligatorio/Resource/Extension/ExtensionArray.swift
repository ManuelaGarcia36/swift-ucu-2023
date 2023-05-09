//
//  ExtensionArray.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 8/5/23.
//

import Foundation
import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

