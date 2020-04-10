

#import "YHSDropDownMenuBasedModel.h"

@implementation YHSDropDownMenuBasedModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellClassName = @"YHSDropDownMenuBasedCell";
    }
    return self;
}

@end
