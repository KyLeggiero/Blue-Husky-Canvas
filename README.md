# Blue Husky Canvas #

A works-out-of-the-box canvas editor widget. 



## Code Hierarchy ##

The canvas is broken out as such:

- `Canvas` is the data structure representing a canvas. It can function as a complete view model. 
    - `CanvasObject` and `MutableCanvasObject` are protocols to which any object on the canvas must conform in order to appear on the canvas.
- `CanvasPoint` is a single 2D point on the canvas
    - `BézierPoint` is a point along a [Bézier curve](https://en.wikipedia.org/wiki/Bézier_curve), defined as one `CanvasPoint` anchor, and optionally two `CanvasPoint` control points. This can't be drawn on the canvas without being in a `BézierPath`
            - `BézierPath` is a series of `BézierPoint`s, connected by default but allowing gaps. This can't be drawn on the canvas without being in a `BézierShape`
                - `BézierShape` is one or more `BézierPath`s, plus their styling (fill, stroke, etc.). If one path intersects itself and has a fill, it can be filled even-odd or always. If two paths intersect, their paths are combined using union, intersection, subtract, or xor.  
- `Drawable` defines something that can be drawn on the canvas. For instance, a `BézierShape` is `Drawable`, but so is its fill. In fact, one shape can be used as the fill for another!
    - `BézierShape`s, images, and colors already conform to `Drawable`
