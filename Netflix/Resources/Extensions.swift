//
//  Extensions.swift
//  Netflix
//
//  Created by Gadirli on 27.10.22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
