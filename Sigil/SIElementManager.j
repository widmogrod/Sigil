@import <Foundation/CPObject.j>

/*
	Klasa zarządzająca i wspomagająca pewne operacje
	na elementach widoku ...
		    
*/
@implementation SIElementManager : CPObject
{}

/*
	Sprawdza czy punk zawiera się w kwadraturze elementu (w polu elementu)
*/
+ (BOOL)element:(SIElement)anElement containsPoint:(CGPoin)aPoint
{
	// sprawdź czy punk jest w polu obiektu
	return CGRectContainsPoint([anElement rect], aPoint);
}

/*
	Renderowanie opcji dla zaznaczonych elementów w przekazanym widoku

	TODO: Dodać możliwość generowania opcji dla kilku zaznaczonych elementów
*/
+ (void)element:(SIElement)anElement willDrawOptionsInView:(SIOptionsView)aView
{
	/* options CPArray*/
	var options = [anElement elementOptions];
	for(var i=0; i < [options count]; i++)
	{
		/* option SIOption */
		var option = [options objectAtIndex:i];

		/*
			Rysowanie opcji - cała magia.. ;P
		*/
		[option willDrawInView:aView];
	}
}
@end
