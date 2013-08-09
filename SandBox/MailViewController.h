//
//  MailViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITextField *messageBody;
- (IBAction)send:(id)sender;

@end
