//
//  StringProtocol+lines.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import Foundation

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
