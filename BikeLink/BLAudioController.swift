//
//  BLAudioController.swift
//  BikeLink
//
//  Created by Andy Staples on 3/31/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation



static func performRender (*inRefCon, ioActionFlags:AudioUnitRenderActionFlags, inTimeStamp: AudioTimeStamp, inBusNumber: UInt32, inNumberFrames: UInt32, ioData: AudioBufferList)
{
    var err:OSStatus = noErr
    if(*cd.audioChainIsBeingReconstructed == false)
    {
        
    }
}

@interface

class BLAudioController : NSObject
{
    var _rioUnit: AudioUnit
    var _bufferManager: BufferManager
    var _dcRejectionFilter: DCRejectionFilter
    var _audioPlayer: AVAudioPlayer
    var _audioChainIsBeingReconstructed: Bool

    
}