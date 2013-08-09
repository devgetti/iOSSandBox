//
//  ViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Heelo World!");		
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Hello World!";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapMap:(id)sender {
    [self performSegueWithIdentifier:@"segueMap" sender:self];
    
}

- (IBAction)tapCamera:(id)sender {
    [self performSegueWithIdentifier:@"segueCamera" sender:self];

}

- (IBAction)tapUtility:(id)sender {
    [self performSegueWithIdentifier:@"segueUtility" sender:self];
}

- (IBAction)tapTable:(id)sender {
    [self performSegueWithIdentifier:@"segueTable" sender:self];
}

- (IBAction)tapGame:(id)sender {
    [self performSegueWithIdentifier:@"segueGame" sender:self];
}

- (IBAction)tapCtrl:(id)sender {
    [self performSegueWithIdentifier:@"segueCtrl" sender:self];
}

@end
