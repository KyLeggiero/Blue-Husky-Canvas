//
//  GridView.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-08-02.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import SwiftUI



public struct GridView: View {
    
    @State
    var offset: CanvasPoint = .zero
    
    @State
    var grid: Grid
    
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
//                path.move(to: CGPoint.zero)
//                path.line(to: CGPoint(x: 0, y: geometry.size.height))
                
                stride(from: offset.x.truncatingRemainder(dividingBy: grid.spacing.width),
                       to: geometry.size.width,
                       by: grid.spacing.width)
                    .forEach { x in
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                    }
                
                stride(from: offset.y.truncatingRemainder(dividingBy: grid.spacing.height),
                       to: geometry.size.height,
                       by: grid.spacing.height)
                    .forEach { y in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
            }
            .stroke(Color(grid.linesColor), lineWidth: 1)
        }
    }
}
