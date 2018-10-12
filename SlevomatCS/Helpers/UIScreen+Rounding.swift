//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension UIScreen {

  var defaultRounding: RoundingHelper<CGFloat> {
    return RoundingHelper(scale: self.scale)
  }

}
