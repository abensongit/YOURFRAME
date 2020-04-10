
#import "CFCCollectionRefreshViewWaterFallLayout.h"

@interface CFCCollectionRefreshViewWaterFallLayout ()
@property (nonatomic, assign) CGFloat totalHeightFirstLayout;
@property (nonatomic, assign) CGFloat totalHeightResultLayout;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *lastLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributesArray;
@end

@implementation CFCCollectionRefreshViewWaterFallLayout

- (instancetype)init
{
  self = [super init];
  if (self) {
    _margin = 10.0f;
    _columnsCount = 1.0f;
    _totalHeightFirstLayout = -1.0f;
    _totalHeightResultLayout = 0.0f;
    _cellHeight = SCREEN_WIDTH * 0.125f;
    _sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _lastLayoutAttributes = nil;
  }
  return self;
}

- (void)prepareLayout
{
  [super prepareLayout];
  
  self.lastLayoutAttributes = nil;
  self.totalHeightFirstLayout = -1.0f;
  self.totalHeightResultLayout = 0.0f;
  NSInteger sectionCount = [self.collectionView numberOfSections];
  NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArr = [NSMutableArray array];
  for (int i = 0; i < sectionCount; i++) {
    NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:i];
    UICollectionViewLayoutAttributes *headerLayoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:sectionIndexPath];
    [attributesArr addObject:headerLayoutAttributes];
    [self setLastLayoutAttributes:headerLayoutAttributes];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
    for (NSInteger j = 0; j < itemCount; j++) {
      NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
      UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
      [attributesArr addObject:attrs];
      [self setLastLayoutAttributes:attrs];
    }
    UICollectionViewLayoutAttributes *footerLayoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:sectionIndexPath];
    [attributesArr addObject:footerLayoutAttributes];
    [self setLastLayoutAttributes:footerLayoutAttributes];
  }
  if (self.totalHeightFirstLayout <= 0.0f) {
    self.totalHeightFirstLayout = self.totalHeightResultLayout;
  } else {
    self.totalHeightResultLayout = self.totalHeightFirstLayout;
  }
  self.layoutAttributesArray = [NSMutableArray arrayWithArray:attributesArr];
}

- (CGSize)collectionViewContentSize
{
  // 此处代码解决 CFCGameBetPlayScrollViewController 中下拉刷新时，ZJContentView 控件左右滑动问题
  if (self.totalHeightResultLayout < self.collectionView.bounds.size.height) {
    self.totalHeightResultLayout = self.collectionView.bounds.size.height + 1;
  }
  // 此处返回正常计算后 CollectionView 的 ContentSize
  return CGSizeMake(self.collectionView.bounds.size.width, self.totalHeightResultLayout);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
  return self.layoutAttributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
  
  if (self.totalHeightFirstLayout > 0.0f) {
    NSInteger index = [self indexOfLayoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    UICollectionViewLayoutAttributes *itemLayoutAttributes = self.layoutAttributesArray[index];
    layoutAttrs.frame = itemLayoutAttributes.frame;
  } else {
    CGFloat height = 0.0f;
    if (elementKind == UICollectionElementKindSectionHeader) {
      if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionHeaderForIndexPath:)]) {
        height = [_delegate heightOfSectionHeaderForIndexPath:indexPath];
      }
    } else {
      if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionFooterForIndexPath:)]) {
        height = [_delegate heightOfSectionFooterForIndexPath:indexPath];
      }
    }
    self.totalHeightResultLayout += height;
    
    CGFloat frameY = 0.0f;
    if (elementKind == UICollectionElementKindSectionHeader) {
      if (!self.lastLayoutAttributes) {
        frameY = 0.0f;
      } else {
        frameY = CGRectGetMaxY(self.lastLayoutAttributes.frame);
      }
    } else {
      frameY = CGRectGetMaxY(self.lastLayoutAttributes.frame) + _sectionInset.bottom;
    }
    layoutAttrs.frame = CGRectMake(0, frameY, self.collectionView.bounds.size.width, height);
  }
  
  return layoutAttrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  
  if (_delegate != nil && [_delegate respondsToSelector:@selector(numberOfColumnsInSectionForIndexPath:)]) {
    _columnsCount = [_delegate numberOfColumnsInSectionForIndexPath:indexPath];
  }
  
  if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfCellItemForCollectionViewAtIndexPath:)]) {
    _cellHeight = [_delegate heightOfCellItemForCollectionViewAtIndexPath:indexPath];
  }
  
  if (self.totalHeightFirstLayout > 0.0f) {
    NSInteger index = [self indexOfLayoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *itemLayoutAttributes = self.layoutAttributesArray[index];
    layoutAttributes.frame = itemLayoutAttributes.frame;
  } else {
    CGFloat frameY = CGRectGetMinY(self.lastLayoutAttributes.frame);
    CGFloat frameX = CGRectGetMaxX(self.lastLayoutAttributes.frame) + _margin;
    CGFloat cellWidth = (self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right - _margin * (_columnsCount-1)) / _columnsCount;
    CGFloat lastItemMaxX = CGRectGetMaxX(self.lastLayoutAttributes.frame) + _sectionInset.right;
    if (lastItemMaxX >= self.collectionView.frame.size.width) {
      frameX = _sectionInset.left;
      if (0 == indexPath.item) {
        frameY = CGRectGetMaxY(self.lastLayoutAttributes.frame) + _sectionInset.top;
      } else {
        frameY = CGRectGetMaxY(self.lastLayoutAttributes.frame) + _margin;
      }
      if (_columnsCount >= ([self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item)) {
        if (0 == indexPath.item) {
          self.totalHeightResultLayout += (_cellHeight + _sectionInset.top + _sectionInset.bottom);
        } else {
          self.totalHeightResultLayout += (_cellHeight + _sectionInset.bottom);
        }
      } else {
        if (0 == indexPath.item) {
          self.totalHeightResultLayout += (_cellHeight + _margin + _sectionInset.top);
        } else {
          self.totalHeightResultLayout += (_cellHeight + _margin);
        }
      }
    }
    layoutAttributes.frame = CGRectMake(frameX, frameY, cellWidth, _cellHeight);
  }
  
  return layoutAttributes;
}

- (NSInteger)indexOfLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = -1;
  NSInteger sectionCount = [self.collectionView numberOfSections];
  for (NSInteger i = 0; i < sectionCount; i++) {
    index++;
    if (elementKind == UICollectionElementKindSectionHeader) {
      if (i == indexPath.section) {
        return index;
      }
      NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
      index += itemCount + 1;
    } else {
      NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
      index  += itemCount + 1;
      if (i == indexPath.section) {
        return index;
      }
    }
  }
  return index;
}

- (NSInteger)indexOfLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = -1;
  NSInteger sectionCount = [self.collectionView numberOfSections];
  for (int i = 0; i < sectionCount; i++) {
    index ++;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
    if (i < indexPath.section) {
      index += itemCount;
    } else {
      for (int j = 0; j <= indexPath.row; j++) {
        index ++;
      }
      return index;
    }
    index ++;
  }
  return index;
}


@end

