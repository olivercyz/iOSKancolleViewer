//
//  KCResponseHandlerProtocol.h
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KCResponseHandlerProtocol <NSObject>

- (NSString *)httpPath;

- (NSDictionary *)httpQuery;

- (void)dealWithResponse:(NSURLResponse *)response;

@end
