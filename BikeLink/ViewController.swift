//
//  ViewController.swift
//  BikeLink
//
//  Created by Andy Staples on 11/30/14.
//  Copyright (c) 2014 Andy Staples. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth;
import AVFoundation
import MediaPlayer
import CoreAudioKit
import CoreMIDI
import AudioToolbox
//import AudioController

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralManagerDelegate, CBPeripheralDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var items: [String] = ["We", "Heart", "Swift"]

    var pManager = CBPeripheralManager()
    var cManager = CBCentralManager()
    var discoveredPeripheral:CBPeripheral?
    
    var audioPlayer:AVAudioPlayer?
    var audioRecorder:AVAudioRecorder?
    let SpokeTalkUUID = CBUUID(string: "92924593-B715-46D0-8ACA-B3492D056B1F")
    let A2DPUUID = CBUUID(string: "0x110A")
    
    var secondWindow = UIWindow()
    
    @IBOutlet weak var sensorData: UITextView!
    
    @IBOutlet weak var periphSensorData: UITextView!
    
    @IBOutlet weak var otherData: UITextView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        //cell.textLabel.text = self.items[indexPath.row]
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        switch cManager.state {
            
        case .PoweredOff:
            println("CoreBluetooth BLE hardware is powered off")
            break
        case .PoweredOn:
            println("CoreBluetooth BLE hardware is powered on and ready")
            // We can now call scanForBeacons
            //self.scanForBeacons(self)
            break
        case .Resetting:
            println("CoreBluetooth BLE hardware is resetting")
            break
        case .Unauthorized:
            println("CoreBluetooth BLE state is unauthorized")
            break
        case .Unknown:
            println("CoreBluetooth BLE state is unknown")
            break
        case .Unsupported:
            println("CoreBluetooth BLE hardware is unsupported on this platform")
            break
            
        default:
            break
        }
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        
        switch pManager.state {
            
        case .PoweredOff:
            println("Peripheral - CoreBluetooth BLE hardware is powered off")
            break
            
        case .PoweredOn:
            println("Peripheral - CoreBluetooth BLE hardware is powered on and ready")
            let AUValue = NSData(bytes: "AUDATA", length: 6)
            let STValue = NSData(bytes: "STDATA", length: 6)
            var AUCharacteristic = CBMutableCharacteristic(type: A2DPUUID, properties: CBCharacteristicProperties.Read, value: AUValue, permissions: CBAttributePermissions.Readable)
            var STCharacteristic = CBMutableCharacteristic(type: SpokeTalkUUID, properties: CBCharacteristicProperties.Read, value:   STValue, permissions: CBAttributePermissions.Readable)
            var AUService = CBMutableService(type: A2DPUUID, primary: true)
            var STService =  CBMutableService(type: SpokeTalkUUID, primary: false)
            STService.characteristics = [STCharacteristic]
            AUService.characteristics = [AUCharacteristic]
            pManager.addService(AUService)
            pManager.addService(STService)
            
            pManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[SpokeTalkUUID]])
            println("Now advertising service: \(SpokeTalkUUID) + ")//\(A2DPUUID)
            
            break
            
        case .Resetting:
            println("Peripheral - CoreBluetooth BLE hardware is resetting")
            break
            
        case .Unauthorized:
            println("Peripheral - CoreBluetooth BLE state is unauthorized")
            break
            
        case .Unknown:
            println("Peripheral - CoreBluetooth BLE state is unknown")
            break
            
        case .Unsupported:
            println("Peripheral - CoreBluetooth BLE hardware is unsupported on this platform")
            break
            
        default:
            break
        }
        
    }
    
    func centralManager(central: CBCentralManager!,
        didDiscoverPeripheral peripheral: CBPeripheral!,
        advertisementData: [NSObject : AnyObject]!,
        RSSI: NSNumber!) {
            central.connectPeripheral(peripheral, options: nil)
            
            // We have to set the discoveredPeripheral var we declared earlier to reference the peripheral, otherwise we won't be able to interact with it in didConnectPeripheral. And you will get state = connecting> is being dealloc'ed while pending connection error.
            
            self.discoveredPeripheral = peripheral
            
            var curDevice = UIDevice.currentDevice()
            
            //iPad or iPhone
            println("VENDOR ID: \(curDevice.identifierForVendor) BATTERY LEVEL: \(curDevice.batteryLevel)\n\n")
            println("DEVICE DESCRIPTION: \(curDevice.description) MODEL: \(curDevice.model)\n\n")
            
            // Hardware beacon
            println("PERIPHERAL NAME: \(peripheral.name)\n AdvertisementData: \(advertisementData)\n RSSI: \(RSSI)\n")
            
            println("UUID DESCRIPTION: \(peripheral.identifier.UUIDString)\n")
            
            println("IDENTIFIER: \(peripheral.identifier)\n")
            
            println("FOUND PERIPHERALS: \(peripheral) AdvertisementData: \(advertisementData) RSSI: \(RSSI)\n")
            
            //items.insert(peripheral.name, atIndex: items.count)
            
            // stop scanning, saves the battery
            cManager.stopScan()
            
            /*print("AUDIO STUFF ")
            println( AVAudioSession.sharedInstance().outputDataSources)
            println(AVAudioSession.sharedInstance().availableInputs)*/
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
        peripheral.delegate = self 
        peripheral.discoverServices(nil)
        println("Connected to peripheral")
        
        /*print("AUDIO STUFF ")
        println(AVAudioSession.sharedInstance().outputDataSources)
        println(AVAudioSession.sharedInstance().availableInputs)*/
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("FAILED TO CONNECT \(error)")
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        print("AUDIO STUFF ")
        println(AVAudioSession.sharedInstance().outputDataSources)
        println(AVAudioSession.sharedInstance().availableInputs)
        println(AVAudioSession.sharedInstance().currentRoute)
        
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("foxhurt2", ofType: "wav")!)
        println(alertSound)
        
        var error:NSError?
        
        //UIApplicationMain(ar)
        
        //audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        //audioPlayer.prepareToPlay()
        //audioPlayer.play()
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        println("ERROR: \(error)")
        
        var svc:CBService
        
        for svc in peripheral.services {
            println("Service \(svc)\n")
            println("\(svc)\n");
            println("Discovering Characteristics for Service : \(svc)")
            peripheral.discoverCharacteristics(nil, forService: svc as CBService)
        }
    }
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init the PeripheralManager
        //pManager = CBPeripheralManager(delegate: self, queue: nil)
        
        // Init the CentralManager, main queue
        cManager = CBCentralManager(delegate: self, queue: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:AVAudioSessionCategoryOptions.AllowBluetooth, error:nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        //audioRecorder = AVAudioRecorder()
        
        InitilizeAudioStuff()
        
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!)
    {
        println("\n\nCHARACTERISTICS\n\n")
        var myCharacteristic = CBCharacteristic()
        
        for myCharacteristic in service.characteristics {
            //println("\nCharacteristic: \(myCharacteristic)\n")
            
            println("didDiscoverCharacteristicsForService - Service: \(service) Characteristic: \(myCharacteristic)\n\n")
            
            
            peripheral.readValueForCharacteristic(myCharacteristic as CBCharacteristic)
            
        }
    }
    
    // Invoked if the characteristic is updated
    func peripheral(peripheral: CBPeripheral!, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
        println("\nCharacteristic \(characteristic.description) isNotifying: \(characteristic.isNotifying)\n")
        
        if characteristic.isNotifying == true {
            
            peripheral.readValueForCharacteristic(characteristic as CBCharacteristic)
        }
        
    }
    
    //Join
    @IBAction func Find_Touched(sender: UIButton) {

        pManager = CBPeripheralManager(delegate: self, queue: nil)
        
    }
    //Host
    @IBAction func SetUp_Touched(sender: UIButton) {

        cManager.scanForPeripheralsWithServices([SpokeTalkUUID], options: nil)
        println("Now scanning for peripherals with services: \(SpokeTalkUUID)")
    }
    
    func InitilizeAudioStuff()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        let soundFilePath = docsDir.stringByAppendingPathComponent("sound.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings, error: &error)
        
        if let err = error {
            println("audioSession Error: \(err.localizedDescription)")
        }
        else {
            audioRecorder?.prepareToRecord()
        }
    }
    
    /*func PlayMicMedia()
    {
        
        var session: AVAudioSession = AVAudioSession.sharedInstance()
        if(session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                    println("Granted")
                    session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
                    session.setActive(true, error: nil)
                    //self.recorder.record()
                }else{
                    println("Not Granted")
                }
            })
        }
    }*/
    
    @IBAction func recordAudio(sender: AnyObject) {
        stopAudio()
        println("Trying to record")
        if audioRecorder?.recording == false {
            audioRecorder?.record()
            println("recording")
        }
    }
    
    func stopAudio () {
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        stopAudio()
        println("Trying to play")
        if audioRecorder?.recording == false {
            var error: NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url, error: &error)
            
            audioPlayer?.delegate = self as AVAudioPlayerDelegate
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
                println("Playing")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
}
