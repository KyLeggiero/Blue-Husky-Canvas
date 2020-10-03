//
//  CanvasView.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-07-26.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import SwiftUI



public struct CanvasView: View {
    
    @State
    var canvas: Canvas
    
    
    public init(canvas: Canvas) {
        self._canvas = .init(wrappedValue: canvas)
    }
    
    
    public var body: some View {
        ScrollView {
            TrueSizeCanvasView(canvas: canvas)
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(canvas: .debug)
    }
}
