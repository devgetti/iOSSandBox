//
//  UtilityMainViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"

@interface UtilityMainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (weak, nonatomic) IBOutlet UILabel *lblTest;
- (IBAction)togglePopover:(id)sender;

@end
