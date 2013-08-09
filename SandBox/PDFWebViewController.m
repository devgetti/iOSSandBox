//
//  PDFWebViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/08.
//
//

#import "PDFWebViewController.h"

@interface PDFWebViewController ()

@end

@implementation PDFWebViewController

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
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"ReleaseUpgradeGdWebAtWorkiOS111"
                                         withExtension:@"pdf"];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
