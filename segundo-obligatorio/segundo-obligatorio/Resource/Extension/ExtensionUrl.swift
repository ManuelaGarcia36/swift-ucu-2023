//
//  ExtensionUrl.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 4/6/23.
//

import Foundation

extension URL {
    static func makeURL(withString urlString: String) -> URL? {
        var finalURLString = urlString
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            // Agregar "https://" por defecto
            finalURLString = "https://" + urlString
        }
        if (urlString.contains("localhost") || urlString.contains("127.0.0.1")) {
            finalURLString = "https://" // podria ir una url simil page not found
        }
        return URL(string: finalURLString)
    }
}
