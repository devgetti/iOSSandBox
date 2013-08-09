	//
//  MapViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import "MapViewController.h"
#import "MapPinAnnotation.h"
#import "MapCalloutAnnotation.h"
#import "MapCalloutAnnotationView.h"
#import "CameraViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.map setDelegate: self];
    locationManager = [[CLLocationManager alloc] init];
    mapType = 0;
    inited = NO;
	// Do any additional setup after loading the view.

    // 場所
    [self.map addAnnotation:[[MapPinAnnotation alloc] initWithData:CLLocationCoordinate2DMake(35.456286, 139.629811) title:@"三菱重工ビル" desc:@""]];
    [self.map addAnnotation:[[MapPinAnnotation alloc] initWithData:CLLocationCoordinate2DMake(35.531261, 139.696779) title:@"川崎" desc:@"" color:MKPinAnnotationColorGreen]];
    //[self.map addAnnotation:[[MapStateAnnotation alloc] initWithLocationCoordinate:CLLocationCoordinate2DMake(19.707191, -155.695769) title:@"ハワイ" desc:@"オエー"]];
    
    if([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services not available.");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}	

// 位置情報更新時
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"didUpdateToLocation latitude=%f, longitude=%f", [newLocation coordinate].latitude, [newLocation coordinate].longitude);
    MKCoordinateSpan span = (inited)?[self.map region].span:MKCoordinateSpanMake(1.75, 1.75);
    MKCoordinateRegion region = MKCoordinateRegionMake([newLocation coordinate], span);
    
    // 中心設定
    [self.map setCenterCoordinate:[newLocation coordinate] animated:YES];
    
    // Region、パン
    [self.map setRegion:region animated:YES];
    
    // 更新停止
    [locationManager stopUpdatingLocation];
    
    inited = YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}


- (IBAction)current:(id)sender {
    NSLog(@"現在地");
    [locationManager startUpdatingLocation];
}


// モードボタン選択時
- (IBAction)onTapChangeMode:(id)sender {
    NSLog(@"モード");
    switch(mapType % 3) {
    case 0:
        // 通常
        self.map.mapType = MKMapTypeStandard;
        break;
    case 1:
        // サテライト
        self.map.mapType = MKMapTypeSatellite;
        break;
    case 2:
        // ハイブリッド
        self.map.mapType = MKMapTypeHybrid;
        break;
    }
    mapType++;
}

- (void)onResume {
    if(nil != locationManager && [CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }
}

- (void)onPause {
    if(nil != locationManager && [CLLocationManager locationServicesEnabled]) {
        [locationManager stopUpdatingLocation];
    }
}

// アノテーション表示時
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKAnnotationView * annotationView;
    NSString * identifier;
    if(annotation == mapView.userLocation) {
        // 現在位置アノテーションは無視
        annotationView = nil;
        
    } else if([annotation isKindOfClass:[MapPinAnnotation class]]) {
        // ピンアノテーション
        identifier = @"Pin";
        MapPinAnnotation * pinAnnotation = (MapPinAnnotation *)annotation;
        MKPinAnnotationView * pinAnnotationView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(nil == pinAnnotationView) {
            // リサイクル出来なければ新規作成
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            // 色の切り替え
            [pinAnnotationView setPinColor:pinAnnotation.color];
        }
        pinAnnotationView.annotation = pinAnnotation;
        annotationView = pinAnnotationView;
        
    } else if([annotation isKindOfClass:[MapCalloutAnnotation class]]) {
        // コールアウト
        identifier = @"Callout";
        MapCalloutAnnotation * calloutAnnotation = (MapCalloutAnnotation *)annotation;
        MapCalloutAnnotationView *calloutMapAnnotationView = (MapCalloutAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
		if (!calloutMapAnnotationView) {
            // リサイクル出来なければ新規作成
			calloutMapAnnotationView = [[MapCalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            // コールアウト内コンテンツ作成
            {
                calloutMapAnnotationView.contentHeight = 80.0f;
                
                UIImage *asynchronyLogo = [UIImage imageNamed:@"African Daisy.gif"];
                UIImageView *asynchronyLogoView = [[UIImageView alloc] initWithImage:asynchronyLogo];
                asynchronyLogoView.frame = CGRectMake(5, 2, asynchronyLogoView.frame.size.width, asynchronyLogoView.frame.size.height);
                [calloutMapAnnotationView.contentView addSubview:asynchronyLogoView];
                
                UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button setFrame:CGRectMake(0, 50, 200, 40)];
                [button setTitle:@"カメラ" forState:UIControlStateNormal];
                [calloutMapAnnotationView.contentView addSubview:button];
                
            }
		}
        calloutMapAnnotationView.parentAnnotationView = calloutAnnotation.parentView;
		calloutMapAnnotationView.mapView = self.map;
        calloutMapAnnotationView.annotation = calloutAnnotation;
        annotationView = calloutMapAnnotationView;
    }
    return annotationView;
}

// ピン選択時
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if([view.annotation isKindOfClass:[MapPinAnnotation class]]) {
        // ピンアノテーションの場合
        MapPinAnnotation * pinAnnotation = (MapPinAnnotation *)view.annotation;
    
        // コールアウトアノテーション作成
        MapCalloutAnnotation * calloutAnnotation = [[MapCalloutAnnotation alloc] init];
        calloutAnnotation.coordinate = pinAnnotation.coordinate;
        calloutAnnotation.parentView = view;

        // コールアウトアノテーションを追加
        [self.map addAnnotation:calloutAnnotation];

        // 削除用に保存
        pinAnnotation.calloutAnnotation = calloutAnnotation;
    }
}

// ピン選択解除時
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if([view.annotation isKindOfClass:[MapPinAnnotation class]]) {
        // ピンアノテーションの場合
        MapPinAnnotation * pinAnnotation = (MapPinAnnotation *)view.annotation;
        
        // コールアウトアノテーションを削除
        [self.map removeAnnotation:pinAnnotation.calloutAnnotation];
        
        // コールアウトへの参照削除
        pinAnnotation.calloutAnnotation = nil;
    }
}

@end
