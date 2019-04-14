

	.FUNCT	GO
START::

?FCN:	PUTB	P-LEXV,0,59
	CALL	QUEUE,I-WIZARD,4
	PUT	STACK,0,1
	CALL	QUEUE,I-LANTERN,200
	PUTP	BALLOON,P?VTYPE,NONLANDBIT
	PUTP	BUCKET,P?VTYPE,NONLANDBIT
	PUTP	SEWL,P?SIZE,P?EAST
	PUTP	SWWL,P?SIZE,P?WEST
	PUTP	SSWL,P?SIZE,P?SOUTH
	PUTP	SNWL,P?SIZE,P?NORTH
	SET	'LIT,TRUE-VALUE
	SET	'WINNER,ADVENTURER
	SET	'PLAYER,ADVENTURER
	SET	'HERE,INSIDE-BARROW
	SET	'P-IT-OBJECT,FALSE-VALUE
	FSET?	HERE,TOUCHBIT /?CND1
	CALL	V-VERSION
	CRLF	
?CND1:	MOVE	WINNER,HERE
	CALL	V-LOOK
	CALL	MAIN-LOOP
	JUMP	?FCN


	.FUNCT	HEDGES-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The hedges are shaped like various animals: dogs, serpents, dragons, and the like, and they are vaguely troubling to look at."


	.FUNCT	LT-CRACK-PSEUDO
	EQUAL?	PRSA,V?THROUGH,V?BOARD \?ELS5
	CALL	DO-WALK,P?SOUTH
	RTRUE	
?ELS5:	CALL	CC-CRACK-PSEUDO
	RSTACK	


	.FUNCT	CC-CRACK-PSEUDO
	EQUAL?	PRSA,V?BOARD,V?THROUGH \?ELS5
	CALL	DO-WALK,P?NORTH
	RTRUE	
?ELS5:	PRINTR	"The crack is fairly wide. You should be able to get into it."


	.FUNCT	GLOBAL-MENHIR-F
	PRINTR	"It's not here."


	.FUNCT	GLOBAL-CERBERUS-F
	PRINTR	"He's not here."


	.FUNCT	CRACK-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It is a small crack (as advertised) with no redeeming value."


	.FUNCT	ALICE-HOLE
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The hole is very small. You could never enter it."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS9
	PRINTR	"You can't see what's beyond the hole from here."
?ELS9:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTR	"It doesn't fit through the hole."


	.FUNCT	SLOT-F
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	FIRST?	SLOT /?ELS5
	PRINTR	"There's nothing in the hole."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The oblong hole has been chipped out of the box, probably by someone wanting whatever is inside the box. The attempt was a pathetic failure, however."


	.FUNCT	TEAPOT-F
	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"The teapot has no lid."


	.FUNCT	ROSE-F
	EQUAL?	PRSA,V?SMELL \?ELS5
	PRINTR	"Unlike your efforts here, it comes out smelling like a rose."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"A rose is a rose is a rose...."


	.FUNCT	FOOTPAD-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"A footpad is a thief."


	.FUNCT	COMPASS-F
	EQUAL?	PRSA,V?FIND \?ELS5
	PRINTR	"It's on your person. And lucky for you, or you would become hopelessly lost."
?ELS5:	EQUAL?	PRSA,V?OVERBOARD,V?THROW,V?DROP \?ELS9
	PRINTR	"You can't get rid of it. It is an extension of yourself."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTR	"It's one of those gizmos with a needle and a card with the eight major compass directions. Simple, but effective."
?ELS13:	EQUAL?	PRSA,V?READ \?ELS17
	PRINTR	"It doesn't make very interesting reading - just the compass directions."
?ELS17:	PRINTR	"You can't do that. And don't bother to ask why."

	.ENDI
