//
//  Color + Drawable.swift
//  
//
//  Created by Ben Leggiero on 2020-02-17.
//

import Foundation
import ColorSwatches
import CrossKitTypes



extension NativeColor: Drawable {
    public func draw(in context: CGContext, targetSize: CGSize, environment: Environment) {
        context.draw(swatch(size: targetSize).cgImage()!, in: CGRect(origin: .zero, size: targetSize))
    }
}



extension NativeImage {
    func cgImage() -> CGImage? {
        var rect = CGRect(origin: .zero, size: size)
        return cgImage(forProposedRect: &rect, context: nil, hints: nil)
    }
}
