//
//  FBYTVideoManager.m
//  FBASMR
//
//  Created by François Blanc on 21/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import "FBYTVideoManager.h"
#import "AFNetworking.h"
#import "Mantle.h"

#import "FBYTVideo.h"
#import "FBYTEtag.h"

#define MY_API_KEY @"AIzaSyCDGdv1hWVQ-5QnXK7GDKqaMasfKEBirxY"
//#define CONSUMER_SECRET @"lAlkRvL3aZFJjgnzbDxLQPvOADy1ZGAs9ocFTnQSwIYFNKK112"
#define TWEETS_COUNT 50

@interface FBYTVideoManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation FBYTVideoManager

- (instancetype)init
{
    self = [super init];
    
    if(self){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        [self.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    return self;
}

+ (instancetype)sharedVideoManager{
    static dispatch_once_t onceToken;
    static FBYTVideoManager *sharedVideoManager;
    dispatch_once(&onceToken, ^{
        sharedVideoManager = [[FBYTVideoManager alloc] init];
    });
    return sharedVideoManager;
}

- (void) fetchVideoswithBlock:(void(^)(NSArray *,NSError *))block
{
    NSDictionary *getParameters = @{@"part":@"snippet",
                                    @"order":@"rating",
                                    @"type":@"video",
                                    @"videoDefinition":@"high",
                                    @"videoEmbeddable":@"true",
                                    @"q":@"asmr",
                                    @"maxResults":@(10),
                                    @"key":MY_API_KEY,
                                    };
    
    [self.manager GET:@"https://www.googleapis.com/youtube/v3/search"
           parameters:getParameters
             progress:nil
              success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  NSError *err = nil;
                  
                  NSArray *items = responseObject[@"items"];
                  NSArray *videos = [MTLJSONAdapter modelsOfClass:[FBYTVideo class] fromJSONArray:items error:&err];
                  
                  if (err)
                      block(nil,err);
                  else
                      block(videos,nil);
                  
              } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
                  
                  //NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode; //pas authentifié

                      block(nil, error);
                  
              }];
}

@end
