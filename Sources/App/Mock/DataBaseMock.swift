//
//  DataBaseMock.swift
//  
//
//  Created by Ke4a on 09.09.2022.
//

import Foundation

/// Фиктивная база данных.
final class DataBaseMock {
    lazy var user: UserMock = UserMock(self.catalog)

    var catalog: [Product] = []

    init() {
        self.catalog = self.createCatalog()
    }

    private func createCatalog() -> [Product] {
        var array: [Product] = []

        for index in (1...200) {
            let reviews = createReviews()
            array.append(Product(id: index,
                                 category: index % 2 == 0 ? 1 : 2,
                                 name: "Товар \(index)",
                                 price: Int.random(in: 0...100_000),
                                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                                 reviews: reviews))
        }
        return array
    }

    private func createReviews() -> [ReviewResponse] {
        var array: [ReviewResponse] = []

        for index in 0...40 {
            array.append(ReviewResponse(id_user: index, user_name: "Пользователь \(index)", id_review: index, text: "review \(index)"))
        }

        return array
    }
}
