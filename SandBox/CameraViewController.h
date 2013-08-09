//
//  CameraViewController.h
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stats.h"

@interface CameraViewController : UIViewController
<
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)doCamera:(id)sender;
- (IBAction)doSave:(id)sender;
- (IBAction)doLibrary:(id)sender;
- (IBAction)doHige:(id)sender;

@end
