//
//  ViewController.swift
//  swift-udp-demo
//
//  Created by apple on 15-1-3.
//  Copyright (c) 2015年 thinker. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GCDAsyncUdpSocketDelegate{
    
    var mUdpSocket:GCDAsyncUdpSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUdpSocket();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func send(sender: AnyObject) {
        var byte:[Byte] = [ Byte(0xb4), Byte(0x9a), 0x70, 0x4d, 0x00 ]
        var data = NSData(bytes: byte, length: 5)
        mUdpSocket.sendData(data, toHost: "255.255.255.255", port: 10000, withTimeout: 2, tag: 0)
        
    }
    
    func initUdpSocket(){
        var error : NSError?
        mUdpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        mUdpSocket.enableBroadcast(true,error: &error)
        mUdpSocket.beginReceiving(&error)
        
    }
    
    func udpSocket(sock: GCDAsyncUdpSocket!, didReceiveData data: NSData!, fromAddress address: NSData!, withFilterContext filterContext: AnyObject!) {
        println("\(__FUNCTION__),\(__LINE__),\(data)");
    }
    
    func udpSocket(sock: GCDAsyncUdpSocket!, didSendDataWithTag tag: Int) {
        println("\(__FUNCTION__),\(__LINE__),\(tag)");
    }
    
    func udpSocket(sock: GCDAsyncUdpSocket!, didConnectToAddress address: NSData!) {
        println("\(__FUNCTION__),\(__LINE__),\(address)");
    }
    func udpSocket(sock: GCDAsyncUdpSocket!, didNotConnect error: NSError!) {
        println("\(__FUNCTION__),\(__LINE__),\(error)");
    }
    
}

