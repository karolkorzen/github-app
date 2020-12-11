//
//  Repository.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import Foundation

struct RawRepositoryResponse: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let name: String
    let owner: Owner
    let stargazers_count: Int
    let html_url: String
}

struct Owner: Codable {
    let avatar_url: String
    let login: String
}
