//
//  FFTHelperST.swift
//  BikeLink
//
//  Created by Andy Staples on 4/6/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation
import Accelerate

class FFTHelperST {
    var mSpectrumanalysis : FFTSetup
    var mDspSplitComplex : DSPSplitComplex
    var mFFTNormFactor: Float32
    var mFFTLength : UInt32
    var mLog2N : UInt32
    
    init (inMaxFramesPerSlice: UInt32)
    {
        //TODO
    }
    
    func ComputeFFT (inAudioData:Float32?, outFFTData: Float32?)
    {
        if (inAudioData == nil || outFFTData == nil) {
            return
        }
        vDSP_ctoz(inAudioData, 2, mDspSplitComplex, 1, mFFTLength)
        vDSP_ctoz(<#__vDSP_C: UnsafePointer<DSPComplex>#>, <#__vDSP_IC: vDSP_Stride#>, <#__vDSP_Z: UnsafePointer<DSPSplitComplex>#>, <#__vDSP_IZ: vDSP_Stride#>, <#__vDSP_N: vDSP_Length#>)
    }
}