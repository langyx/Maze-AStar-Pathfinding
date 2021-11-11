//
//  Sequence+Numbered.swift
//  MazProject
//
//  Created by Yannis Lang on 03/11/2021.
//

import Foundation

extension Sequence {
  /// Numbers the elements in `self`, starting with the specified number.
  /// - Returns: An array of (Int, Element) pairs.
  func numbered(startingAt start: Int = 0) -> [(number: Int, element: Element)] {
    Array(zip(start..., self))
  }
}
