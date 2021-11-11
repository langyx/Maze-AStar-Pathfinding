//
//  MapView.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var maze: Maze
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(maze.map.boxs.numbered(), id: \.0) { y, mapLine in
                HStack(spacing: 0) {
                    ForEach(mapLine.numbered(), id: \.0) { x, box in
                        MapBoxView(box: box)
                            .overlay(mapBoxOverlay(x: x, y: y))
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension MapView {
    func mapBoxOverlay(x: Int, y: Int) -> some View {
        Group {
            if let node = maze.info(for: Point(x: x, y: y)) {
                MapBoxInfoView(node: node)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(maze: .test)
    }
}
