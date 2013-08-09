//
//  MapViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    int mapType;
    BOOL inited;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)current:(id)sender;
- (IBAction)onTapChangeMode:(id)sender;

@end
