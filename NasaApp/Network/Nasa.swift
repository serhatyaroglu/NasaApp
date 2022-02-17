//
//  Nasa.swift
//  NasaApp
//
//  Created by serhat yaroglu on 13.02.2022.
//

import Foundation
import Alamofire
class NasaPhoto: Codable {
    let photos: [Photo]?

    init(photos: [Photo]?) {
        self.photos = photos
    }
}


// MARK: - Photo
class Photo: Codable {
    let id, sol: Int?
    let camera: Camera?
    let imgSrc: String?
    let earthDate: String?
    let rover: Rover?

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }

    init(id: Int?, sol: Int?, camera: Camera?, imgSrc: String?, earthDate: String?, rover: Rover?) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.imgSrc = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }
}


// MARK: - Camera
class Camera: Codable {
    let id: Int?
    let name: String
    let roverID: Int?
    let fullName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }

    init(id: Int?, name: String, roverID: Int?, fullName: String?) {
        self.id = id
        self.name = name
        self.roverID = roverID
        self.fullName = fullName
    }
}
// MARK: - Rover
class Rover: Codable {
    let id: Int?
    let name: String?
    let landingDate, launchDate: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }

    init(id: Int?, name: String?, landingDate: String?, launchDate: String?, status: String?) {
        self.id = id
        self.name = name
        self.landingDate = landingDate
        self.launchDate = launchDate
        self.status = status
    }
}

