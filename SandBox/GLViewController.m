//
//  GLViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/08.
//
//

#import "GLViewController.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GLView.h"

@interface GLViewController ()

@end

@implementation GLViewController

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
    
    mpDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(MainLoop)];
    [mpDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)MainLoop {
    [(GLView *)self.view BeginScene];
    
    [(GLView *)self.view drawScene];
    
    [(GLView *)self.view EndScene];
}

- (void)drawBackGround {
    GLfloat vertices[] = {
        -1.0f, -1.5f,
        1.0f, -1.5f,
        -1.0f, 1.5f,
        1.0f, 1.5f,
    };
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    
    GLubyte colors[] = {
        255,255, 255, 255,
        255,255, 255, 255,
        255,255, 255, 255,
        255,255, 255, 255,
    };
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    
    GLfloat coord[] = {
        0, 0.9375,
        0.625, 0.9375,
        0, 0,
        0.625, 0,
    };
    glTexCoordPointer(2, GL_FLOAT, 0, coord);
}

- (void)viewDidDisappear:(BOOL)animated {
    [mpDisplayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [super viewDidDisappear:animated];
}

@end
