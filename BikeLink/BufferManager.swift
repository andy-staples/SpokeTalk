//
//  BufferManager.swift
//  BikeLink
//
//  Created by Andy Staples on 3/31/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation
import AudioToolbox


class BufferManager {
    
    var mDisplayMode:UInt32
    var mDrawBuffers:[Float32] = [Float32](count:12, repeatedValue: 0)
    var mDrawBufferIndex:UInt32
    var mCurrentDrawBufferLen:UInt32
    var mFFTInputBuffer:Float32
    var mFFTInputBufferFrameIndex:UInt32
    var mFFTInputBufferLen:UInt32
    var mHasNewFFTData:Int32
    var mNeedsNewFFTData:Int32
    
    var mFFTHelper:FFTHelper
    
    
    init(var inMaxFramesPerSlice:Int32)
    {
        //TODO
    }
    
    func copyAudioDataToDrawBuffer(inData:Float32, numFrames:UInt32)
    {
        //TODO
    }
    
    func CycleDrawBuffers()
    {
        //TODO
    }
    
    func hasNewFFTData() -> Bool
    {
        //return static_cast? mHasNewFFTData
        //TODO
        return true
    }
    
    func NeedsNewFFTData() -> Bool
    {
        //TODO
        return true
    }
    
    func CopyAudioDataToFFTInputBuffer(inData:Float32, numFrames:UInt32)
    {
        //Todo
    }
    
    func GetFFTOutputBufferLength() -> Int32
    {
        return mFFTInputBufferLen / 2
    }
    
    func GetFFTOutput( outFFTData:Float32)
    {
        //TODO
    }
}