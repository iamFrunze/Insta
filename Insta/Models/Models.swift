//
//  Models.swift
//  Insta
//
//  Created by Антон Коротков on 12.02.2022.
//

import Foundation

enum Gender {
  case male, female, other
}

struct User {
  let username: String
  let bio: String
  let name: (first: String, last: String)
  let birtDate: Date
  let gendet: Gender
  let counts: UserCount
  let joinDate: Date
}

struct UserCount {
  let followers: Int
  let following: Int
  let posts: Int
}

/// Represents a user post
public struct UserPost {
  let identifier: String
  let postType: UserPostType
  let thumbnailImage: URL
  let postURL: URL
  let caption: String?
  let likeCount: [PostLike]
  let comments: [PostComment]
  let createdDate: Date
  let taggedUsers: [User]
}

struct PostLike {
  let username: String
  let commentIdentifier: String
}

struct CommentLike {
  let username: String
  let postIdentifier: String
}

struct PostComment {
  let identifier: String
  let username: String
  let text: String
  let createdDate: Date
  let likes: [CommentLike]
}
