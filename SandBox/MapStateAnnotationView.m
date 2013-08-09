//
//  MapStateAnnotationView.m
//  SandBox
//
//  Created by akosuge on 2013/08/02.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import "MapStateAnnotationView.h"

@implementation MapStateAnnotationView

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 */

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if(self != nil) {
        UIImage * image = [UIImage imageNamed:@"African Daisy.gif"];
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.imageView];
        
        CGSize imageSize = self.imageView.frame.size;
        CGRect frame = self.frame;
        frame.size = self.imageView.frame.size;
        self.frame = frame;
        
        self.imageView.center = CGPointMake(imageSize.width / 2, -imageSize.height / 2);
    }
    
    //self.canShowCallout = YES;
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
