//
//  Rating.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

class Rating {
    var title: String?
    var logo: String?
    var rating: Int?
    var ratingDate: String?
}

class Rapid: Rating {
    init(ratingApi: RatingAPI) {
        super.init()
        self.title = "Rapid"
        self.logo = "rapid"
        self.rating = ratingApi.chessRapid?.last?.rating
        self.ratingDate = DateCreator.dateString(from: ratingApi.chessRapid?.last?.date)
    }
}

class Blitz: Rating {
    init(ratingApi: RatingAPI) {
        super.init()
        self.title = "Blitz"
        self.logo = "blitz"
        self.rating = ratingApi.chessBlitz?.last?.rating
        self.ratingDate = DateCreator.dateString(from: ratingApi.chessBlitz?.last?.date)
    }
}

class Tactic: Rating {
    init(ratingApi: RatingAPI) {
        super.init()
        self.title = "Tactic"
        self.logo = "tactic"
        self.rating = ratingApi.tactics?.highest?.rating
        self.ratingDate = DateCreator.dateString(from: ratingApi.tactics?.highest?.date)
    }
}

class Bullet: Rating {
    init(ratingApi: RatingAPI) {
        super.init()
        self.title = "Bullet"
        self.logo = "bullet"
        self.rating = ratingApi.chessBullet?.last?.rating
        self.ratingDate = DateCreator.dateString(from: ratingApi.chessBullet?.last?.date)
    }
}


class Daily: Rating {
    init(ratingApi: RatingAPI) {
        super.init()
        self.title = "Dayli"
        self.logo = "daily"
        self.rating = ratingApi.chessDaily?.last?.rating
        self.ratingDate = DateCreator.dateString(from: ratingApi.chessDaily?.last?.date)
    }
}

