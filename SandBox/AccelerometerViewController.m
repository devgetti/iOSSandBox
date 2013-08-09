//
//  AccelerometerViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import "AccelerometerViewController.h"
#define FILTERING_FACTOR 0.1

@interface AccelerometerViewController ()

@end

@implementation AccelerometerViewController

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
	// Do any additional setup after loading the view.
    
    _label = [self makeLabel:CGPointMake(0, 0) text:@"Accelerometer" font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:_label];
    
    _aX = _aY = _aZ = 0;
    _orientation = @"";
    
    UIAccelerometer * accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = 0.1f;
    accelerometer.delegate =  self;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)didRotate:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[notification object] orientation];
    if(orientation == UIDeviceOrientationLandscapeLeft) {
        _orientation = @"横(左90度)";
    } else if(orientation == UIDeviceOrientationLandscapeRight) {
        _orientation = @"横(右90度)";
    } else if(orientation == UIDeviceOrientationPortraitUpsideDown) {
        _orientation = @"上下逆";
    } else if(orientation == UIDeviceOrientationPortrait) {
        _orientation = @"縦";
    } else if(orientation == UIDeviceOrientationFaceUp) {
        _orientation = @"上向き";
    } else if(orientation == UIDeviceOrientationFaceDown) {
        _orientation = @"下向き";
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    _aX = (acceleration.x * FILTERING_FACTOR) + (_aX * (1.0 - FILTERING_FACTOR));
    _aY = (acceleration.y * FILTERING_FACTOR) + (_aY * (1.0 - FILTERING_FACTOR));
    _aZ = (acceleration.z * FILTERING_FACTOR) + (_aZ * (1.0 - FILTERING_FACTOR));
    
    NSMutableString * str = [NSMutableString string];
    [str appendString:@"Accelerometer\n"];
    [str appendFormat:@"X軸加速度:%+.2f\n", _aX];
    [str appendFormat:@"Y軸加速度:%+.2f\n", _aY];
    [str appendFormat:@"Z軸加速度:%+.2f\n", _aZ];
    [str appendFormat:@"端末の向き:%@", _orientation];
    [_label setText:str];
    [self resizeLabel:_label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resizeLabel:(UILabel *)label {
    CGRect frame = label.frame;
    frame.size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(512,512) lineBreakMode:NSLineBreakByWordWrapping];
    [label setFrame:frame];
}

- (UILabel *)makeLabel:(CGPoint)pos text:(NSString *)text font:(UIFont *)font {
    UILabel * label = [[UILabel alloc] init];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [self resizeLabel:label];
    return label;
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [self viewDidDisappear:animated];
}


@end
