//
//  BézierPoint.swift
//  
//
//  Created by Ben Leggiero on 2020-02-15.
//

import Foundation



public struct BézierPoint {
    var precedingControlPointOffset: CGPoint?
    var anchor: CGPoint
    var succedingControlPointOffset: CGPoint?
}
