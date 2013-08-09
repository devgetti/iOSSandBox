//
//  MapCalloutAnnotation.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapCalloutAnnotation : NSObject<MKAnnotation> {
    MKAnnotationView * parentView;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) MKAnnotationView * parentView;

@end
