//
//  BézierShape.swift
//  
//
//  Created by Ben Leggiero on 2020-02-15.
//

import Foundation



public typealias BezierShape = BézierShape



public struct BézierShape {
    var paths: [BézierPath]
}



public extension BézierShape {
    static let empty = BézierShape(paths: [])
}
