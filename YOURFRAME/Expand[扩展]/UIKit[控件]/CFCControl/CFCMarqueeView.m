

#import "CFCMarqueeView.h"

@interface CFCMarqueeView () <CFCMarqueeViewTouchResponder>

@property (nonatomic, assign) int dataIndex;
@property (nonatomic, assign) int firstItemIndex;
@property (nonatomic, assign) NSInteger visibleItemCount;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray<UIView*> *items;
@property (nonatomic, strong) CFCMarqueeViewTouchReceiver *touchReceiver;

@end

@implementation CFCMarqueeView

static NSInteger const DEFAULT_VISIBLE_ITEM_COUNT = 2;
static NSTimeInterval const DEFAULT_TIME_INTERVAL = 4.0;
static NSTimeInterval const DEFAULT_TIME_DURATION = 1.0;
static float const DEFAULT_SCROLL_SPEED = 40.0f;
static float const DEFAULT_ITEM_SPACING = 20.0f;

- (instancetype)initWithDirection:(CFCMarqueeViewDirection)direction
{
    if (self = [super init]) {
        _direction = direction;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _timeIntervalPerScroll = DEFAULT_TIME_INTERVAL;
        _timeDurationPerScroll = DEFAULT_TIME_DURATION;
        _scrollSpeed = DEFAULT_SCROLL_SPEED;
        _itemSpacing = DEFAULT_ITEM_SPACING;
        _touchEnabled = NO;
        
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame direction:(CFCMarqueeViewDirection)direction
{
    if (self = [super initWithFrame:frame]) {
        _direction = direction;
        _timeIntervalPerScroll = DEFAULT_TIME_INTERVAL;
        _timeDurationPerScroll = DEFAULT_TIME_DURATION;
        _scrollSpeed = DEFAULT_SCROLL_SPEED;
        _itemSpacing = DEFAULT_ITEM_SPACING;
        _touchEnabled = NO;
        
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
    }
    return self;
}

- (void)setClipsToBounds:(BOOL)clipsToBounds
{
    _contentView.clipsToBounds = clipsToBounds;
}

- (void)setTouchEnabled:(BOOL)touchEnabled
{
    _touchEnabled = touchEnabled;
    [self resetTouchReceiver];
}

- (void)reloadData
{
    [self pause];
    [self resetAll];
    [self startAfterTimeInterval:YES];
}

- (void)start
{
    [self startAfterTimeInterval:NO];
}

- (void)pause
{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

- (void)repeat
{
    [self pause];
    [self startAfterTimeInterval:YES];
}

#pragma mark - Override(private)
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_contentView setFrame:self.bounds];
    [self repositionItemViews];
    if (_touchEnabled && _touchReceiver) {
        [_touchReceiver setFrame:self.bounds];
    }
}

- (void)dealloc
{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

#pragma mark - ItemView(private)
- (void)resetAll
{
    self.dataIndex = -1;
    self.firstItemIndex = 0;
    
    if (_items) {
        [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_items removeAllObjects];
    } else {
        self.items = [NSMutableArray array];
    }
    
    if (_direction == CFCMarqueeViewDirectionLeftward
        || _direction == CFCMarqueeViewDirectionRightward) {
        self.visibleItemCount = 1;
    } else {
        if ([_delegate respondsToSelector:@selector(numberOfVisibleItemsForMarqueeView:)]) {
            self.visibleItemCount = [_delegate numberOfVisibleItemsForMarqueeView:self];
            if (_visibleItemCount <= 0) {
                return;
            }
        } else {
            const NSInteger extractedExpr = DEFAULT_VISIBLE_ITEM_COUNT;
            self.visibleItemCount = extractedExpr;
        }
    }
    
    for (int i = 0; i < _visibleItemCount + 2; i++) {
        UIView *itemView = [[UIView alloc] init];
        [_contentView addSubview:itemView];
        [_items addObject:itemView];
    }
    
    [self repositionItemViews];
    
    for (int i = 0; i < _items.count; i++) {
        int index = (i + _firstItemIndex) % _items.count;
        if (i == 0) {
            if ([_delegate respondsToSelector:@selector(createItemView:forMarqueeView:)]) {
                [_delegate createItemView:_items[index] forMarqueeView:self];
            }
            _items[index].tag = _dataIndex;
        } else  {
            if ([_delegate respondsToSelector:@selector(createItemView:forMarqueeView:)]) {
                [_delegate createItemView:_items[index] forMarqueeView:self];
            }
            [self moveToNextDataIndex];
            _items[index].tag = _dataIndex;
            if ([_delegate respondsToSelector:@selector(updateItemView:atIndex:forMarqueeView:)]) {
                [_delegate updateItemView:_items[index] atIndex:_items[index].tag forMarqueeView:self];
            }
        }
    }
    
    [self resetTouchReceiver];
}

- (void)repositionItemViews
{
    if (_direction == CFCMarqueeViewDirectionLeftward) {
        CGFloat itemHeight = CGRectGetHeight(self.frame) / _visibleItemCount;
        CGFloat lastMaxX = 0.0f;
        for (int i = 0; i < _items.count; i++) {
            int index = (i + _firstItemIndex) % _items.count;
            
            CGFloat itemWidth = CGRectGetWidth(self.frame);
            if (_items[index].tag != -1) {
                if ([_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                    itemWidth = MAX([_delegate itemViewWidthAtIndex:_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                }
            }
            
            if (i == 0) {
                [_items[index] setFrame:CGRectMake(-itemWidth, 0.0f, itemWidth, itemHeight)];
                lastMaxX = 0.0f;
            } else {
                [_items[index] setFrame:CGRectMake(lastMaxX, 0.0f, itemWidth, itemHeight)];
                lastMaxX = lastMaxX + itemWidth;
            }
        }
    } else if (_direction == CFCMarqueeViewDirectionRightward) {
        CGFloat itemHeight = CGRectGetHeight(self.frame) / _visibleItemCount;
        CGFloat lastMaxX = 0.0f;
        for (int i = 0; i < _items.count; i++) {
            int index = (i + _firstItemIndex) % _items.count;
            
            CGFloat itemWidth = CGRectGetWidth(self.frame);
            if (_items[index].tag != -1) {
                if ([_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                    itemWidth = MAX([_delegate itemViewWidthAtIndex:_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                }
            }
            
            CGFloat itemWidthX = CGRectGetWidth(self.frame);
            int idx = (i + 1 + _firstItemIndex) % _items.count;
            if (_items[idx].tag != -1) {
                if ([_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                    itemWidthX = MAX([_delegate itemViewWidthAtIndex:_items[idx].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidthX);
                }
            }
            
            if (i == 0) {
                [_items[index] setFrame:CGRectMake(itemWidthX, 0.0f, itemWidth, itemHeight)];
                lastMaxX = 0.0f;
            } else {
                [_items[index] setFrame:CGRectMake(lastMaxX, 0.0f, itemWidth, itemHeight)];
                lastMaxX = lastMaxX - itemWidthX;
            }
        }
    } else if (_direction == CFCMarqueeViewDirectionUpward) {
        CGFloat itemWidth = CGRectGetWidth(self.frame);
        CGFloat itemHeight = CGRectGetHeight(self.frame) / _visibleItemCount;
        for (int i = 0; i < _items.count; i++) {
            int index = (i + _firstItemIndex) % _items.count;
            if (i == 0) {
                [_items[index] setFrame:CGRectMake(0.0f, -itemHeight, itemWidth, itemHeight)];
            } else if (i == _items.count - 1) {
                [_items[index] setFrame:CGRectMake(0.0f, CGRectGetMaxY(self.bounds), itemWidth, itemHeight)];
            } else {
                [_items[index] setFrame:CGRectMake(0.0f, itemHeight * (i - 1), itemWidth, itemHeight)];
            }
        }
    } else if (_direction == CFCMarqueeViewDirectionDownward) {
        CGFloat itemWidth = CGRectGetWidth(self.frame);
        CGFloat itemHeight = CGRectGetHeight(self.frame) / _visibleItemCount;
        for (int i = 0; i < _items.count; i++) {
            int index = (i + _firstItemIndex) % _items.count;
            if (i == 0) {
                [_items[index] setFrame:CGRectMake(0.0f, CGRectGetMaxY(self.bounds), itemWidth, itemHeight)];
            } else if (i == _items.count - 1) {
                [_items[index] setFrame:CGRectMake(0.0f, -itemHeight, itemWidth, itemHeight)];
            } else {
                [_items[index] setFrame:CGRectMake(0.0f, itemHeight * (_items.count - i - 2), itemWidth, itemHeight)];
            }
        }
    }
}

- (int)itemIndexWithOffsetFromTop:(int)offsetFromTop
{
    return (_firstItemIndex + offsetFromTop) % (_visibleItemCount + 2);
}

- (void)moveToNextItemIndex
{
    if (_firstItemIndex >= _items.count - 1) {
        self.firstItemIndex = 0;
    } else {
        self.firstItemIndex++;
    }
}

#pragma mark - Timer & Animation(private)
- (void)startAfterTimeInterval:(BOOL)afterTimeInterval
{
    if (_scrollTimer || _items.count <= 0) {
        return;
    }
    
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:afterTimeInterval ? _timeIntervalPerScroll : 0.0
                                                        target:self
                                                      selector:@selector(scrollTimerDidFire:)
                                                      userInfo:nil
                                                       repeats:NO];
}

- (void)scrollTimerDidFire:(NSTimer *)timer
{
    dispatch_async(dispatch_get_main_queue(), ^() {
        
        if (self->_direction == CFCMarqueeViewDirectionLeftward) {
            [self moveToNextDataIndex];
            if (self->_dataIndex < 0) {
                return;
            }
            
            CGFloat itemHeight = CGRectGetHeight(self.frame);
            CGFloat firstItemWidth = CGRectGetWidth(self.frame);
            CGFloat currentItemWidth = CGRectGetWidth(self.frame);
            CGFloat lastItemWidth = CGRectGetWidth(self.frame);
            for (int i = 0; i < self->_items.count; i++) {
                int index = (i + self->_firstItemIndex) % self->_items.count;
                
                CGFloat itemWidth = CGRectGetWidth(self.frame);
                if (self->_items[index].tag != -1) {
                    if ([self->_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                        itemWidth = MAX([self->_delegate itemViewWidthAtIndex:self->_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                    }
                }
                lastItemWidth = itemWidth;
                
                if (i == 0) {
                    firstItemWidth = itemWidth;
                } else if (i == 1) {
                    currentItemWidth = itemWidth;
                } else {
                    lastItemWidth = itemWidth;
                }
            }
            
            // move the left item to right without animation
            self->_items[self->_firstItemIndex].tag = self->_dataIndex;
            [self->_items[self->_firstItemIndex] setFrame:CGRectMake(lastItemWidth, 0.0f, firstItemWidth, itemHeight)];
            if ([self->_delegate respondsToSelector:@selector(updateItemView:atIndex:forMarqueeView:)]) {
                [self->_delegate updateItemView:self->_items[self->_firstItemIndex] atIndex:self->_items[self->_firstItemIndex].tag forMarqueeView:self];
            }
            
            [UIView animateWithDuration:(currentItemWidth / self->_scrollSpeed) delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                CGFloat lastMaxX = 0.0f;
                for (int i = 0; i < self->_items.count; i++) {
                    int index = (i + self->_firstItemIndex) % self->_items.count;
                    
                    CGFloat itemWidth = CGRectGetWidth(self.frame);
                    if (self->_items[index].tag != -1) {
                        if ([self->_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                            itemWidth = MAX([self->_delegate itemViewWidthAtIndex:self->_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                        }
                    }
                    
                    if (i == 0) {
                        continue;
                    } else if (i == 1) {
                        [self->_items[index] setFrame:CGRectMake(-itemWidth, 0.0f, itemWidth, itemHeight)];
                        lastMaxX = 0.0f;
                    } else {
                        [self->_items[index] setFrame:CGRectMake(lastMaxX, 0.0f, itemWidth, itemHeight)];
                        lastMaxX = lastMaxX + itemWidth;
                    }
                }
            } completion:^(BOOL finished) {
                if (self->_scrollTimer) {
                    [self repeat];
                }
            }];
            [self moveToNextItemIndex];
            
        } else if (self->_direction == CFCMarqueeViewDirectionRightward) {
            
            [self moveToNextDataIndex];
            if (self->_dataIndex < 0) {
                return;
            }
            
            CGFloat itemHeight = CGRectGetHeight(self.frame);
            CGFloat firstItemWidth = CGRectGetWidth(self.frame);
            CGFloat currentItemWidth = CGRectGetWidth(self.frame);
            CGFloat lastItemWidth = CGRectGetWidth(self.frame);
            for (int i = 0; i < self->_items.count; i++) {
                int index = (i + self->_firstItemIndex) % self->_items.count;
                
                CGFloat itemWidth = CGRectGetWidth(self.frame);
                if (self->_items[index].tag != -1) {
                    if ([self->_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                        itemWidth = MAX([self->_delegate itemViewWidthAtIndex:self->_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                    }
                }
                lastItemWidth = itemWidth;

                if (i == 0) {
                    firstItemWidth = itemWidth;
                } else if (i == 1) {
                    currentItemWidth = itemWidth;
                } else {
                    lastItemWidth = itemWidth;
                }
            }

            // move the right item to left without animation
            self->_items[self->_firstItemIndex].tag = self->_dataIndex;
            [self->_items[self->_firstItemIndex] setFrame:CGRectMake(-MAX(lastItemWidth,firstItemWidth), 0.0f, firstItemWidth, itemHeight)];
            if ([self->_delegate respondsToSelector:@selector(updateItemView:atIndex:forMarqueeView:)]) {
                [self->_delegate updateItemView:self->_items[self->_firstItemIndex] atIndex:self->_items[self->_firstItemIndex].tag forMarqueeView:self];
            }
            
            [UIView animateWithDuration:(currentItemWidth / self->_scrollSpeed) delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                CGFloat lastMaxX = 0.0f;
                for (int i = 0; i < self->_items.count; i++) {
                    int index = (i + self->_firstItemIndex) % self->_items.count;
                    
                    CGFloat itemWidth = CGRectGetWidth(self.frame);
                    if (self->_items[index].tag != -1) {
                        if ([self->_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                            itemWidth = MAX([self->_delegate itemViewWidthAtIndex:self->_items[index].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidth);
                        }
                    }

                    int idx = (i + 1 + self->_firstItemIndex) % self->_items.count;
                    CGFloat itemWidthX = CGRectGetWidth(self.frame);
                    if (self->_items[idx].tag != -1) {
                        if ([self->_delegate respondsToSelector:@selector(itemViewWidthAtIndex:forMarqueeView:)]) {
                            itemWidthX = MAX([self->_delegate itemViewWidthAtIndex:self->_items[idx].tag forMarqueeView:self] + DEFAULT_ITEM_SPACING, itemWidthX);
                        }
                    }
  
                    if (i == 0) {
                        continue;
                    } else if (i == 1) {
                        [self->_items[index] setFrame:CGRectMake(itemWidthX, 0.0f, itemWidth, itemHeight)];
                        lastMaxX = 0.0f;
                    } else {
                        [self->_items[index] setFrame:CGRectMake(lastMaxX, 0.0f, itemWidth, itemHeight)];
                        lastMaxX = lastMaxX - itemWidthX;
                    }
                }
            } completion:^(BOOL finished) {
                if (self->_scrollTimer) {
                    [self repeat];
                }
            }];
            [self moveToNextItemIndex];
            
        } else if (self->_direction == CFCMarqueeViewDirectionUpward) {
            
            [self moveToNextDataIndex];
            if (self->_dataIndex < 0) {
                return;
            }
            
            CGFloat itemWidth = CGRectGetWidth(self.frame);
            CGFloat itemHeight = CGRectGetHeight(self.frame) / self->_visibleItemCount;
            
            // move the top item to bottom without animation
            self->_items[self->_firstItemIndex].tag = self->_dataIndex;
            [self->_items[self->_firstItemIndex] setFrame:CGRectMake(0.0f, CGRectGetMaxY(self.bounds), itemWidth, itemHeight)];
            if ([self->_delegate respondsToSelector:@selector(updateItemView:atIndex:forMarqueeView:)]) {
                [self->_delegate updateItemView:self->_items[self->_firstItemIndex] atIndex:self->_items[self->_firstItemIndex].tag forMarqueeView:self];
            }
            
            [UIView animateWithDuration:self->_timeDurationPerScroll animations:^{
                for (int i = 0; i < self->_items.count; i++) {
                    int index = (i + self->_firstItemIndex) % self->_items.count;
                    if (i == 0) {
                        continue;
                    } else if (i == 1) {
                        [self->_items[index] setFrame:CGRectMake(0.0f, -itemHeight, itemWidth, itemHeight)];
                    } else {
                        [self->_items[index] setFrame:CGRectMake(0.0f, itemHeight * (i - 2), itemWidth, itemHeight)];
                    }
                }
            } completion:^(BOOL finished) {
                if (self->_scrollTimer) {
                    [self repeat];
                }
            }];
            [self moveToNextItemIndex];
            
        } else if (self->_direction == CFCMarqueeViewDirectionDownward) {
            
            [self moveToNextDataIndex];
            if (self->_dataIndex < 0) {
                return;
            }
            
            CGFloat itemWidth = CGRectGetWidth(self.frame);
            CGFloat itemHeight = CGRectGetHeight(self.frame) / self->_visibleItemCount;
            
            // move the bottom item to to without animation
            self->_items[self->_firstItemIndex].tag = self->_dataIndex;
            [self->_items[self->_firstItemIndex] setFrame:CGRectMake(0.0f, -itemHeight, itemWidth, itemHeight)];
            if ([self->_delegate respondsToSelector:@selector(updateItemView:atIndex:forMarqueeView:)]) {
                [self->_delegate updateItemView:self->_items[self->_firstItemIndex] atIndex:self->_items[self->_firstItemIndex].tag forMarqueeView:self];
            }
            
            [UIView animateWithDuration:self->_timeDurationPerScroll animations:^{
                for (int i = 0; i < self->_items.count; i++) {
                    int index = (i + self->_firstItemIndex) % self->_items.count;
                    if (i == 0) {
                        continue;
                    } else if (i == 1) {
                        [self->_items[index] setFrame:CGRectMake(0.0f, CGRectGetMaxY(self.bounds), itemWidth, itemHeight)];
                    } else {
                        [self->_items[index] setFrame:CGRectMake(0.0f, itemHeight * (self->_items.count - i - 1), itemWidth, itemHeight)];
                    }
                }
            } completion:^(BOOL finished) {
                if (self->_scrollTimer) {
                    [self repeat];
                }
            }];
            [self moveToNextItemIndex];
            
        }
    });
}

#pragma mark - Data source(Private)
- (void)moveToNextDataIndex
{
    NSUInteger dataCount = 0;
    if ([_delegate respondsToSelector:@selector(numberOfDataForMarqueeView:)]) {
        dataCount = [_delegate numberOfDataForMarqueeView:self];
    }
    
    self.dataIndex = _dataIndex + 1;
    if (_dataIndex < 0 || _dataIndex > dataCount - 1) {
        self.dataIndex = 0;
    }
}

#pragma mark - Touch handler(Private)
- (void)resetTouchReceiver
{
    if (_touchEnabled) {
        if (!_touchReceiver) {
            self.touchReceiver = [[CFCMarqueeViewTouchReceiver alloc] init];
            _touchReceiver.touchDelegate = self;
            [self addSubview:_touchReceiver];
        } else {
            [self bringSubviewToFront:_touchReceiver];
        }
    } else {
        if (_touchReceiver) {
            [_touchReceiver removeFromSuperview];
            self.touchReceiver = nil;
        }
    }
}

#pragma mark - CFCMarqueeViewTouchResponder(private)
- (void)touchAtPoint:(CGPoint)point
{
    for (UIView *itemView in _items) {
        if ([itemView.layer.presentationLayer hitTest:point]) {
            if ([self.delegate respondsToSelector:@selector(didTouchItemViewAtIndex:forMarqueeView:)]) {
                [self.delegate didTouchItemViewAtIndex:itemView.tag forMarqueeView:self];
            }
            break;
        }
    }
}

@end

#pragma mark - CFCMarqueeViewTouchReceiver(private)
@implementation CFCMarqueeViewTouchReceiver

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (_touchDelegate) {
        [_touchDelegate touchAtPoint:touchLocation];
    }
}

@end


