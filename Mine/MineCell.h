//
//  MineCell.h
//  Encropy
//
//  Created by Lqq on 2019/4/24.
//  Copyright © 2019年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger {
    TopCell = 0,
    MiddleCell,
    BottomCell
    
} MineCellLocationStyle;

NS_ASSUME_NONNULL_BEGIN

@interface MineCell : UITableViewCell
- (void)refreshUIWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle accessoryHidden:(BOOL)accessoryHidden;




@end

NS_ASSUME_NONNULL_END
