//
//  SubscribeTokenViewController.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 03.03.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "SubscribeTokenViewController.h"
#import "SubscribeTokenDataSourceDelegate.h"
#import "SubscribeTokenCoordinator.h"
#import "UIImage+Extension.h"
#import "TockenCell.h"

@interface SubscribeTokenViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SubscribeTokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self configSearchBar];
    [self updateTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kTokenDidChange object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Configuration

-(void)configTableView{
    self.tableView.dataSource = self.delegateDataSource;
    self.tableView.delegate = self.delegateDataSource;
}

-(void)configSearchBar{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(8,0, self.view.frame.size.width - 16, 28)];
    view.backgroundColor = customBlackColor();
    UIImage *img = [UIImage changeViewToImage:view];
    [self.searchBar setSearchFieldBackgroundImage:img forState:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed: @"Icon-search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}

#pragma mark - Private Methods

-(void)updateTable{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

#pragma mark - Accesers 

- (IBAction)actionBack:(id)sender {
    [self.delegate didBackButtonPressed];
}
- (IBAction)didPressesAddNewAction:(id)sender {
//    [self.delegate didAddNewPressed];
}

- (void)tableView:(UITableView *)tableView didSelectContract:(Contract *) contract {
    [self.delegate didSelectContract:contract];
}


@end
