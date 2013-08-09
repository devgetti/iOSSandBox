//
//  UtilityMainViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import "UtilityMainViewController.h"

@interface UtilityMainViewController ()

@end

@implementation UtilityMainViewController

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
    NSDictionary * defaultsVals = @{@"test": @0 };
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsVals];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)flipsideViewCOntrollerDidFinish:(FlipsideViewController *)controller {
    [self.lblTest setText:[NSString stringWithFormat:@"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"test"]]];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"segueFlipside"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender {
    if(self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"segueFlipside" sender:sender];
    }
}


- (void)viewDidUnload {
    [self setLblTest:nil];
    [super viewDidUnload];
}
@end
