//
//  FFTHelper.swift
//  BikeLink
//
//  Created by Andy Staples on 3/31/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation
import Accelerate

class FFTHelper {
    var mSpectrumAnalysis:FFTSetup
    var mDspSplitcomplex:DSPSplitComplex
    var mFFTNormFactor:Float32
    var mFFTLength:UInt32
    var mLog2N:UInt32
    
    init(inMaxFramesPerSlice:UInt32)
    {
        //TODO
    }
    
    func ComputeFFT (inAudioData:Float32, outFFTData:Float32)
    {
        
    }
}