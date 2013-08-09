//
//  GLViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/08.
//
//

#import <UIKit/UIKit.h>

@interface GLViewController : UIViewController <UIGestureRecognizerDelegate> {
    CADisplayLink * mpDisplayLink;
}

- (id)initWithGLViewFrame:(CGRect) bounds;
- (void)MainLoop;

@end
