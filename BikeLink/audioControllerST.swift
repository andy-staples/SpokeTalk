//
//  audioControllerST.swift
//  BikeLink
//
//  Created by Andy Staples on 4/4/15.
//  Copyright (c) 2015 Andy Staples. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation
//import CAXException
//import CAStreamBasicDescription

struct CallbackData {
    var rioUnit: AudioUnit
    //var bufferManager: BufferManager
    var dcRejectionFilter:DCRejectionFilterST
    var muteAudio: Bool
    var audioChainIsBeingReconstructed: Bool
}

class audioControllerST {
    init () {
        _rioUnit = AudioUnit()
        _dcRejectionFilter = DCRejectionFilterST()
        _audioPlayer = AVAudioPlayer()
        _audioChainIsBeingReconstructed = false
    }
    
    var _rioUnit:AudioUnit
    //var _bufferManager:BufferManager
    var _dcRejectionFilter:DCRejectionFilterST
    var _audioPlayer:AVAudioPlayer
    var _audioChainIsBeingReconstructed:Bool
}