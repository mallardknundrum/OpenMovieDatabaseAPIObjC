//
//  Movie.h
//  OpenMovieDatabaseAPIObjC
//
//  Created by Jeremiah Hawks on 3/2/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

- (instancetype)initWithTitle:(NSString *)title year:(NSString *)year imageURLString:(NSString *)imageURLStirng;
- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)jsonDictionary;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *imageURLString;
@property (nonatomic, copy) UIImage *movieImage;

@end
