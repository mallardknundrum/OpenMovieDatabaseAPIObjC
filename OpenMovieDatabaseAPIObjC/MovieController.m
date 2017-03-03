//
//  MovieController.m
//  OpenMovieDatabaseAPIObjC
//
//  Created by Jeremiah Hawks on 3/2/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

#import "MovieController.h"
#import "Movie.h"

@interface MovieController ()

@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, copy) NSMutableArray *movies;


@end

@implementation MovieController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = @"http://www.omdbapi.com/";
    }
    return self;
}

- (void)fetchMoviesWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSMutableArray *movies, NSError *error))completion
{
    // Build url
    NSURL *baseURL = [NSURL URLWithString:[self baseURL]];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"s" value:searchTerm];
    NSURLQueryItem *dataTypeItem = [NSURLQueryItem queryItemWithName:@"r" value:@"json"];
    urlComponents.queryItems = @[searchItem, dataTypeItem];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"url: %@", url.description);
    
    dispatch_group_t group = dispatch_group_create();
    Movie *movie = [[Movie alloc] init];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    dispatch_group_enter(group);
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        }
        if (!data) {
            NSLog(@"Error: no data returned from the data task");
            completion(nil, error);
        }
        NSArray *moviesDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!moviesDictionary || ![moviesDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: could not parse JSON correctly");
            completion(nil, error);
        }
        NSArray *moviesArray = [moviesDictionary valueForKey:@"Search"];
        for (NSDictionary *dictionary in moviesArray) {
            dispatch_group_enter(group);
            Movie *movieInitialized = [movie initWithDictionary:dictionary];
            NSURL *imageURL = [NSURL URLWithString:[movieInitialized imageURLString]];
            NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:imageURL resolvingAgainstBaseURL:YES];
            NSURL *url = urlComponents.URL;

            NSLog(@"imageURL: %@", imageURL);
            [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                }
                if (!data) {
                    NSLog(@"Error: No data returned from photo data task");
                } else {
                    UIImage *movieImage = [[UIImage alloc] initWithData:data];
                    movieInitialized.movieImage = movieImage;
                    [mArray addObject:movieInitialized];
                    dispatch_group_leave(group);
                }
            }]resume];
        }
        dispatch_group_leave(group);
        
    }]resume];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    completion(mArray, nil);
};

@end



























