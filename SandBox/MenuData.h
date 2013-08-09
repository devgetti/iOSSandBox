//
//  MenuData.h
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import <Foundation/Foundation.h>

@interface MenuData : NSObject {
    NSString * name;
    NSString * storyBoardId;
    //NSString * segueId;
}

@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSString * storyBoardId;
-(id)initWithData:(NSString *)_name storyBoardId:(NSString *)_storyBoardId;
@end
