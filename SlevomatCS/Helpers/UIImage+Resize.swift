//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension UIImage {

  func square(maxDimension aMaxDimension: CGFloat) -> UIImage {
    let theCurrentSize = self.size
    guard aMaxDimension < theCurrentSize.width || aMaxDimension < theCurrentSize.height else {
      return self
    }
    let theRatio = max(theCurrentSize.height, theCurrentSize.width) / aMaxDimension
    let theRoundingHelper = UIScreen.main.defaultRounding
    let theNewWidth = theRoundingHelper.round(value: theCurrentSize.width / theRatio)
    let theNewHeight = theRoundingHelper.round(value: theCurrentSize.height / theRatio)
    let theNewSize = CGSize(width: theNewWidth, height: theNewHeight)
    UIGraphicsBeginImageContextWithOptions(theNewSize, false, UIScreen.main.scale)
    draw(in: CGRect(origin: .zero, size: theNewSize))
    let theResult = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return theResult!
  }

}
