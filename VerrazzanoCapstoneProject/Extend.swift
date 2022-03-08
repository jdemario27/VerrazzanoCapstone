//
//  Extend.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/27/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
