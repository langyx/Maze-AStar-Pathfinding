//
//  MapBoxInfoView.swift
//  MazProject
//
//  Created by Yannis Lang on 03/11/2021.
//

import SwiftUI

struct MapBoxInfoView: View {
    let node: MazeNode
    
    var color: Color {
        if node.parent == nil {
            return .green
        }
        return .blue
    }
    
    var body: some View {
        color
            .overlay(
                Text("\(node.point.y);\(node.point.x)")
                .foregroundColor(.white)
                .font(.caption)
        )
    }
}

struct MapBoxInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MapBoxInfoView(node: MazeNode(point: .zero, gCost: 10, hCost: 10))
    }
}
