//
//  FirstViewController.m
//  FBASMR
//
//  Created by François Blanc on 20/04/2016.
//  Copyright © 2016 François Blanc. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "FBVideoCell.h"
#import "FBYTVideo.h"
#import "FBYTVideoManager.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import "A2DynamicDelegate.h"

@interface FirstViewController () <UITableViewDataSource, UITableViewDelegate>

@property (atomic,    strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *videos;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"List"];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setFrame:self.view.bounds];
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.tableView registerClass:FBVideoCell.class forCellReuseIdentifier:@"cell"];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    [self loadVideos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadVideos
{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
    
    [[FBYTVideoManager sharedVideoManager] fetchVideoswithBlock:^(NSArray *videos, NSError *error) {
    
        if (error)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Database System"
                                                                message:@"The system seems to be offline."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:nil];
            [alertView show];
            //NSLog(@"Error %@; %@", error, [error localizedDescription]);
        }
        else
        {
            [self setVideos:videos];
        }
        
        [HUD dismiss];
    }];
}

- (void)setVideos:(NSArray *)videos
{
    self->_videos = videos;
    // A chaque fois que la liste de videos est mise à jour on force le tableView à se mettre à jour pour que les deux restent bien synchronisés
    [self.tableView reloadData];
}

#pragma mark - TableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Récupération dde la vidéo
    FBYTVideo *video = self.videos[indexPath.row];
    
    // On demande au tableView une cellule disponible avec l'identifiant "cell"
    FBVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // On met à jour les éléments affichés par la cellule à l'aide de l'objet Vidéo que l'on veut représenter
    [cell setVideo:video];
    
    // On retourne la cellule au tableView pour qu'il puisse l'afficher
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Récupération du tweet associé à la cellule qui vient d'etre sélectionnée
    FBYTVideo *video = self.videos[indexPath.row]; // Ation
    
    // Création du VC qui va afficher les détails de ce tweet
    SecondViewController *detailViewController = [[SecondViewController alloc] init];
    
    // On dit au VC de détails quel tweet il va afficher
    [detailViewController setVideo:video];
    
    // On ajoute le VC de détail sur la pile de navigation, ce qui demande au navigationController de l'afficher à la place du VC actuel
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBYTVideo *video = self.videos[indexPath.row];
    return [FBVideoCell cellHeightForVideo:video andWidth:tableView.bounds.size.width];
    //return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
