//
//  ViewController.m
//  oc-Udp-demo
//
//  Created by apple on 15-1-4.
//  Copyright (c) 2015年 thinker. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<GCDAsyncUdpSocketDelegate>

@property (nonatomic) GCDAsyncUdpSocket* udpSocket;

@end

@implementation ViewController

- (IBAction)send:(id)sender {
    
    char arr[] ={0xb4, 0x9a, 0x70, 0x4d, 0x00};
    NSData * data = [NSData dataWithBytes:arr length:5];
    [_udpSocket sendData:data toHost:@"255.255.255.255" port:10000 withTimeout:2 tag:0];
    printf("%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__FUNCTION__);
    [self initUdp];
}

-(void) initUdp{
    NSLog(@"%s",__FUNCTION__);
    NSError* error;
    _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_udpSocket enableBroadcast:true error:&error];
    [_udpSocket beginReceiving:&error];
    NSLog(@"%@",error);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"%s,%@,%ld",__func__,sock,tag);
}
-(void) udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    NSLog(@"%s,%@,%@,\n,%@",__func__,sock,address,data);


}

@end
