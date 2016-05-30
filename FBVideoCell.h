//
//  FBVideoCell.h
//  FBASMR
//
//  Created by François Blanc on 20/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBYTVideo.h"

@interface FBVideoCell : UITableViewCell

- (void)setVideo:(FBYTVideo *)video;

+ (CGFloat)cellHeightForVideo:(FBYTVideo *)video andWidth:(CGFloat)width;

@end
