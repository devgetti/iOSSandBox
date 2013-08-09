//
//  ParengViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/09.
//
//

#import "ParengViewController.h"
#import "GLViewController.h"

@interface ParengViewController ()

@end

@implementation ParengViewController

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
    
    // ロジック分割のためにOpenGLビューコントローラを子ビューコントローラにする
    gl = [[GLViewController  alloc] init];//initWithGLViewFrame:a];

    [self addChildViewController:gl];
    
    [gl viewWillAppear:NO];
    [self.view insertSubview:gl.view atIndex:0];
    [gl viewDidAppear:NO];
     
    [gl didMoveToParentViewController:self];
 
    // 二つはだめ？
//    CGRect b = CGRectMake(0, 0, 100,100);
//    GLViewController * gl2 = [[GLViewController  alloc] init];//initWithGLViewFrame:a];
//    [self addChildViewController:gl2];
//    [gl2.view setBounds:b];
//    [gl2 viewWillAppear:NO];
//    [self.view insertSubview:gl2.view atIndex:0];
//    [gl2 viewDidAppear:NO];
//    [gl2 didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [gl willMoveToParentViewController:nil];
    [gl removeFromParentViewController];
    [super viewDidDisappear:animated];
}


@end
