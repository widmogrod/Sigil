@import <AppKit/CPView.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPGraphicsContext.j>
@import <AppKit/CPButton.j>

@import <Foundation/CPSet.j>

@import "../Sigil/SIElementManager.j";

@import "SIElement2.j";


@implementation SIOptionsView : CPView
{
}

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
	if (self)
	{
		var el2 = [[SIElement2 alloc] initWithFrame: CGRectMake(CGRectGetMinX(aFrame),
																CGRectGetMinY(aFrame), 120, 120)];
		[self addSubview: el2];
		
		/*
			Ustaw widok jako obserwator zmiany zaznaczenia
			pojedyńczego elementu
		*/
		[[CPNotificationCenter defaultCenter]
				addObserver:self
				   selector:@selector(elementDidChangeSelection:)
					   name:SIElementDidChangeSelectionNotification
	 			     object:nil];
	}

	return self;
}

/*
	Zestaw elementów wchodzących w skład SIDocument
*/
- (CPSet)elements
{
	var elements = [[[self window] windowController] elements];
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
	var selectedElements = [[[self window] windowController] selectedElements];
	if (!selectedElements)
	{
		selectedElements = [CPSet set];
	}

	return selectedElements;
}


- (void)viewWillDraw
{
	/* @var elements CPArray */
	var elements = [[self selectedElements] allObjects];

	for (var i=0; i < [elements count]; i++)
	{
		/* @var element SIElement */
		var element = [elements objectAtIndex:i];

		/*
			Tutaj dzieje się magia
			- element zwraca informacje jakie opcje dla elementu będą rysowane,
			- elementy są dodawane do tego widoku
			- ustawiane są odpowiednie opcje
		*/
		[SIElementManager element:element willDrawOptionsInView:self];
	}
}

- (void)drawRect:(CPRect)aRect
{
	
}

- (void)elementDidChangeSelection:(CPNotification)aNotification
{

	/*
		powinno zadziałać ponowne wyrenderowanie okna
	*/ 
	[self setNeedsDisplay:YES];
	
	//[self viewWillDraw];

	/* @var element SIElememt*/
	//var element = [aNotification object];
	/* @var selected BOOL */
	//var selected = [aNotification userInfo];

	//if ([element selected])
	//{
		/*
		[[CPNotificationCenter defaultCenter]
				addObserver:self
				   selector:@selector(controlTextDidChange:)
					   name:CPControlTextDidChangeNotification
	 			     object:element];*/
	//} else {
	//	[[CPNotificationCenter defaultCenter] removeObserver:self];
	//}
}

/*
- (void)controlTextDidChange:(CPNotification)aNotification
{
	// @var textElement CPTextField
	var textElement = [aNotification object];
	console.log([aNotification userInfo]);
	var value  = [textElement value];
}
*/

@end
