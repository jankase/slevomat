//
// Created by Jan Kase on 2018-10-09.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Article: Object, Decodable {

  static var jsonDateFormatter: ISO8601DateFormatter = {
    let theResult = ISO8601DateFormatter()
    theResult.formatOptions = [.withInternetDateTime]
    return theResult
  }()

  override class func primaryKey() -> String? {
    return "internalUrl"
  }

  var url: URL? {
    return URL(string: internalUrl)
  }

  var imageUrl: UIImage? {
    guard let theImageData = imageData else {
      return nil
    }
    return UIImage(data: theImageData)
  }

  @objc dynamic var author: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var desc: String?
  @objc dynamic var internalUrl: String = ""
  @objc dynamic var imageData: Data?
//  @objc dynamic var internalImageUrl: String?
  @objc dynamic var publishDate: Date!

  required init() {
    super.init()
  }

  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }

  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }

  required init(from aDecoder: Decoder) throws {
    super.init()
    let theContainer = try aDecoder.container(keyedBy: _ArticleKeys.self)
    author = try theContainer.decode(String.self, forKey: .author)
    title = try theContainer.decode(String.self, forKey: .title)
    desc = try theContainer.decodeIfPresent(String.self, forKey: .description)
    internalUrl = try theContainer.decode(String.self, forKey: .url)
    //TODO image data download async
    if let theImageUrlString = try theContainer.decodeIfPresent(String.self, forKey: .urlToImage),
       let theImageUrl = URL(string: theImageUrlString) {
      imageData = try? Data(contentsOf: theImageUrl)
    }
    let thePublishDateString = try theContainer.decode(String.self, forKey: .publishedAt)
    if let thePublishDate = Article.jsonDateFormatter.date(from: thePublishDateString) {
      publishDate = thePublishDate
    } else {
      let theErrorContext = DecodingError.Context(codingPath: [_ArticleKeys.publishedAt],
                                                  debugDescription: "Provided string cannot be converted to date")
      throw DecodingError.typeMismatch(Date.self, theErrorContext)
    }
  }

  private enum _ArticleKeys: String, CodingKey {
    case author
    case title
    case description
    case url
    case urlToImage
    case publishedAt
  }

}
