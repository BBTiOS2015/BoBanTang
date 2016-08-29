//
//  ViewController.m
//  BoBanTang
//
//  Created by Authority on 16/8/4.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property UIButton *campusBus;
@property UIButton *campusSwitch;
@property UIButton *location;
@property UIView *popview;
@property DXPopover *popover;
@property (nonatomic, strong) NSMutableArray *arrayBus;
@property (nonatomic, strong) NSMutableArray *arrayHeat;
@property (nonatomic, strong) NSMutableArray *BusAnnotations;
@property (nonatomic, strong) NSMutableArray *HeatAnnotations;

@end

@implementation ViewController

CLLocationCoordinate2D center;
BMKCoordinateSpan span;
NSTimer *timer;
double latitude,longitude;
@synthesize popover;
@synthesize popview;
@synthesize campusBus;
@synthesize campusSwitch;
@synthesize location;
@synthesize arrayBus;
@synthesize arrayHeat;
@synthesize BusAnnotations;
@synthesize HeatAnnotations;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    center = CLLocationCoordinate2DMake(23.1645505, 113.351992);
    span = BMKCoordinateSpanMake(0.0133195*2, 0.009001*2);
    [_mapView setRegion: BMKCoordinateRegionMake(center, span)];////限制地图显示范围
    _mapView.rotateEnabled = NO;//禁用旋转手势
    [self.view addSubview: _mapView];
    
    arrayBus=[[NSMutableArray alloc]init];
    arrayHeat=[[NSMutableArray alloc]init];
    BusAnnotations=[[NSMutableArray alloc]init];
    HeatAnnotations=[[NSMutableArray alloc]init];
    popview=nil;
    
    campusSwitch=[[UIButton alloc] initWithFrame:CGRectMake(0.8*self.view.bounds.size.width, 0.85*self.view.bounds.size.height, 0.15*self.view.bounds.size.width,0.15*self.view.bounds.size.width)];
    [campusSwitch setImage:[UIImage imageNamed:@"n_s.png"] forState:UIControlStateNormal];
    [campusSwitch addTarget:self action:@selector(NSControlPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:campusSwitch];
    
    
    location=[[UIButton alloc] initWithFrame:CGRectMake(40, 645, 40, 40)];
    [location setImage:[UIImage imageNamed:@"map_location.png"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
 //   [self.view addSubview:location];
    
    
    campusBus=[[UIButton alloc] initWithFrame:CGRectMake(0.82*self.view.bounds.size.width, 0.2*self.view.bounds.size.height, 0.1*self.view.bounds.size.width, 0.1*self.view.bounds.size.width)];
    [campusBus setImage:[UIImage imageNamed:@"map_bus.png"] forState:UIControlStateNormal];
    [campusBus addTarget:self action:@selector(busButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:campusBus];
    
    
}

- (void) setAnnotionsWithList:(NSMutableArray *)list
{
    for (int i = 0; i < [list count]; i++) {
        if ([[list objectAtIndex:i] isKindOfClass:[CampusBus class]]) {
            CampusBus *entity = [list objectAtIndex:i];
            BOOL headingSouth=[entity.headingSouth boolValue];
            CLLocationCoordinate2D coor;
            coor.latitude = [entity.latitude doubleValue];
            coor.longitude = [entity.longitude doubleValue];
            NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
            coor=BMKCoorDictionaryDecode(testdic);

            MyAnnotation *annotiation;
            if (headingSouth) {
                 annotiation= [[MyAnnotation alloc]initMapAnnotation:coor.latitude andLongitude:coor.longitude Kind:5];
            }else{
                annotiation=[[MyAnnotation alloc]initMapAnnotation:coor.latitude andLongitude:coor.longitude Kind:6];
            }
            [BusAnnotations addObject:annotiation];
            [_mapView addAnnotation:annotiation];
        }
        if ([[list objectAtIndex:i] isKindOfClass:[StationHeat class]]) {
            StationHeat *entity =[list objectAtIndex:i];
            CLLocationCoordinate2D coor;
            coor.latitude=[entity.latitude doubleValue];
            coor.longitude=[entity.longitude doubleValue];
            NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
            coor=BMKCoorDictionaryDecode(testdic);

            int kind=[entity.level intValue];
            
            MyAnnotation *annotiation=[[MyAnnotation alloc]initMapAnnotation:coor.latitude andLongitude:coor.longitude Kind:kind];
            [_mapView addAnnotation:annotiation];
            [HeatAnnotations addObject:annotiation];
        }
    }
}



- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyAnnotation"];
        MyAnnotation *myAnnotation=(MyAnnotation*)annotation;
        switch (myAnnotation.kind) {
            case 0:
                newAnnotationView.image=[UIImage imageNamed:@"hot_1.png"];
                break;
            case 1:
                newAnnotationView.image=[UIImage imageNamed:@"hot_2.png"];
                break;
            case 2:
                newAnnotationView.image=[UIImage imageNamed:@"hot_3.png"];
                break;
            case 3:
                newAnnotationView.image=[UIImage imageNamed:@"hot_4.png"];
                break;
            case 4:
                newAnnotationView.image=[UIImage imageNamed:@"hot_5.png"];
                break;
            case 5:
                newAnnotationView.image=[UIImage imageNamed:@"place_bus_green.png"];
                break;
            case 6:
                newAnnotationView.image=[UIImage imageNamed:@"place_bus_violet.png"];
                break;
            default:
                break;
        }
//        newAnnotationView.animatesDrop=YES;
        return newAnnotationView;
    }
    return nil;
}

-(void) busButtonPressed:(id)sender {
    if (popview==nil) {
        popview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 110)];
        UIImageView *busIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 40)];
        busIcon.image=[UIImage imageNamed:@"bus_menu_place.png"];
        UILabel *busLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 70, 40)];
        busLabel.text=@"校巴位置";
        UISwitch *busSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(240, 15, 60, 40)];
        [busSwitch addTarget:self action:@selector(busSwitchAction:) forControlEvents:UIControlEventValueChanged];
        UIImageView *heatIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 50, 40)];
        heatIcon.image=[UIImage imageNamed:@"bus_menu_hot.png"];
        UILabel *heatLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 60, 70, 40)];
        heatLabel.text=@"站点热度";
        UISwitch *heatSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(240, 65, 60, 40)];
        [heatSwitch addTarget:self action:@selector(heatSwitchAction:) forControlEvents:UIControlEventValueChanged];

        
        [popview addSubview:busSwitch];
        [popview addSubview:busLabel];
        [popview addSubview:busIcon];
        [popview addSubview:heatSwitch];
        [popview addSubview:heatLabel];
        [popview addSubview:heatIcon];
         popover = [DXPopover popover];
    }
    
    
    [popover showAtView:campusBus withContentView:popview];
}

