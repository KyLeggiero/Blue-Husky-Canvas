//
//  CanvasObject Style.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation
import CrossKitTypes
import NonEmpty



public extension CanvasObject {
    typealias Style = CanvasObjectStyle
}



public struct CanvasObjectStyle {
    var fill: Fill?
    var stroke: Stroke?
//    var shadow: Shadow?
}



public extension CanvasObjectStyle {
    struct Fill {
        var content: Content
        var approach: Approach
    }
}



public extension CanvasObjectStyle.Fill {
    enum Content {
        case solid(color: NativeColor)
//        case image(image: NativeImage)
//        case linearGradient(gradient: LinearGradient)
//        case radialGradient(gradeitn: RadialGradient)
//        case custom(drawable: Drawable)
    }
}



public extension CanvasObjectStyle.Fill {
    enum Approach {
        case always
        case evenOdd
    }
}



public extension CanvasObjectStyle {
    struct Stroke {
        var style: Style
        var content: Fill.Content
        var thickness: CGFloat
    }
}



public extension CanvasObjectStyle.Stroke {
    enum Style {
        case solid
        case dashed(phases: NonEmptyArray<DashPhase>)
        case dotted(gaps: NonEmptyArray<CGFloat>)
    }
}



public extension CanvasObjectStyle.Stroke {
    struct DashPhase {
        var precedingGap: CGFloat
        var solidLength: CGFloat
    }
}



public extension CanvasObjectStyle {
    struct Shadow {
        var color: NativeColor
        var offset: CanvasPoint
        var blur: CGFloat
    }
}
