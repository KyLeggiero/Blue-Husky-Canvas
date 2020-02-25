//
//  CircleCanvasObject.swift
//  
//
//  Created by Ben Leggiero on 2020-02-24.
//

import Foundation



/// The `CanvasObject` version of a `Circle`
public typealias CircleCanvasObject = GenericizedCanvasObject<Circle>



public extension CircleCanvasObject {
    
    /// The circle that this canvas object represents
    var circle: Circle {
        get { base }
        set { base = newValue }
    }
}
