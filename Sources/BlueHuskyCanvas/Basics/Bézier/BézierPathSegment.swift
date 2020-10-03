//
//  BézierPathSegment.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-08-02.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation
import CoreGraphics.CGBase
import BasicMathTools
import RectangleTools



public struct BézierPathSegment {
    let firstPoint: BézierPoint
    let secondPoint: BézierPoint
}



public extension BézierPathSegment {
    
    @inline(__always)
    var xyPoints: XyPoints {(
        x0: firstPoint.anchor.x, y0: firstPoint.anchor.y,
        x1: firstPoint.succedingControlPointOrAnchor.x, y1: firstPoint.succedingControlPointOrAnchor.y,
        x2: secondPoint.precedingControlPointOrAnchor.x, y2: secondPoint.precedingControlPointOrAnchor.y,
        x3: secondPoint.anchor.x, y3: secondPoint.anchor.y
    )}
    
    
    func calculateFrame() -> CanvasRect {
        let (x0, y0, x1, y1, x2, y2, x3, y3) = self.xyPoints
        
        var tvalues = [CGFloat]()
        var bounds = ([CGFloat](), [CGFloat]())
        var points = [CGPoint]()
        
        var a: CGFloat! = nil
//        var v: CGFloat! = nil
        var b: CGFloat! = nil
        var c: CGFloat! = nil
        var t: CGFloat! = nil
        var t1: CGFloat! = nil
        var t2: CGFloat! = nil
        var b2ac: CGFloat! = nil
        var sqrtb2ac: CGFloat! = nil
        
        for isFirstPass in [true, false] { // (var i = 0; i < 2; ++i)
            if isFirstPass {
                // TODO: Parenthesize
                b = 6 * x0 - 12 * x1 + 6 * x2
                a = -3 * x0 + 9 * x1 - 9 * x2 + 3 * x3
                c = 3 * x1 - 3 * x0
            }
            else {
                b = 6 * y0 - 12 * y1 + 6 * y2
                a = -3 * y0 + 9 * y1 - 9 * y2 + 3 * y3
                c = 3 * y1 - 3 * y0
            }
            
            if a ~== 0 {
                if b ~== 0 {
                    continue
                }
                
                t = -c / b
                
                if 0 < t, t < 1 {
                    tvalues.append(t)
                }
                
                continue
            }
            
            b2ac = b * b - 4 * c * a
            sqrtb2ac = sqrt(b2ac)
            
            if b2ac < 0 {
                continue
            }
            
            t1 = (-b + sqrtb2ac) / (2 * a)
            
            if 0 < t1, t1 < 1 {
                tvalues.append(t1)
            }
            
            t2 = (-b - sqrtb2ac) / (2 * a)
            
            if 0 < t2, t2 < 1 {
                tvalues.append(t2)
            }
        }
        
        var x: CGFloat
        var y: CGFloat
        let jlen = tvalues.count // j
        var mt: CGFloat
        
//        var j = tvalues.count
//        while (j--)
        for j in (1...jlen).reversed() {
            t = tvalues[j]
            mt = 1 - t
            x = (mt * mt * mt * x0) + (3 * mt * mt * t * x1) + (3 * mt * t * t * x2) + (t * t * t * x3)
            bounds.0[j] = x
            
            y = (mt * mt * mt * y0) + (3 * mt * mt * t * y1) + (3 * mt * t * t * y2) + (t * t * t * y3)
            bounds.1[j] = y
            points[j] = .init(
                x: x,
                y: y
            )
        }
        
        tvalues[jlen] = 0
        tvalues[jlen + 1] = 1
        points[jlen] = .init(
            x: x0,
            y: y0
        )
        points[jlen + 1] = .init(
            x: x3,
            y: y3
        )
        bounds.0[jlen] = x0
        bounds.1[jlen] = y0
        bounds.0[jlen + 1] = x3
        bounds.1[jlen + 1] = y3
        
        let newArraySize = jlen + 2
        tvalues  = Array(tvalues .onlyFirst(newArraySize))
        bounds.0 = Array(bounds.0.onlyFirst(newArraySize))
        bounds.1 = Array(bounds.1.onlyFirst(newArraySize))
        points   = Array(points  .onlyFirst(newArraySize))
        
        return .init(
            minX: bounds.0.min() ?? 0,
            minY: bounds.1.max() ?? 0,
            maxX: bounds.0.max() ?? 0,
            maxY: bounds.1.min() ?? 0
        )
//        return {
//            left: min.apply(null, bounds[0]),
//            top: min.apply(null, bounds[1]),
//            right: max.apply(null, bounds[0]),
//            bottom: max.apply(null, bounds[1]),
//            points: points, // local extremes
//            tvalues: tvalues // t values of local extremes
//        };
    }
    
    
    
