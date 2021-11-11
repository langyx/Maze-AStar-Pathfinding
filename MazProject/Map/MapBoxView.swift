//
//  MapBoxView.swift
//  MazProject
//
//  Created by Yannis Lang on 31/10/2021.
//

import SwiftUI

struct MapBoxView: View {
    let box: Map.Box
    var border = true
    
    private var color: Color {
        switch box {
        case .empty:
            return .gray.opacity(0.5)
        default:
            return .black
        }
    }
    var body: some View {
        color
            .border(Color.black, width: CGFloat(border ? 2 : 0))
            .aspectRatio(contentMode: .fit)
    }
}

struct MapBoxView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0){
            MapBoxView(box: .empty)
            MapBoxView(box: .wall)
        }
        .padding()
    }
}
