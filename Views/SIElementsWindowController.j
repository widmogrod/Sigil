@import <AppKit/CPWindowController.j>

@import "SIElementsView.j"

@implementation SIElementsWindowController: CPWindowController
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
		// bardzo się naszukałem tego cudeńka ;)
		// akceptowane są ruchy myszy (wydajność!)
		[theWindow setAcceptsMouseMovedEvents:YES];
		
		// Pobierz wymiary okna przeglądarki
		var platformBounds = [[theWindow platformWindow] nativeContentRect];

		// Pozycjonowaniue CPWindow w odpowiednim miejscu
		[theWindow setFrameOrigin:CGPointMake(SISitebarLeftWidth, SIToolbarAndMenubarHeight)];
		[theWindow setFrameSize:CGSizeMake(CGRectGetWidth(platformBounds) - SISitebarLeftWidth, 
										   CGRectGetHeight(platformBounds) - SIToolbarAndMenubarHeight)];


		// Okno bedzie się rozszerzać w wysokości i szerokości
		[theWindow setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];	

		// Pobierz aktualne bounds (ważne że po pozycjonowaniu okna głównego)
		var bounds = [contentView bounds];

		// Dodaj widok, w którym będą renderowane elementy
		var contentArea = [[SIElementsView alloc] initWithFrame:CGRectMake(10, 10,
																	CGRectGetWidth(bounds)-20,
																	CGRectGetHeight(bounds)-20)];
		// zachowuj sie elastycznie
		[contentArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];


		// elementy potrzebne tylko by wyróżnić...
		[contentView setBackgroundColor:[CPColor greenColor]];
		//[contentArea setBackgroundColor:[CPColor redColor]];
		
		// dodaj element remnderujący elementy do widoku
		[contentView addSubview:contentArea];
		
		// teraz zwraca NO .. ale na chwilę obecną nie jest potrzebne
		//console.log([theWindow makeFirstResponder:contentArea]);
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

/*
	Zwracanie zestawu elementów, które są zaznaczone
*/
- (CPSet)selectedElements
{
	var selectedElements = [[self document] selectedElements];
	if (!selectedElements)
	{
		selectedElements = [CPSet set];
	}

	return selectedElements;
}

@end
