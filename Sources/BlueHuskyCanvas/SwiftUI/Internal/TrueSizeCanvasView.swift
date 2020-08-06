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



extension View {
    func frame(size: CGSize, alignment: Alignment? = nil) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
}



struct TrueSizeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        TrueSizeCanvasView(canvas: .debug)
    }
}
