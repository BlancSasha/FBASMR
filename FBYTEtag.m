//
//  FBYTEtag.m
//  FBASMR
//
//  Created by François Blanc on 22/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import "FBYTEtag.h"

#import "FBYTVideo.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation FBYTEtag

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"etag":@"etag",
             @"videos":@"items",
             };
}

+(NSValueTransformer *)videosJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[FBYTVideo class]];
}

@end
