//
//  MapPinAnnotation.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import <MapKit/MapKit.h>
#import "MapCalloutAnnotation.h"

@interface MapPinAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    MKPinAnnotationColor color;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MapCalloutAnnotation * calloutAnnotation;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic) MKPinAnnotationColor color;

- (id)initWithData:(CLLocationCoordinate2D) _coordinate title:(NSString*)_title desc:(NSString *)_subtitle;
- (id)initWithData:(CLLocationCoordinate2D) _coordinate title:(NSString*)_title desc:(NSString *)_subtitle color:(MKPinAnnotationColor)_color;

@end
