//
//  Macro.h
//  SandBox
//
//  Created by akosuge on 2013/08/06.
//
//

#ifndef SandBox_Macro_h
#define SandBox_Macro_h

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:@v options:NSNumericSearch] == NSOrderedAscending)

#endif
