//
// Created by Jan Kase on 28/03/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

/// Helper providing rounding for floating type values
public struct RoundingHelper<T: FloatingPoint> {

  /// standard scale used for rounding
  public var scale: T = 1

  /// value multiplier used during rounding
  public var multiplier: T = 1

  /**

  Default constructor

  - parameter scale: Scale used during rounding operations

  */
  public init(scale aScale: T) {
    scale = aScale
  }

  /**

  Ceil `value`.

  - parameter value: Value to ceil
  - Returns: Ceiled value

  */
  public func ceil(value aSource: T) -> T {
    return transform(value: aSource, byRule: .up)
  }

  /**

  Floor `value`.

  - parameter value: Value to floor
  - Returns: Floored value

  */
  public func floor(value aSource: T) -> T {
    return transform(value: aSource, byRule: .down)
  }

  /**

  Round `value`.

  - parameter value: Value to round
  - Returns: Rounded value

  */
  public func round(value aSource: T) -> T {
    return transform(value: aSource, byRule: .toNearestOrAwayFromZero)
  }

  /**

  Transform provided `value` by rule specified in `byRule`.

  - Parameters:
    - value: Value to transform
    - byRule: Specify rounding operations

  - Returns: Transformed input value

  */
  public func transform(value aSource: T, byRule aRule: FloatingPointRoundingRule) -> T {
    return (aSource * scale * multiplier).rounded(aRule) / scale
  }

}