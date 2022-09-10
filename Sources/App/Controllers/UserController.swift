//
//  UserController.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Vapor

class UserController {
    weak private var dbMock: DataBaseMock?

    init(_ dbMock: DataBaseMock) {
        self.dbMock = dbMock
    }

    /// Сreate user.
    ///
    /// query string:
    /// - login
    /// - password
    /// - firstname
    /// - lastname
    /// - email
    /// - gender
    /// - credit_card
    /// - bio
    ///
    /// Checking for empty fields.
    /// - Parameter req: request
    /// - Returns: result message
    func create(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(UserDataRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если в запросе пустое поле
        guard !body.login.isEmpty && !body.password.isEmpty
                && !body.firstname.isEmpty && !body.lastname.isEmpty
                && !body.email.isEmpty && !body.gender.isEmpty
                && !body.credit_card.isEmpty && !body.bio.isEmpty
        else {
            throw Abort(.badRequest, reason: "Empty required fields")
        }
        
        let response = MessageResponse(message: "Регистрация прошла успешно!")

        return req.eventLoop.future(response)
    }

    /// Change user info.
    ///
    /// query string:
    /// - login
    /// - password
    /// - firstname
    /// - lastname
    /// - email
    /// - gender
    /// - credit_card
    /// - bio
    ///
    /// Checking for empty fields.
    /// - Parameter req: request
    /// - Returns: result message
    func changeInfo(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(UserDataRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если в запросе пустое поле
        guard !body.login.isEmpty && !body.password.isEmpty
                && !body.firstname.isEmpty && !body.lastname.isEmpty
                && !body.email.isEmpty && !body.gender.isEmpty
                && !body.credit_card.isEmpty && !body.bio.isEmpty
        else {
            throw Abort(.badRequest, reason: "Empty required fields")
        }

        // изменяем данные в фиктивной бд.
        dbMock?.user.updateUserInfo(body)

        let response = MessageResponse(message: "Данные изменены!")

        return req.eventLoop.future(response)
    }

    /// Reset user info.
    ///
    /// query string:
    /// - auth_token
    ///
    /// Token verification.
    /// - Parameter req: request
    /// - Returns: result message
    func resetInfo(_ req: Request) throws -> EventLoopFuture<MessageResponse> {
        guard let body = try? req.content.decode(ResetUserInfoRequest.self) else {
            throw Abort(.badRequest)
        }

        // выдает ошибку если токен не совпадает
        guard body.auth_token == dbMock?.authToken else {
            throw Abort(.badRequest, reason: "Bad auth token")
        }

        // Сбрасываем данные в фиктивной бд.
        dbMock?.user.resetUserInfo()

        let response = MessageResponse(message: "Данные сброшены!")

        return req.eventLoop.future(response)
    }
}
