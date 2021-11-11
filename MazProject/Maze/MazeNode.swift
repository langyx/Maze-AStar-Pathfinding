//
//  MazeNode.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import Foundation

class MazeNode {
    let point: Point
    let gCost: Float
    let hCost: Float
    var fCost: Float { gCost + hCost }
    var parent: MazeNode?
    
    init(point: Point = Point(x: 0, y: 0),
         gCost: Float = 0,
         hCost: Float = 0,
         parent: MazeNode? = nil) {
        self.point = point
        self.gCost = gCost
        self.hCost = hCost
        self.parent = parent
    }
}

extension MazeNode: CustomStringConvertible {
    var description: String {
        "MazeNode \(point) G=\(gCost) H=\(hCost)"
    }
}

extension MazeNode: Equatable {
    static func == (lhs: MazeNode, rhs: MazeNode) -> Bool {
        lhs.point == rhs.point
    }
}

extension MazeNode: Comparable {
    static func < (lhs: MazeNode, rhs: MazeNode) -> Bool {
        lhs.fCost < rhs.fCost
    }
}

extension MazeNode {
    func distance(with node: MazeNode) -> Float {
        point.distance(with: node.point)
    }
}

extension MazeNode {
    static func new(with parent: MazeNode? = nil,
                    at point: Point,
                    to target: Point) -> MazeNode {
        let gCost: Float = parent != nil ? parent!.gCost + parent!.point.distance(with: point) : 0
        let hCost = point.distance(with: target)
        return MazeNode(point: point, gCost: gCost, hCost: hCost, parent: parent)
    }
}
