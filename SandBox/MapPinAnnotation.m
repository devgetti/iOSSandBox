//
//  MapPinAnnotation.m
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import "MapPinAnnotation.h"

@implementation MapPinAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize color;

- (id)initWithData:(CLLocationCoordinate2D)_coordinate title:(NSString *)_title desc:(NSString *)_subtitle {
    return [self initWithData:_coordinate title:_title desc:_subtitle color:MKPinAnnotationColorRed];
}

- (id)initWithData:(CLLocationCoordinate2D) _coordinate title:(NSString*)_title desc:(NSString *)_subtitle color:(MKPinAnnotationColor)_color {
    coordinate = _coordinate;
    title = _title;
    subtitle = _subtitle;
    color = _color;
    return self;
}


@end
