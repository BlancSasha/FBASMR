//
//  FBYTVideo.h
//  FBASMR
//
//  Created by François Blanc on 20/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface FBYTVideo : MTLModel <MTLJSONSerializing, NSCoding>

@property (strong, nonatomic) NSString *etag;
@property (strong, nonatomic) NSString *kind;
@property (strong, nonatomic) NSString *kindOfEtag;
@property (strong, nonatomic) NSString *videoID;
@property (strong, nonatomic) NSString *channelID;
@property (strong, nonatomic) NSString *channelTitle;
@property (strong, nonatomic) NSString *descr;
//@property (strong, nonatomic) NSDate *publishedAt;
@property (strong, nonatomic) NSString *title;

@end
