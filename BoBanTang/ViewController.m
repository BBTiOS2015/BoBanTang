//
//  ViewController.m
//  BoBanTang
//
//  Created by Authority on 16/8/4.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "ViewController.h"
#import "bus.h"


@interface ViewController ()

@end

@implementation ViewController

CLLocationCoordinate2D center;
BMKCoordinateSpan span;

- (IBAction)convert:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    center = CLLocationCoordinate2DMake(23.1645505, 113.351992);
    span = BMKCoordinateSpanMake(0.0133195*2, 0.009001*2);
    _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
    _mapView.rotateEnabled = NO;//禁用旋转手势
    self.view = _mapView;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://bbt.100steps.net/go/data/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@",  responseObject);
            NSDictionary *busInfo=[responseObject objectForKey:@"BUS1"];
            NSLog(@"%@",[busInfo objectForKey:@"Name"]);
        }
    }];
    [dataTask resume];
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
