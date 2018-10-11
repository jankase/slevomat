//
// Created by Jan Kase on 2018-10-11.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

struct FeedJson: Decodable {

  var articles: [Article] = []

  init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: _FeedKeys.self)
    articles = try theContainer.decode([Article].self, forKey: .articles)
  }

  private enum _FeedKeys: String, CodingKey {
    case articles
  }

}
