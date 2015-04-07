//
//  BufferManagerST.swift
//  BikeLink
//
//  Created by Andy Staples on 4/4/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation

class BufferManagerST
{
    var mDisplayMode:UInt32
    var mDrawBuffers : [Float32]
    var mDrawBufferIndex:UInt32
    var mCurrentDrawBufferLen:UInt32
    var mFFTInputBuffer : Float32
    var mFFTInputBufferFrameIndex:UInt32
    var mFFTInputBufferLen:UInt32
    var mHasNewFFTData : Int32?
    var mNeedsNewFFTData : Int32?
    var mFFTHelper : FFTHelper
    
    init (inMaxFramesPerSlice : Uint32)
    {
        //TODO
    }
    
    func CopyAudioDataToDrawBuffer( inData: Float32*, numFrames:UInt32)
    {
        //TODO
    }
    
    func CycleDrawBuffers()
    {
        
    }
    
    func HasNewFFTData() -> Bool
    {
        return (mHasNewFFTData) != nil

    }
    
    func NeedsNewFFTData() -> Bool
    {
        return (mHasNewFFTData) != nil
    }
    
    func CopyAudioDataToFFTInputBuffer (inData: Float32, numFrames: UInt32)
    {
        //TODO
    }
    
    func GetFFTOutputBufferLength() -> UInt32 {
        var temp = mFFTInputBufferLen / 2
        return temp
    }

    func GetFFTOutput (outFFTData : Float32)
    {
        //TODO
    }
}