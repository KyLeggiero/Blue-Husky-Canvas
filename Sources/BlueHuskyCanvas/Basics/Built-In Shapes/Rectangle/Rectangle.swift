//
//  Rectangle.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
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
