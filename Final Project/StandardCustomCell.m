//
//  StandardCustomCell.m
//  DCEZ
//
//  Created by Bill Columbia on 12/7/12.
//
//

#import "StandardCustomCell.h"

@implementation StandardCustomCell

@synthesize mainTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
