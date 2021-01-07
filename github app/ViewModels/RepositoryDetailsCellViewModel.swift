//
//  RepositoryDetailsCellViewModel.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import Foundation
import UIKit

class RepositoryDetailsCellViewModel {
    let commit: Commit
    let number: Int
    
    init(withCommit commit: Commit, withNumber number: Int){
        self.commit = commit
        self.number = number
    }
    
    var authorName: String {
        return commit.author.name.uppercased()
    }
    
    var numberLabelText: String {
        return number.description
    }
    
    var authorEmailLabelText: String {
        return commit.author.email
    }
    
    var commitMessageLabelText: String {
        return commit.message
    }
}
