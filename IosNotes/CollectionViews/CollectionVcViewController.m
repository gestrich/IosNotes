//
//  CollectionVcViewController.m
//  IosNotes
//
//  Created by William Gestrich on 4/16/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "CollectionVcViewController.h"
#import "CollectionViewCell.h"
#import "SupplementaryView.h"

static NSString *cellIdentifier = @"cell_identifier";
static NSString *SupplementaryViewIdentifier = @"SupplementaryViewIdentifier";

@interface CollectionVcViewController ()

@property (nonatomic, strong, readwrite) NSArray *photosList;
@property (nonatomic, strong, readwrite)  NSMutableDictionary *photosCache;
@end

@implementation CollectionVcViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[SupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryViewIdentifier];
    NSError *error;
    NSArray * directoryList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self photosDirectory] error:&error];
    
    NSMutableArray *photosList = [NSMutableArray array];
    for( NSString* fileName in directoryList){
        if([fileName.pathExtension isEqualToString:@"png"] ||
           [fileName.pathExtension isEqualToString:@"jpg"] ){
            [photosList addObject:fileName];
        }
    }
    self.photosList = photosList;
    self.photosCache = [NSMutableDictionary dictionary];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photosList count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    CollectionViewCell *cell;
    cell = (CollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *photoName = [self.photosList objectAtIndex:indexPath.row];
    
    UIImage *thumbImage = [self.photosCache objectForKey:photoName];
    
    cell.imageView.image = thumbImage;
    
    if(!thumbImage){
        [self drawImage:cell.imageView photoName:photoName];
        
    }
    return cell;
}


-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SupplementaryViewIdentifier forIndexPath:indexPath];
}


#pragma - UICollectionViewDelegate
-(BOOL) collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *detailController = [[UIViewController alloc] init];
    detailController.view.frame = self.view.frame;
    
    //Add toolbar with back button
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0,0,320,50}];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    [backButton setTarget:self];
    [backButton setAction:@selector(dismissModal:)];
    toolbar.backgroundColor = [UIColor redColor];
    toolbar.items = @[backButton];
    [detailController.view addSubview:toolbar];
    
    //Set the photo
    NSString *photoName = [self.photosList objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:detailController.view.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [detailController.view addSubview:imageView];
    [self drawImage:imageView photoName:photoName];
    [self presentViewController:detailController animated:YES completion:nil];
}

-(void)dismissModal:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Helper

-(NSString*)photosDirectory{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Boo"];
    
}

-(void)drawImage:(UIImageView*)imageView photoName:(NSString*)photoName{
    
    
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
            ^{
                //Creates image at full size
                //Then assigns to the UIImageView which scales it
            NSString *photoFilePath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
            UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
                
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:(CGRect){0,0,image.size}];
                          
            UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
                          
            UIGraphicsEndImageContext();
                          
            dispatch_async(dispatch_get_main_queue(), ^{
                              
                imageView.image = thumbImage;
                [self.photosCache setObject:thumbImage forKey:photoName];
                          });
            }
        );
    
    
}

@end
