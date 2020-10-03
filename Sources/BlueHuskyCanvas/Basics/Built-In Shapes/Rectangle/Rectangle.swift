//
//  Rectangle.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-21.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



/// Represents a rectangle
public struct Rectangle {
    
    /// The size of the rectangle
    public var size: CanvasSize
    
    
    public init(size: CanvasSize) {
        self.size = size
    }
}
