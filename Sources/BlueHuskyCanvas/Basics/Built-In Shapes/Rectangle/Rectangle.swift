//
//  Rectangle.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



/// Represents a rectangle
public struct Rectangle {
    /// The coordinates of the rectangle
    public var coordinates: CanvasRect
    
    
    public init(coordinates: CanvasRect) {
        self.coordinates = coordinates
    }
}
