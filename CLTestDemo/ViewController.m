//
//  ViewController.m
//  CLTestDemo
//
//  Created by libo on 2017/12/12.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self findMe];
}

- (void)findMe {
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
 
    //开始定位,不断调用其代理方法
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度：%f,经度：%f",coordinate.latitude,coordinate.longitude);
    
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSLog(@"具体位置:%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            NSLog(@"cityName:%@",city);
        }
    }];
    
    //2.定制定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        //提示用户出错原因,可按住Option键点击 KCLErrorDenied 的查看更多出错信息,可打印error.code值查找原因所在
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
