//
//  RectangleCanvasObject.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-24.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



/// The `CanvasObject` version of a `Rectangle`
public typealias RectangleCanvasObject = GenericizedCanvasObject<Rectangle>



public extension RectangleCanvasObject {
    
    /// The rectangle that this canvas object represents
    var rectangle: Rectangle {
        get { base }
        set { base = newValue }
    }
}
