//
//  FBVideoCell.m
//  FBASMR
//
//  Created by François Blanc on 20/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import "FBVideoCell.h"
#import "Masonry.h"
#import "YTPlayerView.h"
#import "FBYTVideo.h"

@interface FBVideoCell ()

@property (strong, nonatomic) YTPlayerView *videoView;
@property (strong, nonatomic) FBYTVideo *video;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *descr;

@property (strong, nonatomic) UILabel *sizingLabel;

@end

@implementation FBVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.videoView = [[YTPlayerView alloc] init];
        [self.videoView setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:self.videoView];
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:self.title];
        [self.title setNumberOfLines:2];
        self.title.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.descr = [[UILabel alloc] init];
        [self. contentView addSubview:self.descr];
        [self.descr setNumberOfLines:0];
        self.descr.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return self;
}

-(void) updateConstraints
{
    [super updateConstraints];
    
    for (MASConstraint *constraint in [MASViewConstraint installedConstraintsForView:self.videoView])
        [constraint uninstall];
    
    [self.videoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.height.equalTo(@100);
        make.width.equalTo(@100);
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(self.videoView.mas_right).offset(10);
        make.right.equalTo(@(-10));
    }];
    
    [self.descr mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset (10);
        make.left.equalTo(self.videoView.mas_right).offset(10);
        make.right.equalTo(@(-10));
    }];
}

-(void)setVideo:(FBYTVideo *)video{
    
    self->_video = video;
    
    [self.videoView loadWithVideoId:self.video.videoID];
    
    [self setNeedsUpdateConstraints];
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    //self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

static FBVideoCell *sizingCell;

+ (CGFloat)cellHeightForVideo:(FBYTVideo *)video andWidth:(CGFloat)width
{
    if (!sizingCell)
    {
        sizingCell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sizingCellFBVideo"];
    }
    
    [sizingCell setVideo:video];
    [sizingCell setFrame:CGRectMake(0, 0, width, 1000.)];
    [sizingCell setNeedsUpdateConstraints];
    [sizingCell updateConstraintsIfNeeded];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    [sizingCell.contentView layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:CGSizeMake(width, 1000.)
                                        withHorizontalFittingPriority:UILayoutPriorityRequired
                                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    //NSLog(@"%@", NSStringFromCGSize(size));
    return size.height + 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