-(void) locationButtonPressed:(id)sender{

}


-(void) busSwitchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {

        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *URL = [NSURL URLWithString:@"http://bbt.100steps.net/go/data/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        //http://bbt.100steps.net/go/data/
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                
                for (int i=1; i<=4; i++) {
                    NSDictionary *busInfo=[responseObject objectForKey:[NSString stringWithFormat:@"BUS%i",i]];
                    CampusBus *bus=[[CampusBus alloc]initWithAttributes:busInfo];
                    [arrayBus addObject:bus];
                }
                
                [self setAnnotionsWithList:arrayBus];
                
            }
        }];
        [dataTask resume];
        
        
        timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    }else {
        [arrayBus removeAllObjects];
        [_mapView removeAnnotations:BusAnnotations];
        [BusAnnotations removeAllObjects];
        [timer invalidate];
    }
}

-(void)timeAction{
    [arrayBus removeAllObjects];
    [_mapView removeAnnotations:BusAnnotations];
    [BusAnnotations removeAllObjects];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:@"http://bbt.100steps.net/go/data/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //http://bbt.100steps.net/go/data/
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            for (int i=1; i<=4; i++) {
                NSDictionary *busInfo=[responseObject objectForKey:[NSString stringWithFormat:@"BUS%i",i]];
                CampusBus *bus=[[CampusBus alloc]initWithAttributes:busInfo];
                [arrayBus addObject:bus];
            }
            
            [self setAnnotionsWithList:arrayBus];
            
        }
    }];
    [dataTask resume];
    


}

-(void)heatSwitchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL=[NSURL URLWithString:@"http://218.192.166.167/api/SQL_function.php?table=heat&method=get"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSMutableArray *array=responseObject;
                for (NSDictionary* attribute in array) {
                    StationHeat *heat=[[StationHeat alloc]initWithAttributes:attribute];
                    [arrayHeat addObject:heat];
                }
                [self setAnnotionsWithList:arrayHeat];
            }
        }];
        [dataTask resume];

    }else {
        [_mapView removeAnnotations:HeatAnnotations];
        [HeatAnnotations removeAllObjects];
    }
}

- (void) NSControlPressed:(id)sender {
    static int i=0;
    i++;
    if (i%2) {
      //  _mapView.centerCoordinate=CLLocationCoordinate2DMake(26.0538815, 113.413117);
        center = CLLocationCoordinate2DMake(23.0538815, 113.413117);
        span = BMKCoordinateSpanMake(0.014175, 0.02156);
        [_mapView setRegion: BMKCoordinateRegionMake(center, span)];
    }else{
        center = CLLocationCoordinate2DMake(23.1645505, 113.351992);
        span = BMKCoordinateSpanMake(0.0133195*2, 0.009001*2);
        [_mapView setRegion: BMKCoordinateRegionMake(center, span)];
    }
 
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
