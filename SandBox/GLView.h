//
//  GLView.h
//  SandBox
//
//  Created by akosuge on 2013/08/08.
//
//

#import <UIKit/UIKit.h>

@interface GLView : UIView <UIGestureRecognizerDelegate> {
    EAGLContext * mpGLContext;
    
    GLuint mFrameBuffer;
    GLuint mColorBuffer;
    GLuint mDepthBuffer;
    GLint backingWidth, backingHeight;
    
    CGAffineTransform _currentTransform;
    float _scale;
    float _angle;
    BOOL _isMoving;
}

- (void)BeginScene;
- (void)EndScene;
- (void)drawScene;
- (void)rotationGesture:(UIRotationGestureRecognizer *)gesture;
- (void)pinchGesture:(UIPinchGestureRecognizer *)gesture;

@end
