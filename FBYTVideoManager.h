//
//  FBYTVideoManager.h
//  FBASMR
//
//  Created by François Blanc on 21/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBYTVideoManager : NSObject

- (void) fetchVideoswithBlock:(void(^)(NSArray *,NSError *))block;

+ (instancetype)sharedVideoManager;

@end
