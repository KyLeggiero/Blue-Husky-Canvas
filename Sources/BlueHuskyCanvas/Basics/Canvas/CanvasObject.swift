//
//  CanvasObject.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation



public protocol CanvasObject: Drawable {
    var bézierShape: BézierShape { get }
    var aspectRatioLock: CGSize { get }
    var style: Style { get }
    var position: CGRect { get }
}



public protocol MutableCanvasObject: CanvasObject {
    var bézierShape: BézierShape { get set }
    var aspectRatioLock: CGSize { get set }
    var style: Style { get set }
    var position: CGRect { get set }
}
