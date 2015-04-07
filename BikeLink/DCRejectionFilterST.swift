//
//  DCRejectionFilterST.swift
//  BikeLink
//
//  Created by Andy Staples on 4/4/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation



class DCRejectionFilterST {
    
    var mY1 : Float32
    var mX1 : Float32
    var kDefaultPoleDist: Float32
    
    init()
    {
        kDefaultPoleDist = .975
        mY1 = 0
        mX1 = 0
    }
    
    func ProcessInplace (ioData:[Float32], numFrames:UInt32) -> [Float32]
    {
        var toReturn : [Float32] = []
        var numFramesI = Int(numFrames);
        for var i = 0; i < numFramesI; i++ {
            // ia = i.value
            var xCurr : Float32 = ioData[i]
            var val : Float32 = ioData[i] - mX1 + (kDefaultPoleDist * mY1)
            toReturn[i] = val
            mX1 = xCurr
            mY1 = ioData[i]
        }
        return toReturn
    }
}