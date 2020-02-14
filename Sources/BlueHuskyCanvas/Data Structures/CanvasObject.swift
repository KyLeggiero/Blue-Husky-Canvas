//
//  CanvasObject.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation



public protocol CanvasObject {
    var bézierShape: BézierShape { get }
    var aspectRatioLock: CGSize { get }
    var style: Style
}
