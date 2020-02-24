//
//  Grid.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation
import CrossKitTypes



public struct Grid {
    public var spacing: CGSize
    public var background: Drawable
    public var linesColor: NativeColor
}



public extension Grid {
    init(square each: CGFloat,
         background: Drawable,
         linesColor: NativeColor)
    {
        self.init(spacing: CGSize(width: each, height: each),
                  background: background,
                  linesColor: linesColor)
    }
}