    typealias XyPoints = (
        x0: CanvasLength, y0: CanvasLength,
        x1: CanvasLength, y1: CanvasLength,
        x2: CanvasLength, y2: CanvasLength,
        x3: CanvasLength, y3: CanvasLength
    )
}



//func getBoundsOfCurve (x0, y0, x1, y1, x2, y2, x3, y3)
//{
//    var tvalues = new Array();
//    var bounds = [new Array(), new Array()];
//    var points = new Array();
//
//    var a,b,c,t,t1,t2,b2ac,sqrtb2ac;
//    for (var i = 0; i < 2; ++i)
//    {
//        if (i==0)
//        {
//            b = 6 * x0 - 12 * x1 + 6 * x2;
//            a = -3 * x0 + 9 * x1 - 9 * x2 + 3 * x3;
//            c = 3 * x1 - 3 * x0;
//        }
//        else
//        {
//            b = 6 * y0 - 12 * y1 + 6 * y2;
//            a = -3 * y0 + 9 * y1 - 9 * y2 + 3 * y3;
//            c = 3 * y1 - 3 * y0;
//        }
//
//        if (abs(a) < 1e-12) // Numerical robustness
//        {
//            if (abs(b) < 1e-12) // Numerical robustness
//            {
//                continue;
//            }
//            t = -c / b;
//            if (0 < t && t < 1)
//            {
//                tvalues.push(t);
//            }
//            continue;
//        }
//        b2ac = b*b - 4 * c * a;
//        sqrtb2ac = sqrt(b2ac);
//        if (b2ac < 0)
//        {
//            continue;
//        }
//        t1 = (-b + sqrtb2ac) / (2 * a);
//        if (0 < t1 && t1 < 1)
//        {
//            tvalues.push(t1);
//        }
//        t2 = (-b - sqrtb2ac) / (2 * a);
//        if (0 < t2 && t2 < 1)
//        {
//            tvalues.push(t2);
//        }
//    }
//
//    var x, y, j = tvalues.length, jlen = j, mt;
//    while(j--)
//    {
//        t = tvalues[j];
//        mt = 1-t;
//        x = (mt*mt*mt*x0) + (3*mt*mt*t*x1) + (3*mt*t*t*x2) + (t*t*t*x3);
//        bounds[0][j] = x;
//
//        y = (mt*mt*mt*y0) + (3*mt*mt*t*y1) + (3*mt*t*t*y2) + (t*t*t*y3);
//        bounds[1][j] = y;
//        points[j] = {X: x, Y: y};
//    }
//
//    tvalues[jlen] = 0;
//    tvalues[jlen+1] = 1;
//    points[jlen] = {X: x0, Y:y0};
//    points[jlen+1] = {X: x3, Y:y3};
//    bounds[0][jlen] = x0;
//    bounds[1][jlen] = y0;
//    bounds[0][jlen+1] = x3;
//    bounds[1][jlen+1] = y3;
//    tvalues.length = bounds[0].length = bounds[1].length = points.length = jlen+2;
//
//    return {
//        left: min.apply(null, bounds[0]),
//        top: min.apply(null, bounds[1]),
//        right: max.apply(null, bounds[0]),
//        bottom: max.apply(null, bounds[1]),
//        points: points, // local extremes
//        tvalues: tvalues // t values of local extremes
//    };
//};


