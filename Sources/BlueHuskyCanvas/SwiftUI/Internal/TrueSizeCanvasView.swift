//
//  TrueSizeCanvasView.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-07-26.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import SwiftUI



/// A view of the canvas, restricted to always be at its full size. Other views can scroll andor zoom this one.
struct TrueSizeCanvasView: View {
    
    @State
    var canvas: Canvas
    
    
    
    var body: some View {
        CanvasBackgroundView(background: canvas.style.background)
            .frame(size: canvas.calculateContentFrame().size)
    }
}



extension View {
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
}



struct TrueSizeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        TrueSizeCanvasView(canvas: .debug)
    }
}
