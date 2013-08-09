//
//  FlipsideViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.delegate flipsideViewCOntrollerDidFinish:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    int val = [defaults integerForKey:@"test"] + 1;
    [defaults setInteger:val forKey:@"test"];
}

@end
