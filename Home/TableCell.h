/*
 * Copyright Ricoh Company, Ltd. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface TableCell : UICollectionViewCell

@property (nonatomic) uint32_t objectIndex;
@property (weak, nonatomic) IBOutlet UIImageView *collectionViewImage;

@end
