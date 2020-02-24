//
//  Canvas.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation



public struct Canvas {
    
    public var objects: [CanvasObject]
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
