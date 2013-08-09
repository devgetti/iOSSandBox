//
//  MapCalloutAnnotationView.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import <MapKit/MapKit.h>

@interface MapCalloutAnnotationView : MKAnnotationView {
  	MKAnnotationView *_parentAnnotationView;
	CGFloat _yShadowOffset;
    MKMapView *_mapView;
	UIView *_contentView;
	CGPoint _offsetFromParent;
   	CGFloat _contentHeight;
    
}

@property (nonatomic, retain) MKAnnotationView *parentAnnotationView;
@property (nonatomic, readonly) CGFloat yShadowOffset;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic) CGPoint offsetFromParent;
@property (nonatomic) CGFloat contentHeight;

@end
