//
//  MazeView.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import SwiftUI

struct MazeView: View {
    @StateObject private var maze: Maze
    
    init(map: Map) {
        self._maze = .init(wrappedValue: Maze(map: map, start: Point(x: 1, y: 1), target: Point(x: 8, y: 4)))
    }
    
    var body: some View {
        VStack {
            Text("\(MazeNode(point: Point(x: 0, y: 0)).distance(with: MazeNode(point: Point(x: 2, y: 6))))")
            MapView(maze: maze)
            Button("Solve") {
                if let path = maze.solve() {
                    path.forEach{ print($0) }
                }
            }
        }
    }
}

struct MazeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeView(map: Map.testMap)
    }
}
