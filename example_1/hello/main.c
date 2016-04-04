#include <stdio.h>
#include "functions.h"
#include "foo.h"


int main () {
	int num = 5;
	toSay("Hello,World!");
	printf("Fact(%i) = %i\n",num, toFact(num) );
	foo();
	return 0;
}

