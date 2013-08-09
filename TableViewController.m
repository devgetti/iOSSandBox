//
//  TableViewController.m
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import "TableViewController.h"
#import "MenuData.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
//        NSMutableDictionary * folder3_3 = [NSMutableDictionary dictionary];
//        NSMutableArray * files3_3 = [NSMutableArray array];
//        [folder3_3 setObject:files3_3 forKey:@"フォルダ3_3"];
//        [files3_3 addObject:@"ファイル3_3_1"];
//        [files3_3 addObject:@"ファイル3_3_2"];
//
//        NSMutableDictionary * folder1 = [NSMutableDictionary dictionary];
//        NSMutableArray * files1 = [NSMutableArray array];
//        [folder1 setObject:files1 forKey:@"フォルダ1"];
//        [files1 addObject:@"ファイル1_1"];
//        [files1 addObject:@"ファイル1_2"];
//        [files1 addObject:@"ファイル1_3"];
//        
//        NSMutableDictionary * folder2 = [NSMutableDictionary dictionary];
//        NSMutableArray * files2 = [NSMutableArray array];
//        [folder2 setObject:files2 forKey:@"フォルダ2"];
//        [files2 addObject:@"ファイル2_1"];
//        [files2 addObject:@"ファイル2_2"];
//
//        NSMutableDictionary * folder3 = [NSMutableDictionary dictionary];
//        NSMutableArray * files3 = [NSMutableArray array];
//        [folder3 setObject:files3 forKey:@"フォルダ3"];
//        [files3 addObject:@"ファイル3_1"];
//        [files3 addObject:@"ファイル3_2"];
//        [files3 addObject:folder3_3];
//        
//        NSMutableDictionary * folder0 = [NSMutableDictionary dictionary];
//        NSMutableArray * files0 = [NSMutableArray array];
//        [folder0 setObject:files0 forKey:@"ホーム"];
//        [files0 addObject:folder1];
//        [files0 addObject:folder2];
//        [files0 addObject:folder3];

        NSMutableDictionary * folder3_3 = [NSMutableDictionary dictionary];
        NSMutableArray * files3_3 = [NSMutableArray array];
        [folder3_3 setObject:files3_3 forKey:@"フォルダ3_3"];
        [files3_3 addObject:@"ファイル3_3_1"];
        [files3_3 addObject:@"ファイル3_3_2"];
        
        NSMutableDictionary * folder1 = [NSMutableDictionary dictionary];
        NSMutableArray * files1 = [NSMutableArray array];
        [folder1 setObject:files1 forKey:@"基本UI類"];
        [files1 addObject:[[MenuData alloc] initWithData:@"ごった煮" storyBoardId:@"ctrl"]];
        [files1 addObject:[[MenuData alloc] initWithData:@"じゃんけん" storyBoardId:@"game"]];
        
        NSMutableDictionary * folder2 = [NSMutableDictionary dictionary];
        NSMutableArray * files2 = [NSMutableArray array];
        [folder2 setObject:files2 forKey:@"デバイス類"];
        [files2 addObject:[[MenuData alloc] initWithData:@"地図のテスト" storyBoardId:@"map"]];
        [files2 addObject:[[MenuData alloc] initWithData:@"カメラのテスト" storyBoardId:@"camera"]];
        [files2 addObject:[[MenuData alloc] initWithData:@"加速度センサーのテスト" storyBoardId:@"accelerometer"]];

        NSMutableDictionary * folder3 = [NSMutableDictionary dictionary];
        NSMutableArray * files3 = [NSMutableArray array];
        [folder3 setObject:files3 forKey:@"ネットワークアクセス類"];
        [files3 addObject:[[MenuData alloc] initWithData:@"HTTP" storyBoardId:@"http"]];
        
        NSMutableDictionary * folderOther = [NSMutableDictionary dictionary];
        NSMutableArray * filesOther = [NSMutableArray array];
        [folderOther setObject:filesOther forKey:@"その他"];
        [filesOther addObject:[[MenuData alloc] initWithData:@"Utility" storyBoardId:@"utility"]];
        [filesOther addObject:[[MenuData alloc] initWithData:@"メール" storyBoardId:@"mail"]];
        [filesOther addObject:[[MenuData alloc] initWithData:@"PDF" storyBoardId:@"pdf"]];
        [filesOther addObject:[[MenuData alloc] initWithData:@"OpenGL" storyBoardId:@"opengl"]];
        [filesOther addObject:folder3_3];
        
        NSMutableDictionary * folder0 = [NSMutableDictionary dictionary];
        NSMutableArray * files0 = [NSMutableArray array];
        [folder0 setObject:files0 forKey:@"ホーム"];
        [files0 addObject:folder1];
        [files0 addObject:folder2];
        [files0 addObject:folder3];
        [files0 addObject:folderOther];
        
        _folder = folder0;
    }
    return self;
}

- (id)initWithFolder:(NSDictionary *) folder {
    self = [super init];
    if(self) {
        _folder = folder;
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * key = [[_folder allKeys] objectAtIndex:0];
    NSArray * files = [_folder objectForKey:key];
    return files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * key = [[_folder allKeys] objectAtIndex:0];
    NSArray * files = [_folder objectForKey:key];
    NSObject * obj = [files objectAtIndex:indexPath.row];
    
    
    if([[obj class] isSubclassOfClass:[NSDictionary class]]) {
        [cell.textLabel setText:[[(NSDictionary *)obj allKeys] objectAtIndex:0]];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else if([[obj class] isSubclassOfClass:[MenuData class]]) {
        [cell.textLabel setText:[(MenuData *)obj name]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSString * key = [[_folder allKeys] objectAtIndex:0];
    NSArray * files = [_folder objectForKey:key];
    NSObject * obj = [files objectAtIndex:indexPath.row];
    
    if([[obj class] isSubclassOfClass:[NSDictionary class]]) {
        // 新しいViewCtrlを作成して、子階層を表示する
        // ビューを動的に作成
        TableViewController * viewCtl = [[TableViewController alloc] initWithFolder:(NSDictionary *)obj];
        [self.navigationController pushViewController:viewCtl animated:YES];
        
    } else if([[obj class] isSubclassOfClass:[MenuData class]]) {
        // 葉要素
        // ビューを動的に作成してるので、Storyboard上のID(StoryboardID)からビューコントローラを特定して移動
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:[(MenuData *)obj storyBoardId]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
