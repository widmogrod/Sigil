@import "SIOption.j"

/*
		    
*/
@implementation SIOptionText : SIOption
{
	CPTextField _textField;
}

- (id)initWithElement:(SIElement)anElement
{
	self = [super init];
	if (self)
	{
		height = 25.0;

		_textField =  [[CPTextField alloc] initWithFrame:CGRectMake(0,0,150, height)]; 
		[_textField setEditable:YES];
		[_textField setBezeled:YES];
		[_textField setDelegate:self];
		
		[_textField setObjectValue:[anElement value]];

		[self setElement:anElement];
	}

	return self;
}


- (void)controlTextDidBeginEditing:(CPNotification)aNotification
{
	//console.log([[aNotification object] objectValue], "-- controlTextDidBeginEditing");
}

- (void)controlTextDidChange:(CPNotification)aNotification
{
	//console.log([[aNotification object] objectValue], "-- controlTextDidBeginEditing");
}

- (void)controlTextDidEndEditing:(CPNotification)aNotification
{
	[_element setValue:[[aNotification object] objectValue]];
	//console.log([[aNotification object] objectValue], "-- controlTextDidEndEditing");
}

- (void)willDrawInView:(SIOptionsView)aView
{
	[aView addSubview:_textField];
}

@end
