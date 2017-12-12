# CityNameOfCoreLocation
## 各系统版本的前台跟后台访问权限
## 定位功能的实现
* ### 导入框架
        Xcode 中添加 “CoreLocation.framework”
* ### 导入头文件
        #import <CoreLocation/CoreLocation.h>
* ### 声明管理器和代理
        @interface ViewController ()<CLLocationManagerDelegate>
        @property (nonatomic, strong) CLLocationManager* locationManager;
        @end
* ### 初始化管理器
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
* ### 开启定位服务，需要定位时调用findMe方法
        - (void)findMe
        {
        /** 由于IOS8中定位的授权机制改变 需要进行手动授权
        * 获取授权认证，两个方法：
        * [self.locationManager requestWhenInUseAuthorization];
        * [self.locationManager requestAlwaysAuthorization];
        */
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
        }

        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];
        NSLog(@"start gps");
        }
* ### 代理设置
        - (void)locationManager:(CLLocationManager *)manager
        didUpdateLocations:(NSArray *)locations
        {
        // 1.获取用户位置的对象
        CLLocation *location = [locations lastObject];
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);

        // 2.停止定位
        [manager stopUpdatingLocation];
        }

        - (void)locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
        {
        if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        }
        }
    
## 其他
* [Markdown在线编译器](http://mahua.jser.me/)

