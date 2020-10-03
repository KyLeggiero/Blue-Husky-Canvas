//
//  Canvas.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



/// The model of a canvas
public struct Canvas {
    
    /// The objects on the canvas
    public var objects: [CanvasObject]
    
    /// How far the canvas goes in any given direction
    public var limits: Limits
    public var style: Style
    
    
    
    public init(objects: [CanvasObject] = [],
                limits: Limits,
                style: Style = .default) {
        self.objects = objects
        self.limits = limits
        self.style = style
    }
}



public extension Canvas {
    func calculateContentFrame() -> CanvasRect {
        objects
            .lazy
            .map { $0.calculateFrame() }
            .grandUnion()
            ?? .init(origin: .zero, size: .zero)
    }
}



#if DEBUG
internal extension Canvas {
    static let debug = Canvas(
        objects: [
            CircleCanvasObject(
                base: Circle(
//                            center: .init(x: 10, y: 20),
                    radius: 15),
                lock: .total,
                style: CanvasObjectStyle(
                    fill: .init(
                        content: .solid(color: .brown),
                        approach: .always),
                    stroke: .init(
                        style: .solid,
                        content: .solid(color: .green),
                        thickness: 4)),
                position: .init(x: 10, y: 20))
        ],
        limits: .init(size: .init(width: 30, height: 30)),
        style: .init(background: .solid(color: .gray))
    )
}
#endif
