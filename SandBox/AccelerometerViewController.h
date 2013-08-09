//
//  AccelerometerViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import <UIKit/UIKit.h>

@interface AccelerometerViewController : UIViewController <UIAccelerometerDelegate> {
    UILabel * _label;
    float _aX;
    float _aY;
    float _aZ;
    NSString * _orientation;
}

@end
