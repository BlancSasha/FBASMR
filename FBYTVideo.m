//
//  FBYTVideo.m
//  FBASMR
//
//  Created by François Blanc on 20/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import "FBYTVideo.h"

@implementation FBYTVideo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"etag":@"etag",
             @"kind":@"id.kind",
             @"kindOfEtag":@"kind",
             @"videoID":@"id.videoId",
             @"channelID":@"snippet.channelId",
             @"channelTitle":@"snippet.channelTitle",
             @"descr":@"snippet.description",
             //@"publishedAt":@"snippet.publishedAt",
             @"title":@"snippet.title",
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.'000z'"; //2016-01-11T16:45:10.000Z
    return dateFormatter;
}

+ (NSValueTransformer *)tweetDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
