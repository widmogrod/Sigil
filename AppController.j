@import <Foundation/CPObject.j>

@import "SIMenu.j"

var ToolbarItemUndo = "ToolbarItemUndo",
	ToolbarItemRedo = "ToolbarItemRedo",
	ToolbarItemAddText = "ToolbarItemAddText",
	ToolbarItemAddImage = "ToolbarItemAddImage",
	ToolbarItemAlignLeft = "ToolbarItemAlignLeft",
	ToolbarItemAlignCenter = "ToolbarItemAlignCenter",
	ToolbarItemAlignRight = "ToolbarItemAlignRight",
	ToolbarItemPreview = "ToolbarItemPreview",
	ToolbarItemOrder = "ToolbarItemOrder";

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // The end result of this layout will be the kind of master/detail/auxilliary view
    // found in iTunes, Mail, and many other apps.

	var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView],
        toolbar = [[CPToolbar alloc] initWithIdentifier:"Photos"],
        bounds = [contentView bounds];

	// Menu główne applikacji
    var mainMenu = [[SIMenu alloc] initWithDelegate:self];
    [[CPApplication sharedApplication] setMainMenu:mainMenu];
    
    //we tell the toolbar that we want to be its delegate and attach it to theWindow
    [toolbar setDelegate:self];
	[toolbar setVisible:YES];
	[theWindow setToolbar:toolbar];
    
    var navigationArea = [[CPView alloc] initWithFrame:CGRectMake(0.0, 0.0, 150.0, CGRectGetHeight([contentView bounds]) - 150.0)];
    
    [navigationArea setBackgroundColor:[CPColor redColor]];
    
    // This view will grow in height, but stay fixed width attached to the left side of the screen.
    [navigationArea setAutoresizingMask:CPViewHeightSizable | CPViewMaxXMargin];
    
    [contentView addSubview:navigationArea];

    var metaDataArea = [[CPView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY([navigationArea frame]), 150.0, 150.0)];
    
    [metaDataArea setBackgroundColor:[CPColor greenColor]];
    
    // This view will stay the same size in both directions, and fixed to the lower left corner.
    [metaDataArea setAutoresizingMask:CPViewMinYMargin | CPViewMaxXMargin];
    
    [contentView addSubview:metaDataArea];

    var contentArea = [[CPView alloc] initWithFrame:CGRectMake(150.0, 0.0, CGRectGetWidth([contentView bounds]) - 150.0, CGRectGetHeight([contentView bounds]))];
    
    [contentArea setBackgroundColor:[CPColor blueColor]];
    
    // This view will grow in both height an width.
    [contentArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [contentView addSubview:contentArea];
    
    [theWindow orderFront:self];
}

/*
    Wszystkie elementy, które są dostępne na pasku narzędzi.
    Kolejnośc elementów określa ich kolejność występowania na pasku narzędzi.
*/
-(CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)toolbar
{
	// mogę zstowować [].. ale w ramach nauki Objective-J wybieram ten sposób
	return new [CPArray arrayWithObjects: ToolbarItemUndo,
										  ToolbarItemRedo,

										  CPToolbarFlexibleSpaceItemIdentifier,
										  
										  ToolbarItemAddText,
										  ToolbarItemAddImage,

										  CPToolbarSpaceItemIdentifier,

										  ToolbarItemAlignLeft,
										  ToolbarItemAlignCenter,
										  ToolbarItemAlignRight,
										  
										  CPToolbarFlexibleSpaceItemIdentifier,
										  
										  ToolbarItemPreview,
										  
										  CPToolbarSpaceItemIdentifier,
										  
										  ToolbarItemOrder];
}

/*
    Elementy, które będa wyświetlane na pasku narzędzi.
 */  
-(CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)toolbar
{
	// mogę zstowować [].. ale w ramach nauki Objective-J wybieram ten sposób
	return new [CPArray arrayWithObjects: ToolbarItemUndo,
										  ToolbarItemRedo,

										  ToolbarItemAddText,
										  ToolbarItemAddImage,
										  
										  ToolbarItemPreview,
										  ToolbarItemOrder,
										  
										  ToolbarItemAlignLeft,										  
										  ToolbarItemAlignCenter,
										  ToolbarItemAlignRight,

										  CPToolbarFlexibleSpaceItemIdentifier,
										  CPToolbarSpaceItemIdentifier];
}

/*
    Tworzenie elemtnów paska narzędi.


    Cappuccino implementuje jeszcze domyślne kilka innych elemtnów,
    które można utworzyć za w nastęþujący sposób:
    
       CPToolbarItem _standardItemWithItemIdentifier 
    
    Elementy zdefiniowane i zaimplementowane:

       - CPToolbarSeparatorItemIdentifier		- separator ([2,100000])
       - CPToolbarSpaceItemIdentifier 			- pojedyńczy element
       - CPToolbarFlexibleSpaceItemIdentifier:  - płynny separator (rozszerza pasek na szerokość [32, 100000])

	Elementy zdefiniowane ale nie zaimplementowane:

	   - CPToolbarShowColorsItemIdentifier
       - CPToolbarShowFontsItemIdentifier
	   - CPToolbarCustomizeToolbarItemIdentifier
	   - CPToolbarPrintItemIdentifier
*/
- (CPToolbarItem)toolbar:(CPToolbar)toolbar itemForItemIdentifier:(CPString)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	var item = [CPToolbarItem _standardItemWithItemIdentifier:itemIdentifier];
	if (nil === item)
	{
		item = [[CPToolbarItem alloc] initWithItemIdentifier:ToolbarItemUndo];
	}

	switch(itemIdentifier)
	{
		case ToolbarItemUndo:
			[item setLabel:@"Cofinij"];
			[item setToolTip:@"Cofnij zmiany"];
			
			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/undo.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/undo_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemRedo:
			[item setLabel:@"Ponów"];
			[item setToolTip:@"Ponów zmiany"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/redo.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/redo_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemAddText:
			[item setLabel:@"Dodaj tekst"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/add_text.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/add_text_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemAddImage:
			[item setLabel:@"Dodaj grafikę"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/add_image.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/add_image_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemPreview:
			[item setLabel:@"Podgląd"];
			[item setToolTip:@"Zobacz projekt w orginalnych rozmiarach"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/preview.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/preview_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemOrder:
			[item setLabel:@"Zamów"];
			[item setToolTip:@"Zamów ten projekt pieczątki"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/order.png" size:CPSizeMake(32, 32)],
				imageAlternate = [[CPImage alloc] initWithContentsOfFile:"Resources/order_alternate.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemAlignLeft:
			[item setLabel:@"Do lewej"];
			[item setToolTip:@"Wyrównaj do lewej"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/align_left.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			//[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemAlignCenter:
			[item setLabel:@"Wyśrodkuj"];
			[item setToolTip:@"Wyśrodkuj"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/align_center.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			//[item setAlternateImage:imageAlternate];
			break;

		case ToolbarItemAlignRight:
			[item setLabel:@"Do prawej"];
			[item setToolTip:@"Wyrównaj do prawej"];

			var image = [[CPImage alloc] initWithContentsOfFile:"Resources/align_right.png" size:CPSizeMake(32, 32)];
			
			[item setImage:image];
			//[item setAlternateImage:imageAlternate];
			break;

	}

	return item;
}

@end
