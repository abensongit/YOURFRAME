

#import <UIKit/UIKit.h>

@class CFCMarqueeView;

typedef NS_ENUM(NSUInteger, CFCMarqueeViewDirection) {
    CFCMarqueeViewDirectionUpward,     // scroll from bottom to top
    CFCMarqueeViewDirectionDownward,   // scroll from top to bottom
    CFCMarqueeViewDirectionLeftward,   // scroll from right to left
    CFCMarqueeViewDirectionRightward   // scroll from left to right
};

#pragma mark - CFCMarqueeViewDelegate
@protocol CFCMarqueeViewDelegate <NSObject>
- (NSUInteger)numberOfDataForMarqueeView:(CFCMarqueeView *)marqueeView;
- (void)createItemView:(UIView*)itemView forMarqueeView:(CFCMarqueeView *)marqueeView;
- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(CFCMarqueeView *)marqueeView;
@optional
- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(CFCMarqueeView*)marqueeView;
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(CFCMarqueeView *)marqueeView;   // only for [CFCMarqueeViewDirectionUpward、CFCMarqueeViewDirectionDownward]
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(CFCMarqueeView*)marqueeView;   // only for [CFCMarqueeViewDirectionLeftward、CFCMarqueeViewDirectionRightward]
@end

#pragma mark - CFCMarqueeView
@interface CFCMarqueeView : UIView
@property (nonatomic, weak) id<CFCMarqueeViewDelegate> delegate;
@property (nonatomic, assign) CFCMarqueeViewDirection direction;
@property (nonatomic, assign) NSTimeInterval timeIntervalPerScroll;
@property (nonatomic, assign) NSTimeInterval timeDurationPerScroll; // only for [CFCMarqueeViewDirectionUpward、CFCMarqueeViewDirectionDownward]
@property (nonatomic, assign) float scrollSpeed;    // only for [CFCMarqueeViewDirectionLeftward、CFCMarqueeViewDirectionRightward]
@property (nonatomic, assign) float itemSpacing;    // only for [CFCMarqueeViewDirectionLeftward、CFCMarqueeViewDirectionRightward]
@property (nonatomic, assign) BOOL clipsToBounds;
@property (nonatomic, assign, getter=isTouchEnabled) BOOL touchEnabled;

- (instancetype)initWithDirection:(CFCMarqueeViewDirection)direction;
- (instancetype)initWithFrame:(CGRect)frame direction:(CFCMarqueeViewDirection)direction;
- (void)reloadData;
- (void)start;
- (void)pause;
@end

#pragma mark - CFCMarqueeViewTouchResponder(Private)
@protocol CFCMarqueeViewTouchResponder <NSObject>
- (void)touchAtPoint:(CGPoint)point;
@end

#pragma mark - CFCMarqueeViewTouchReceiver(Private)
@interface CFCMarqueeViewTouchReceiver : UIView
@property (nonatomic, weak) id<CFCMarqueeViewTouchResponder> touchDelegate;
@end



