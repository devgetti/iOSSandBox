//
//  MailViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#import "MailViewController.h"

@interface MailViewController ()

@end

@implementation MailViewController
@synthesize messageBody;

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

// 送信ボタン選択
- (IBAction)send:(id)sender {
    UIImage * image = [UIImage imageNamed:@"African Daisy.gif"];
    [self sendMail:messageBody.text image:image];
}

// メール送信
- (void)sendMail:(NSString *)text image:(UIImage *)image {
    // メール送信可否チェック
    if(![MFMailComposeViewController canSendMail]) {
        NSLog(@"送れない");
    }
    
    // メールコントローラ作成
    MFMailComposeViewController * pickerCtl = [[MFMailComposeViewController alloc] init];
    pickerCtl.mailComposeDelegate = self;
    
    // メッセージを設定
    [pickerCtl setMessageBody:text isHTML:NO];
    
    if(image != nil) {
        // 画像添付
        NSData * data = UIImagePNGRepresentation(image);
        [pickerCtl addAttachmentData:data mimeType:@"image/png" fileName:@"test.png"];
    }
    
    // 実行(メーラーの送信画面表示)
    [self presentViewController:pickerCtl animated:YES completion:nil];
}

// メール送信処理終了時
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if(error != nil) {
        NSLog(@"エラー");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidUnload {
    [self setMessageBody:nil];
    [super viewDidUnload];
}
@end
