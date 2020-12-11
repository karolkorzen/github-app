//
//  Commit.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import Foundation

struct RawCommitsResponse: Codable {
    let commit: Commit
}

struct Commit: Codable {
    let author: Author
    let message: String
}

struct Author: Codable {
    let name: String
    let email: String
}
