//
//  MovieController.h
//  OpenMovieDatabaseAPIObjC
//
//  Created by Jeremiah Hawks on 3/2/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieController : NSObject

@property (nonatomic) NSArray *moviesArray;

- (void)fetchMoviesWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSMutableArray *, NSError *error))completion;

@end
