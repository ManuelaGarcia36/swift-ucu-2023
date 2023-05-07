//
//  ExtensionDate.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 6/5/23.
//

import Foundation

extension Date {
    
    static func dateFromCustomString(customString: String) -> Date {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "MM/dd/yyyy"
        return dataFormatter.date(from: "10/31/2023") ?? Date()
    }
    
}
