//
//  MenuData.m
//  SandBox
//
//  Created by akosuge on 2013/08/05.
//
//

#import "MenuData.h"

@implementation MenuData
@synthesize name;
@synthesize storyBoardId;

-(id)initWithData:(NSString *)_name storyBoardId:(NSString *)_storyBoardId {
    name = _name;
    storyBoardId = _storyBoardId;
    
    return self;
}


@end
