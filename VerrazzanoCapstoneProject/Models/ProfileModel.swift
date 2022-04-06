//
//  ProfileModel.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 4/6/22.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
