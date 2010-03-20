@import <AppKit/CPView.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPGraphicsContext.j>
@import <AppKit/CPButton.j>

@import <Foundation/CPSet.j>

//@import "../Sigil/SIElementManager.j";


@implementation SIOptionsView : CPView
{
	CPTextField _textField;
}

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
	if (self)
	{
		_textField =  [[CPTextField alloc] initWithFrame:CGRectMake(0,0,150,40)]; 
		[_textField setEditable:YES];
		[_textField setBezeled:YES];
		
		[self addSubview:_textField];

		//[[CPNotificationCenter defaultCenter] postNotificationName:CPControlTextDidChangeNotification object:self userInfo

/*
		[[CPNotificationCenter defaultCenter]
				addObserver:self
				   selector:@selector(elementDidChangeSelection:)
					   name:SIElementDidChangeSelectionNotification
	 			     object:nil];

*/	
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

- (void)viewWillDraw
{

}

/*
- (void)drawRect:(CPRect)aRect
{	
}
*/

- (void)elementDidChangeSelection:(CPNotification)aNotification
{
	/* @var element SIElememt*/
	var element = [aNotification object];
	var value  = [element value];

	if ([element selected])
	{
		/*
		[[CPNotificationCenter defaultCenter]
				addObserver:self
				   selector:@selector(controlTextDidChange:)
					   name:CPControlTextDidChangeNotification
	 			     object:element];*/
	} else {
		[[CPNotificationCenter defaultCenter] removeObserver:self];
	}
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
