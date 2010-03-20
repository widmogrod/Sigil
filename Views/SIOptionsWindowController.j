@import <AppKit/CPWindowController.j>
@import <AppKit/CPView.j>

@import "SIOptionsView.j";

@implementation SIOptionsWindowController: CPWindowController
{}

- (void) init
{
	// Utwórz okno bez obramowań
	var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero()
												styleMask:CPBorderlessWindowMask],
		contentView = [theWindow contentView];
	

	self = [super initWithWindow:theWindow];
	if (self)
	{
		// Pobierz wymiary okna przeglądarki
		var platformBounds = [[theWindow platformWindow] nativeContentRect];

		// Pozycjonowaniue CPWindow w odpowiednim miejscu
		[theWindow setFrameOrigin:CGPointMake(0, SIToolbarAndMenubarHeight)];
		[theWindow setFrameSize:CGSizeMake(SISitebarLeftWidth, 
										   CGRectGetHeight(platformBounds) - SIToolbarAndMenubarHeight)];


		// Okno bedzie się rozszerzać w wysokości i szerokości
		[theWindow setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];	

		// Pobierz aktualne bounds (ważne że po pozycjonowaniu okna głównego)
		var bounds = [contentView bounds];

		// Dodaj widok, w którym będą renderowane elementy
		var contentArea = [[SIOptionsView alloc] initWithFrame:CGRectMake(10, 10,
																	CGRectGetWidth(bounds)-20,
																	CGRectGetHeight(bounds)-20)];
		// zachowuj sie elastycznie
		[contentArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];


		// elementy potrzebne tylko by wyróżnić...
		[contentView setBackgroundColor:[CPColor greenColor]];
		[contentArea setBackgroundColor:[CPColor redColor]];
		
		// dodaj element remnderujący elementy do widoku
		[contentView addSubview:contentArea];
	}

	return self;
}

/*
	Zestaw elementów wchodzących w skład SIDocument
*/
- (CPSet)elements
{
	var elements = [[self document] elements];
	if (!elements)
	{
		elements = [CPSet set];
	}

	return elements;
}

@end
