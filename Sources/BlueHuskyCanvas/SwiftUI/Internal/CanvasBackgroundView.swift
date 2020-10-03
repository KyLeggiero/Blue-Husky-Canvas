//
//  CanvasBackgroundView.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-07-26.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import SwiftUI



struct CanvasBackgroundView: View {
    
    @State
    var background: Canvas.Style.Background
    
    
    
    @ViewBuilder
    var body: some View {
        switch background {
        case .solid(color: let color):
            Color(color)
            
        case .grid(let grid):
            GridView(offset: .zero, grid: grid)
            
        case .custom(drawable: let drawable):
            Text("DRAWABLE: \("\(drawable)")")
        }
    }
}

struct CanvasBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasBackgroundView(background: .solid(color: .systemRed))
    }
}
