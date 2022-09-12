//
//  DefaultUser.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивные данные юзера будто из бд.
final class UserMock: Codable {
    var id: Int = 0

    var login: String  = "admin"
    var password: String = "admin"
    var authToken: String = "905ef89d-25a4-4255-902f-fafd4f6a9774"

    var firstname: String = "Toxic"
    var lastname: String = "Frog"
    var email: String = "toxicFrog@gmail.com"
    var gender: String = "m"
    var creditCard: String = "9872389-2424-234224-234"
    var bio: String = "This is good! I think I will switch to another language"

    /// User info update.
    /// - Parameter request: request
    func updateUserInfo(_ request: UserInfoRequest ) {
        self.firstname = request.firstname
        self.lastname = request.lastname
        self.email = request.email
        self.gender = request.gender
        self.creditCard = request.credit_card
        self.bio = request.bio
    }

    /// Reset user info (for test).
    func resetUserInfo() {
        self.firstname = "Toxic"
        self.lastname = "Frog"
        self.email = "toxicFrog@gmail.com"
        self.gender = "m"
        self.creditCard = "9872389-2424-234224-234"
        self.bio = "This is good! I think I will switch to another language"
    }

    /// User summary
    func getInfoForResponse() -> UserResponse {
        UserResponse(id: self.id,
                     login: self.login,
                     firstname: self.firstname,
                     lastname: self.lastname)
    }
}
