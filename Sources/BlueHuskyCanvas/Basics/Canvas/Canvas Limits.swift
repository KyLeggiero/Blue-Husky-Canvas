//
//  Canvas Limits.swift
//  
//
//  Created by Ben Leggiero on 2020-02-16.
//

import Foundation
import RectangleTools



public extension Canvas {
    struct Limits {
        public var top: Limit
        public var right: Limit
        public var bottom: Limit
        public var left: Limit
        
        
        public init(top: Limit = .infinite,
                    right: Limit = .infinite,
                    bottom: Limit = .infinite,
                    left: Limit = .infinite)
        {
            self.top = top
            self.right = right
            self.bottom = bottom
            self.left = left
        }
    }
}



public extension Canvas.Limits {
    
    init(rectangle: CanvasRect) {
        self.init(
            top: .offset(pointsFromZero: rectangle.minY),
            right: .offset(pointsFromZero: rectangle.maxX),
            bottom: .offset(pointsFromZero: rectangle.minY),
            left: .offset(pointsFromZero: rectangle.minX)
        )
    }
    
    
    init(origin: CanvasPoint = .zero,
                size: CanvasSize) {
        self.init(rectangle: CanvasRect(origin: origin, size: size))
    }
    
    
    static let infinite = Self(top: .infinite, right: .infinite, bottom: .infinite, left: .infinite)
}



public extension Canvas {
    enum Limit {
        case offset(pointsFromZero: Length)
        case infinite
        
        
        
        public typealias Length = CGFloat
    }
}



extension Canvas.Limit: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Length.FloatLiteralType) {
        self = .offset(pointsFromZero: Length(floatLiteral: value))
    }
}



extension Canvas.Limit: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Length.IntegerLiteralType) {
        self = .offset(pointsFromZero: Length(integerLiteral: value))
    }
}
