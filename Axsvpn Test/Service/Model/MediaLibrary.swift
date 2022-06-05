//
//  MediaLibrary.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import Foundation

// MARK: - Welcome2
struct MediaResponse: Codable {
    let programs: [Program]
    
    enum CodingKeys: String, CodingKey {
        case programs
    }
}

// MARK: - Program
struct Program: Codable {
    let title: String
    let banner: Banner?
    let cover: Cover
    let descriptionHTML: String?
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case title
        case banner
        case cover
        case descriptionHTML
        case tracks
    }
}

// MARK: - Banner
struct Banner: Codable {
    let url: String
    let thumbnail: String
    let resolutions: [BannerResolution]
}

// MARK: - BannerResolution
struct BannerResolution: Codable {
    let url: String
    let size: Size
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

// MARK: - Cover
struct Cover: Codable {
    let url: String
    let thumbnail: String
    let resolutions: [CoverResolution]
}

// MARK: - CoverResolution
struct CoverResolution: Codable {
    let url: String
    let size: Int
}

// MARK: - Track
struct Track: Codable {
    let key: String
    let title: String
    let duration: Int
    let media: TrackMedia
    
    enum CodingKeys: String, CodingKey {
        case key
        case title
        case duration
        case media
    }
}

// MARK: - Media
struct TrackMedia: Codable {
    let mp3: Mp3
}

// MARK: - Mp3
struct Mp3: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}










