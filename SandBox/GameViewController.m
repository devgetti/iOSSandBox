//
//  GameViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

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

- (IBAction)buttn1Push:(UIButton *)sender {
    int jibun_no_te = sender.tag;
    int aite_no_te = arc4random() % 3;
    
    self.guu.hidden = YES;
    self.chyoki.hidden = YES;
    self.paa.hidden = YES;
    self.kati.hidden = YES;
    self.aiko.hidden = YES;
    self.make.hidden = YES;
    
    
    if(aite_no_te == 0) {
        self.guu.hidden = NO;
    } else if(aite_no_te == 1) {
        self.chyoki.hidden = NO;
    } else if(aite_no_te == 2) {
        self.paa.hidden = NO;
    }
    
    if(jibun_no_te == aite_no_te) {
        self.aiko.hidden = NO;
    } else if((jibun_no_te == 0 && aite_no_te == 1) ||
              (jibun_no_te == 1 && aite_no_te == 2) ||
              (jibun_no_te == 2 && aite_no_te == 0)) {
        self.kati.hidden = NO;
    } else {
        self.make.hidden = NO;
    }
    
}

- (IBAction)backBtnPush:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
