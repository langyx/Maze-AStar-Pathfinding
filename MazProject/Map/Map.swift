//
//  Map.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import Foundation

struct Map {
    let boxs: [[Box]]
    let lineLenght: Int
    var lineHeight:Int {
        boxs.count
    }
    
    init(_ data: String) {
        (boxs, lineLenght) = Map.parse(from: data)
    }
}

extension Map {
    static func parse(from data: String) -> ([[Box]], Int) {
        let boxs = data.lines.map { line in
            line.map { Box(rawValue: Int(String($0)) ?? Box.empty.rawValue)! }
        }
        let max = boxs.max(by: { (a, b) -> Bool in
            return a.count < b.count
        })
        .map { $0.count } ?? 0
        return (boxs.map { boxLine -> [Box] in
            let lengthDiff = max - boxLine.count
            return boxLine + (lengthDiff > 0 ? [Box](repeating: Box(rawValue: Box.wall.rawValue)!, count: lengthDiff) : [])
        }, max)
    }
}

extension Map {
    enum Box: Int {
        case empty, wall
    }
    
    func box(for point: Point) -> Box? {
        boxs[safe: point.y]?[safe: point.x]
    }
}

extension Map {
    static var dataTestMap = """
        1111111111111111
        1000000000000001
        1001111111010001
        1001000000000001
        1001000000000001
        1001000000000001
        1001000000000001
        1001000000000001
        1000000000000001
        1111111111111111
        """
    static var testMap = Map(Map.dataTestMap)
}
