//
//  ViewController.m
//  OpenMovieDatabaseAPIObjC
//
//  Created by Jeremiah Hawks on 3/2/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

#import "ViewController.h"
#import "MovieController.h"

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *moviesPlaceholder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MovieController *mc = [[MovieController alloc] init];
    [mc fetchMoviesWithSearchTerm:@"Jaws" completion:^(NSMutableArray *movies, NSError *error) {
        NSMutableArray *moviesPlaceholder = movies;
        NSLog(@"something");
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
