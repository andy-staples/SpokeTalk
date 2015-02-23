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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [String] = ["We", "Heart", "Swift"]
    var MIDIBroadcast = CABTMIDILocalPeripheralViewController()
    var fdio = cbperipheral
    var MIDIFinder = CABTMIDICentralViewController()
    
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func CheckForMIDIDevices()
    {
        let numDevs = MIDIGetNumberOfSources()
        if(numDevs > 0)
        {
            println("I FOUND YOU")
            println(MIDIGetNumberOfSources())
            for index in 0...MIDIGetNumberOfSources() - 1
            {
                var result = AUGraphOpen (_processingGraph)
                
                println(MIDIGetSource(index))
            }
        }
    }
    @IBAction func doneAction()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        CheckForMIDIDevices()
    }
    //Join
    @IBAction func Find_Touched(sender: UIButton) {

        //println( AVAudioSession.sharedInstance().outputDataSources)
        
        var navController = UINavigationController(rootViewController: MIDIBroadcast)
        
        // this will present a view controller as a popover in iPad and modal VC on iPhone
        var newRightUIBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneAction")
        MIDIBroadcast.navigationItem.rightBarButtonItem = newRightUIBarButton
        
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover;
        
        var popC = navController.popoverPresentationController;
        popC?.permittedArrowDirections = UIPopoverArrowDirection.Any;
        popC?.sourceRect = sender.frame;

        popC?.sourceView = sender.superview
        
        self.presentViewController(navController, animated: true, completion: nil)
        println("MIDIPeripheralSETUP");
        
    }
    //Host
    @IBAction func SetUp_Touched(sender: UIButton) {

        
        //println( AVAudioSession.sharedInstance().outputDataSources)
        
        var navController = UINavigationController(rootViewController: MIDIFinder)
        
        // this will present a MIDI Peripheral display as a popover in iPad and modal VC on iPhone
        var newRightUIBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneAction")
        MIDIFinder.navigationItem.rightBarButtonItem = newRightUIBarButton
        
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover;
        
        var popC = navController.popoverPresentationController;
        popC?.permittedArrowDirections = UIPopoverArrowDirection.Any;
        popC?.sourceRect = sender.frame
        
        popC?.sourceView = sender.superview
        
        self.presentViewController(navController, animated: true, completion: nil)
        println("MIDICentralSETUP");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
}
