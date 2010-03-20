@import "SIElement.j"

@implementation SIElementText : SIElement
{
	CPTextField _textField;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		_textField =  [[CPTextField alloc] initWithFrame:CGRectMakeZero()]; 
	}

	return self;
}

- (void)viewWillDrawInView:(SIElementsView)anView
{
	[_textField setFrame: [self rect]];
	
	/*
		TODO: Czy poniższe elemnty nie powinny być owiniete w metodę z lazy load?
			  - Być może tak i do tego funkcjonalność rysowania powinna również
			    zostać zaimplementowana w {@see SIElement};
	*/
	[_textField setObjectValue:value]; 
	[_textField setBezeled:YES]; 
    [_textField setEditable:NO]; 
    [_textField sizeToFit];
    
	[anView addSubview:_textField];
}

@end