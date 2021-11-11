//
//  Maze.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import Foundation

class Maze: ObservableObject {
    @Published var map: Map
    @Published var infos: [Point: MazeNode] = [:]
    
    private var lists: [MazeList: [MazeNode]]
    
    private var start: Point
    private var target: Point
    
    init(map: Map,
         start: Point,
         target: Point) {
        self.map = map
        self.start = start
        self.target = target
        self.lists = [:]
        MazeList.allCases.forEach { lists[$0] = [] }
    }
}

//MARK: Lists
extension Maze {
    enum MazeList: String, CaseIterable {
        case open, close
    }
    
    func insert(_ node: MazeNode, in list: MazeList) {
        lists[list]?.append(node)
        if list == .close,
           let indexOpen = lists[.open]?.firstIndex(of: node) {
            lists[.open]?.remove(at: indexOpen)
        }
    }
    
    func isEmpty(list: MazeList) -> Bool {
        lists[list]?.isEmpty ?? true
    }
    
    func found(_ node: MazeNode, in list: MazeList) -> MazeNode? {
        lists[list]?.first(where: { $0 == node })
    }
    
    func found(_ point: Point, in list: MazeList) -> MazeNode? {
        lists[list]?.first(where: { $0.point == point })
    }
    
    func update(_ node: MazeNode, with newNode: MazeNode, in list: MazeList) {
        if let index = lists[list]?.firstIndex(of: node) {
            lists[list]?[index] = newNode
        }
    }
    
    func display(list: MazeList) {
        if let list = lists[list] {
            list.forEach { mazeNode in
                print(mazeNode)
            }
        }
    }
}

extension Maze {
    func info(for point: Point) -> MazeNode? {
        infos[point]
    }
}

extension Maze {
    @discardableResult func solve() -> [MazeNode]? {
        var node = MazeNode.new(at: start, to: target)
        insert(node, in: .open)
        insert(node, in: .close)
        neighbours(for: node)
        while node.point != target && !isEmpty(list: .open) {
            guard let bestNode = bestNode(in: .open) else {
                break
            }
            node = bestNode
            insert(node, in: .close)
            neighbours(for: node)
        }
        if node.point == target {  return finalPath() }
        return nil
    }
    
    func neighbours(for node: MazeNode) {
        let distance = 1
        for x in node.point.x-distance...node.point.x+distance {
            if x < 0 || x > map.lineLenght { continue }
            for y in node.point.y-distance...node.point.y+distance {
                if y < 0 || y > map.lineHeight { continue }
                let point = Point(x: x, y: y)
                if point == node.point { continue }
                if map.box(for: point) == .wall { continue }
                if found(point, in: .close) != nil { continue }
                let newNode = MazeNode.new(with: node, at: point, to: target)
                if let existingNode = found(point, in: .open) {
                    if newNode < node {
                        update(node, with: existingNode, in: .open)
                    }
                }else{
                    insert(newNode, in: .open)
                }
            }
        }
    }
    
    func bestNode(in list: MazeList) -> MazeNode? {
        lists[list]?.min(by: {$0 < $1})
    }
    
    func finalPath() -> [MazeNode]? {
        guard let lastNode = lists[.close]?.last else { return nil }
        var path = [lastNode]
        while let parent = path.first?.parent  { path.insert(parent, at: 0) }
        path.forEach { mazeNode in
            infos[mazeNode.point] = mazeNode
        }
        return path
    }
}

extension Maze {
    static let test = Maze(map: Map.testMap, start: Point(x: 1, y: 1), target: Point(x: 3, y: 3))
}
