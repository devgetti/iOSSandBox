//
//  GameViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *guu;

@property (weak, nonatomic) IBOutlet UIImageView *chyoki;

@property (weak, nonatomic) IBOutlet UIImageView *paa;
@property (weak, nonatomic) IBOutlet UILabel *kati;
@property (weak, nonatomic) IBOutlet UILabel *aiko;
@property (weak, nonatomic) IBOutlet UILabel *make;

- (IBAction)buttn1Push:(UIButton *)sender;
- (IBAction)backBtnPush:(UIButton *)sender;

@end
