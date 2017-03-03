//
//  Movie.m
//  OpenMovieDatabaseAPIObjC
//
//  Created by Jeremiah Hawks on 3/2/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title year:(NSString *)year imageURLString:(NSString *)imageURLStirng
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _imageURLString = [imageURLStirng copy];
        _year = [year copy];
    }
    return self;
}

@end

@implementation Movie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)jsonDictionary
{
    NSString *title = jsonDictionary[@"Title"];
    NSString *year = jsonDictionary[@"Year"];
    NSString *imageURLString = jsonDictionary[@"Poster"];
    if(!title || !year || !imageURLString) {
        NSLog(@"Error: missing information");
        return nil;
    }
    return [self initWithTitle:title year:year imageURLString:imageURLString];
}

@end
