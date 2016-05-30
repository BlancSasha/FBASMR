//
//  FBYTEtag.h
//  FBASMR
//
//  Created by François Blanc on 22/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mantle.h"

@class FBYTVideo;

@interface FBYTEtag : MTLModel <MTLJSONSerializing, NSCoding>

@property (strong, nonatomic) NSString *etag;
@property (strong, nonatomic) NSArray <FBYTVideo *> *videos;

@end
