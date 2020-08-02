//
//  CanvasBackgroundView.swift
//  
//
//  Created by Ben Leggiero on 2020-07-26.
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
            Text("GRID: \("\(grid)")")
            
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
