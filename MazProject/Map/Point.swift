//
//  Point.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import Foundation

struct Point: Hashable {
    let x, y: Int
}

extension Point: CustomStringConvertible {
    var description: String {
        "\(Self.self) (\(x);\(y))"
    }
}

extension Point: Equatable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Point {
    func distance(with point: Point) -> Float {
        Float(
            sqrt(pow(Double(x - point.x), 2) + pow(Double(y - point.y), 2))
        )
    }
}

extension Point {
    static let zero = Point(x: 0, y: 0)
}
