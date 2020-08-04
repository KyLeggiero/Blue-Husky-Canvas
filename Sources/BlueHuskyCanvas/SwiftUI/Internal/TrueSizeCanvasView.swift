//
//  TrueSizeCanvasView.swift
//  
//
//  Created by Ben Leggiero on 2020-07-26.
//

import SwiftUI

struct TrueSizeCanvasView: View {
    
    @State
    var canvas: Canvas
    
    
    
    var body: some View {
        CanvasBackgroundView(background: canvas.style.background)
            .frame(size: canvas.calculateSize())
    }
}

struct TrueSizeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        TrueSizeCanvasView(canvas: .debug)
    }
}
