//
//  CameraViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/01.
//  Copyright (c) 2013年 akosuge. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    
//    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera  target:self action:@selector(doCamera:)];
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doSave:)];
//    
//    self.toolBar.items = @[cameraButton, saveButton];
    

}

// カメラボタン
- (IBAction)doCamera: (id)sender {
    NSLog(@"カメラ");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    BOOL isSimulator = ([[[UIDevice currentDevice] model] hasSuffix:@"Simulator"]);
    
    if(isSimulator) {
        // シミュレータの場合
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self doPicker:sourceType];
}

// ライブラリボタン
- (IBAction)doLibrary:(id)sender {
    NSLog(@"doLibrary");
    
    [self doPicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

// 
- (void) doPicker:(UIImagePickerControllerSourceType)sourceType {
    // 利用可否を判定
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        // ImagePicker作成
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        
        // ソースタイプを指定
        [ipc setSourceType: sourceType];
        
        // 編集有無
        [ipc setAllowsEditing:NO];
        
        
        // 自信をデリゲートに
        [ipc setDelegate: self];
        
        // Pickerを指定してPresenter起動
        [self presentViewController:ipc animated:YES completion:Nil];
        
    } else {
        // 使えない場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"起動できない" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

// 保存
- (IBAction)doSave: (id)sender {
    NSLog(@"保存");
    
    UIImage *aImage = [self.aImageView image];
    if(aImage == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"対象がない" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
   
    SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(aImage, self, sel, NULL);
    
}

// 保存完了を通知するメソッド
- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End"message:@"image save completed"delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}




- (IBAction)doHige:(id)sender {
    
    UIImage *image = self.aImageView.image;
    
    // 検出オプション作成
    NSDictionary *options = [NSDictionary dictionaryWithObject: CIDetectorAccuracyLow forKey:CIDetectorAccuracy];
    
    // 検出機作成
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    
    // UIImageからCIImage作成
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    // 撮影位置
    NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:6] forKey: CIDetectorImageOrientation];
    
    // 検出
    NSArray *array = [detector featuresInImage:ciImage options:imageOptions];
    
    for(CIFaceFeature *faceFeature in array) {
        // 結果
        if([sender tag] == 0) {
            [self drawHige:faceFeature];
        } else {
            [self drawHige2:faceFeature];
        }
        
        NSLog(@"%f",[faceFeature bounds].origin.x);
    }
}

static inline double radians (double degrees) {return degrees * M_PI/180;}
// 加工
- (void)drawHige:(CIFaceFeature *)faceFeature {
    if(faceFeature.hasLeftEyePosition && faceFeature.hasRightEyePosition && faceFeature.hasMouthPosition) {
        // 顔のサイズ情報を取得
        CGRect faceRect = [faceFeature bounds];
        
        // 写真の向きで検出されたXとYを逆さにセットする
        float temp = faceRect.size.width;
        faceRect.size.width = faceRect.size.height;
        faceRect.size.height = temp;
        temp = faceRect.origin.x;
        faceRect.origin.x = faceRect.origin.y;
        faceRect.origin.y = temp;
        
        // Viewでの重ね合わせ
        UIImageView *picture = self.aImageView;
        
        // 比率計算
        float widthScale = picture.frame.size.width / picture.image.size.width;
        float heightScale = picture.frame.size.height / picture.image.size.height;
        // 眼鏡画像のxとy、widthとheightのサイズを比率似合わせて変更
        faceRect.origin.x *= widthScale;
        faceRect.origin.y *= heightScale;
        faceRect.size.width *= widthScale;
        faceRect.size.height *= heightScale;
        
        // 眼鏡のUIImageViewを作成
        UIImage *glassesImage = [UIImage imageNamed:@"hige.png"];
        UIImageView *glassesImageView = [[UIImageView alloc]initWithImage:glassesImage];
        glassesImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // 眼鏡画像のリサイズ
        glassesImageView.frame = faceRect;
        
        // 眼鏡レイヤを撮影した写真に重ねる
        [picture addSubview:glassesImageView];
    }
}

// 加工
- (void)drawHige2:(CIFaceFeature *)faceFeature {
    if(faceFeature.hasLeftEyePosition && faceFeature.hasRightEyePosition && faceFeature.hasMouthPosition) {
        // 顔のサイズ情報を取得
        CGRect faceRect = [faceFeature bounds];
        
        // 写真の向きで検出されたXとYを逆さにセットする
        float temp = faceRect.size.width;
        faceRect.size.width = faceRect.size.height;
        faceRect.size.height = temp;
        temp = faceRect.origin.x;
        faceRect.origin.x = faceRect.origin.y;
        faceRect.origin.y = temp;
        
        // Bitmap描画での重ね合わせ
        UIImage * imgA = [self.aImageView image];
        UIImage * imgB = [UIImage imageNamed:@"hige.png"];
        
        // どうも-90度回転してしまうので、強制的に戻す
        // iOS仕様?
        UIGraphicsBeginImageContext(imgA.size);
        [imgA drawInRect:CGRectMake(0, 0, imgA.size.width, imgA.size.height)];
        imgA = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Bitmap領域を作成
        unsigned char *bitmap = malloc(imgA.size.width * imgA.size.height * sizeof(unsigned char) * 4);
        
        // コンテキスト作成
        CGContextRef bitmapContext = CGBitmapContextCreate(bitmap, imgA.size.width, imgA.size.height, 8, imgA.size.width * 4, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedFirst);
        
        // 元画像の描画
        CGContextDrawImage(bitmapContext, CGRectMake(0, 0, imgA.size.width, imgA.size.height), imgA.CGImage);
        
        // 重ね合わせ画像の描画
        CGContextDrawImage(bitmapContext, faceRect, imgB.CGImage);
        
        // コンテキストからCGImageへ
        CGImageRef imgRef = CGBitmapContextCreateImage(bitmapContext);
        
        // CGImageからUIImageへ
        UIImage * imgC = [UIImage imageWithCGImage:imgRef];
        
        // 領域解放
        free(bitmap);
        
        // Viewに設定
        [self.aImageView setImage:imgC];
        
    }
}

// 撮影完了時
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"撮影");
    
    // 撮影画像をImageViewへ
    for (UIView* subview in [self.aImageView subviews]) {
        [subview removeFromSuperview];
    }
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.aImageView setImage:image];
    
    if([picker respondsToSelector:@selector(presentingViewController)]) {
        [[picker presentingViewController] dismissViewControllerAnimated:YES completion:Nil];
    } else {
        [[picker parentViewController] dismissViewControllerAnimated:YES completion:Nil];
    }
}

// 撮影キャンセル
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"キャンセル");
    
    if([picker respondsToSelector:@selector(presentingViewController)]) {
        [[picker presentingViewController] dismissViewControllerAnimated:YES completion:Nil];
    } else {
        [[picker parentViewController] dismissViewControllerAnimated:YES completion:Nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)viewDidUnload {
    [self setToolBar:nil];
    [super viewDidUnload];
}

@end