//function getBoundsOfPath (path)
//{
//    //var curve = path2curve(path);
//    curve = path;
//    ////console.log(JSON.stringify(path));
//    ////console.log("--------------------------------------------------------------------");
//    //console.log(JSON.stringify(curve));
//    var bounds, s, startX, startY,
//        minx = Number.MAX_VALUE,
//        miny = Number.MAX_VALUE,
//        maxx = Number.MIN_VALUE,
//        maxy = Number.MIN_VALUE;
//    var isC = false;
//    for (var i = 0, ilen = curve.length; i < ilen; i++)
//    {
//        //var val = 6;
//        //if(i!=val && i!=val-1) continue;
//        var s = curve[i];
//        ////console.log(s);
//
//        if (s[0] == 'M')
//        {
//            if (typeof(curve[i+1]) != "undefined" && curve[i+1][0] == "C")
//            {
//                startX = s[1];
//                startY = s[2];
//                if (startX < minx) minx = startX;
//                if (startX > maxx) maxx = startX;
//                if (startY < miny) miny = startY;
//                if (startY > maxy) maxy = startY;
//            }
//        }
//        else
//
//        if (s[0] == 'C')
//        {
//            isC = true;
//            //if(i==val)
//            //{
//            bounds = getBoundsOfCurve(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
//            //bounds = calculate_standard_bbox(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
//            //bounds = cubic_extrema_external(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
//
//            ////console.log(JSON.stringify(bounds));
//            if (bounds.left < minx) minx = bounds.left;
//            if (bounds.right > maxx) maxx = bounds.right;
//            if (bounds.top < miny) miny = bounds.top;
//            if (bounds.bottom > maxy) maxy = bounds.bottom;
//            startX = s[5];
//            startY = s[6];
//        }
//        ////console.log(JSON.stringify(bounds));
//        //if(s[0] == 'C')
//        //{
//        //  currentX = s[5], currentY = s[6];
//        //}
//
//    }
//    //    left: this.left + (minX + deltaX / 2),
//    //          top: this.top + (minY + deltaY / 2),
//
//    if (!isC) minx = maxx = miny = maxy = 0;
//
//    var boundsFinal = {
//        left: minx,
//        top: miny,
//        width: maxx - minx,
//        height: maxy - miny
//    };
//    ////console.log(JSON.stringify(boundsFinal));
//    return boundsFinal;
//}
//window.getBoundsOfPath = getBoundsOfPath;
//window.getBoundsOfCurve = getBoundsOfCurve;

//// DRAW SECTION
//function original_data_arr_to_path (arr)
//{
//    // M366,75C59,40,59,40,366,75
//    var str="M"+arr[0]+","+arr[1];
//    str+="C"+arr[2]+",";
//    str+=arr[3]+",";
//    str+=arr[4]+",";
//    str+=arr[5]+",";
//    str+=arr[6]+",";
//    str+=arr[7]+",";
//    return str;
//}
//
//function newdata_arr_to_path (arr)
//{
//    var str="";
//    for(var i=0,m=arr.length;i<m;i++)
//    {
//        str+=i?"L":"M";
//        str+=arr[i].X+","+arr[i].Y;
//    }
//    return str;
//}
//
//var w = 1200, h=11200;
//var R = Raphael("containerDiv",w,h);
//R.canvas.setAttribute("id", "p");
////Raphael.parsePathString("M193,169C200,5,200,210,26,74Z");
//var d;
//var b; // bounds
//var p; // path
//for(i=0;i<data1.length;i++)
//{
//    d = data1[i];
//    d = Raphael.parsePathString(d);
//    d = Raphael._pathToAbsolute(d);
//    p = d;
//    b = getBoundsOfCurve(
//        p[0][1],
//        p[0][2],
//        p[1][1],
//        p[1][2],
//        p[1][3],
//        p[1][4],
//        p[1][5],
//        p[1][6]);
//    R.rect(b.left,b.top,b.right-b.left,b.bottom-b.top).attr("stroke", "red").attr("fill","red").attr("stroke-opacity",0.5).attr("fill-opacity",0.1);
//    R.path(d);
//
//    for(j=0;j<b.points.length;j++)
//    {
//        R.circle(b.points[j].X,b.points[j].Y, 5).attr("stroke", "red").attr("fill","red").attr("stroke-opacity",0.5).attr("fill-opacity",0.1);
//    }
//}


