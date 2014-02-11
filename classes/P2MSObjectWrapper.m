//
//  P2MSObjectWrapper.m
//  P2MSStoryboard
//
//  Created by PYAE PHYO MYINT SOE on 21/12/13.
//  Copyright (c) 2013 PYAE PHYO MYINT SOE. All rights reserved.
//

#import "P2MSObjectWrapper.h"

@implementation P2MSObjectWrapper

+ (NSArray *)getNormalImages:(NSString *)imgString{
    return [imgString componentsSeparatedByString:@"##"];
}

+ (NSArray *)getDraggableImages:(NSString *)imgString{
    return [imgString componentsSeparatedByString:@"##"];
}

+ (NSString *)generateUniqueID{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+ (CGRect)getRectFromString:(NSString *)rectStr withParentView:(UIView *)parentView{
    NSArray *arr = [rectStr componentsSeparatedByString:@","];
    if (arr.count < 4) {
        return CGRectNull;
    }
    CGFloat stX = [self getPosFromString:[arr objectAtIndex:0] withParentView:parentView];
    CGFloat stY = [self getPosFromString:[arr objectAtIndex:1] withParentView:parentView];
    CGFloat width = [[arr objectAtIndex:2] floatValue];
    CGFloat height = [[arr objectAtIndex:3] floatValue];
    return CGRectMake(stX, stY, width, height);
}

+ (CGRect)getRectFromPoint:(NSString *)pointStr andSize:(NSString *)sizeStr withParentView:(UIView *)parentView{
    CGPoint pos = [self getPointFromString:pointStr withParentView:parentView];
    CGSize sizePoint = CGSizeFromString([NSString stringWithFormat:@"{%@}", sizeStr]);
    return CGRectMake(pos.x, pos.y, sizePoint.width, sizePoint.height);
    
//    NSString *str = [NSString stringWithFormat:@"{{%@},{%@}}", pointStr, sizeStr];
//    return CGRectFromString(str);
}

+ (CGFloat)getPosFromString:(NSString *)posStr withParentView:(UIView *)parentView{
    if ([posStr hasSuffix:@"%"]) {
        NSString *tempX = [posStr substringToIndex:posStr.length-1];
        return parentView.bounds.size.width * [tempX floatValue]/100.0f ;
    }else
        return [posStr floatValue];
}

+ (CGFloat)getScaleValueFromString:(NSString *)posStr withOriginalWidth:(CGFloat)originalWidth{
    if ([posStr hasSuffix:@"%"]) {
        NSString *tempX = [posStr substringToIndex:posStr.length-1];
        return originalWidth*[tempX floatValue];
    }else
        return [posStr floatValue];
}

+ (CGPoint)getPointFromString:(NSString *)pointStr withParentView:(UIView *)parentView{
    NSArray *arr = [pointStr componentsSeparatedByString:@","];
    NSString *startX = [arr objectAtIndex:0];
    NSString *startY = [arr objectAtIndex:1];
    CGFloat stX = [self getPosFromString:startX withParentView:parentView];
    CGFloat stY = [self getPosFromString:startY withParentView:parentView];
    return CGPointMake(stX, stY);
}

@end
