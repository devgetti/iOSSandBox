//
//  HttpViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/07.
//
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>

@interface HttpViewController : UIViewController <UITextFieldDelegate, NSURLConnectionDataDelegate> {
    NSHTTPURLResponse * responseHead;
    NSMutableData * receiveData;
    NSMutableString * strResponse;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUrl;
@property (weak, nonatomic) IBOutlet UILabel *lblResponse;
@property (weak, nonatomic) IBOutlet UIScrollView *scvResponse;
- (IBAction)tapGet:(id)sender;

@end
