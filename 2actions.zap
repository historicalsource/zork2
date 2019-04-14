

	.FUNCT	SWORD-FCN
	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	WINNER,ADVENTURER \FALSE
	CALL	QUEUE,I-SWORD,-1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-SWORD,DEM,NG=0,G,P,TX,L
	CALL	INT,I-SWORD >DEM
	SET	'G,SWORD-GLOW
	IN?	SWORD,ADVENTURER \?ELS5
	CALL	INFESTED?,HERE
	ZERO?	STACK /?ELS8
	SET	'NG,2
	JUMP	?CND6
?ELS8:	SET	'P,0
?PRG11:	NEXTP	HERE,P >P
	ZERO?	P \?ELS15
	JUMP	?CND6
?ELS15:	LESS?	P,LOW-DIRECTION /?PRG11
	GETPT	HERE,P >TX
	PTSIZE	TX >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG11
	GETB	TX,0
	CALL	INFESTED?,STACK
	ZERO?	STACK /?PRG11
	SET	'NG,1
?CND6:	EQUAL?	NG,G /FALSE
	EQUAL?	NG,2 \?ELS28
	PRINTI	"Your sword has begun to glow very brightly."
	CRLF	
	JUMP	?CND24
?ELS28:	EQUAL?	NG,1 \?ELS32
	PRINTI	"Your sword is glowing with a faint blue glow."
	CRLF	
	JUMP	?CND24
?ELS32:	ZERO?	NG \?CND24
	PRINTI	"Your sword is no longer glowing."
	CRLF	
?CND24:	SET	'SWORD-GLOW,NG
	RTRUE	
?ELS5:	PUT	DEM,C-ENABLED?,0
	RFALSE	


	.FUNCT	INFESTED?,R,F
	FIRST?	R >F /?KLU12
?KLU12:	
?PRG1:	ZERO?	F /FALSE
	FSET?	F,ACTORBIT \?ELS7
	FSET?	F,INVISIBLE /?ELS7
	EQUAL?	F,ROBOT /?ELS7
	RETURN	F
?ELS7:	NEXT?	F >F /?PRG1
	RFALSE	


	.FUNCT	CAROUSEL-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are in a large circular room whose high ceiling is lost in gloom. Eight identical passages leave the room."
	CRLF	
	ZERO?	CAROUSEL-FLIP-FLAG \TRUE
	PRINTR	"A loud whirring sound comes from all around, and you feel sort of disoriented in here."
?ELS5:	ZERO?	CAROUSEL-FLIP-FLAG \FALSE
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	PRSO,P?UP,P?DOWN /FALSE
	EQUAL?	PRSO,P?OUT \?ELS22
	PRINTI	"Feeling dizzy, you pick a direction at random."
	CRLF	
	CRLF	
	SET	'PRSO,P?EAST
	JUMP	?CND20
?ELS22:	PRINTI	"You're not sure which direction is which. This room is very disorienting."
	CRLF	
	CRLF	
?CND20:	EQUAL?	PRSO,P?WEST /?THN32
	RANDOM	100
	GRTR?	80,STACK \?CND29
?THN32:	RANDOM	7
	SUB	STACK,1
	GET	EIGHT-DIRECTIONS,STACK >PRSO
?CND29:	CALL	V-WALK
	RTRUE	


	.FUNCT	VIOLIN-FCN
	EQUAL?	PRSA,V?PLAY \FALSE
	EQUAL?	PRSO,VIOLIN \FALSE
	PRINTR	"An amazingly offensive noise issues from the violin."


	.FUNCT	OPEN-CLOSE,OBJ,STROPN,STRCLS
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	OBJ,OPENBIT \?ELS8
	CALL	RANDOM-ELEMENT,DUMMY
	PRINT	STACK
	JUMP	?CND6
?ELS8:	PRINT	STROPN
	FSET	OBJ,OPENBIT
?CND6:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	OBJ,OPENBIT \?ELS19
	PRINT	STRCLS
	FCLEAR	OBJ,OPENBIT
	JUMP	?CND17
?ELS19:	CALL	RANDOM-ELEMENT,DUMMY
	PRINT	STACK
	CRLF	
?CND17:	CRLF	
	RTRUE	


	.FUNCT	BALLOON-FCN,RARG=0,M,R,RC
	EQUAL?	RARG,M-LOOK \?ELS5
	ZERO?	BINF-FLAG /?ELS8
	PRINTI	"The cloth bag is inflated and "
	FSET?	RECEPTACLE,OPENBIT \?ELS14
	PRINTI	"there is a "
	PRINTD	BINF-FLAG
	PRINTI	" burning in the receptacle."
	JUMP	?CND6
?ELS14:	PRINTI	"some smoke is leaking out of the closed receptacle."
	JUMP	?CND6
?ELS8:	PRINTI	"The cloth bag is draped over the side of the basket. Directly in the middle of the basket is a metal receptacle which is "
	FSET?	RECEPTACLE,OPENBIT \?ELS27
	PRINTI	"open"
	FIRST?	RECEPTACLE >RC /?KLU148
?KLU148:	ZERO?	RC /?CND25
	PRINTI	". A "
	PRINTD	RC
	PRINTI	" is "
	EQUAL?	BINF-FLAG,RC \?ELS40
	PUSH	STR?204
	JUMP	?CND36
?ELS40:	PUSH	STR?205
?CND36:	PRINT	STACK
	PRINTI	" inside"
	JUMP	?CND25
?ELS27:	PRINTI	"closed"
?CND25:	PRINTI	"."
?CND6:	ZERO?	BTIE-FLAG /?ELS51
	PRINTR	" The balloon is tied to a hook by the braided wire."
?ELS51:	PRINTR	" A braided wire is dangling over the side of the basket."
?ELS5:	EQUAL?	RARG,M-OBJDESC \?ELS60
	PRINTI	"There is a large and extremely heavy wicker basket here. An enormous cloth bag "
	ZERO?	BINF-FLAG /?ELS65
	PRINTI	"attached to the basket is inflated. A metal receptacle is fastened to the center of the basket. "
	FSET?	RECEPTACLE,OPENBIT \?ELS71
	PRINTI	"In it is a burning "
	PRINTD	BINF-FLAG
	JUMP	?CND63
?ELS71:	PRINTI	"Some smoke leaks out around its closed lid"
	JUMP	?CND63
?ELS65:	PRINTI	"is draped over the side and is firmly attached to the basket. A metal receptacle is fastened to the center of the basket"
?CND63:	ZERO?	BTIE-FLAG /?ELS86
	PRINTR	". A piece of wire tied to a hook holds the balloon in place."
?ELS86:	PRINTR	". Dangling from the basket is a piece of braided wire."
?ELS60:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \?ELS100
	GETPT	HERE,PRSO >M
	ZERO?	M /?ELS105
	ZERO?	BTIE-FLAG /?ELS110
	PRINTR	"You are tied to the ledge."
?ELS110:	PTSIZE	M
	EQUAL?	STACK,1 \?ELS117
	GETB	M,0 >R
	FSET?	R,RMUNGBIT /?ELS117
	SET	'BLOC,R
?ELS117:	CALL	QUEUE,I-BALLOON,3
	PUT	STACK,0,1
	RFALSE	
?ELS105:	PRINTR	"You can't control the balloon this way."
?ELS100:	EQUAL?	PRSA,V?OPEN \?ELS123
	ZERO?	BINF-FLAG /?ELS123
	EQUAL?	PRSO,RECEPTACLE \?ELS123
	FIRST?	RECEPTACLE \?ELS123
	PRINTI	"Opening it reveals a burning "
	PRINTD	BINF-FLAG
	PRINTI	"."
	CRLF	
	FSET	RECEPTACLE,OPENBIT
	RTRUE	
?ELS123:	EQUAL?	PRSA,V?TAKE \?ELS129
	EQUAL?	BINF-FLAG,PRSO \?ELS129
	PRINTI	"You don't really want to hold a burning "
	PRINTD	PRSO
	PRINTR	"."
?ELS129:	EQUAL?	PRSA,V?PUT \?ELS135
	EQUAL?	PRSI,RECEPTACLE \?ELS135
	FIRST?	RECEPTACLE \?ELS135
	PRINTR	"The receptacle is already occupied."
?ELS135:	EQUAL?	PRSA,V?PUT \?ELS141
	EQUAL?	PRSI,RECEPTACLE \?ELS141
	FSET	PRSO,NDESCBIT
	RFALSE	
?ELS141:	EQUAL?	PRSA,V?INFLATE \FALSE
	PRINTR	"It takes more than words to inflate a balloon."


	.FUNCT	I-BALLOON
	FSET?	RECEPTACLE,OPENBIT \?ELS5
	ZERO?	BINF-FLAG /?ELS5
	CALL	RISE-AND-SHINE
	RSTACK	
?ELS5:	EQUAL?	HERE,LEDGE-1,LEDGE-2 \?ELS9
	CALL	RISE-AND-SHINE
	RSTACK	
?ELS9:	CALL	DECLINE-AND-FALL
	RSTACK	


	.FUNCT	BALLOON-BURN
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" burns inside the receptacle."
	CRLF	
	GETP	PRSO,P?SIZE
	MUL	STACK,20
	CALL	QUEUE,I-BURNUP,STACK
	PUT	STACK,0,1
	FSET	PRSO,FLAMEBIT
	FSET	PRSO,ONBIT
	FCLEAR	PRSO,TAKEBIT
	FCLEAR	PRSO,READBIT
	ZERO?	BINF-FLAG \TRUE
	PRINTI	"The cloth bag inflates as it fills with hot air."
	CRLF	
	ZERO?	BLAB-FLAG \?CND13
	PRINTI	"A small label drops from the bag into the basket."
	CRLF	
	MOVE	BALLOON-LABEL,BALLOON
?CND13:	SET	'BLAB-FLAG,TRUE-VALUE
	SET	'BINF-FLAG,PRSO
	CALL	QUEUE,I-BALLOON,3
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	PUT-BALLOON,THERE,STR
	EQUAL?	HERE,LEDGE-1,LEDGE-2,VOLCANO-BOTTOM \?CND1
	PRINTI	"You watch as the balloon slowly "
	PRINT	STR
	CRLF	
?CND1:	MOVE	BALLOON,THERE
	SET	'BLOC,THERE
	RETURN	BLOC


	.FUNCT	RISE-AND-SHINE,IN,R
	IN?	WINNER,BALLOON /?PRD1
	PUSH	0
	JUMP	?PRD2
?PRD1:	PUSH	1
?PRD2:	SET	'IN,STACK
	CALL	QUEUE,I-BALLOON,3
	PUT	STACK,0,1
	EQUAL?	BLOC,VAIR-4 \?ELS7
	CALL	INT,I-BURNUP
	PUT	STACK,0,0
	CALL	INT,I-BALLOON
	PUT	STACK,0,0
	REMOVE	BALLOON
	ZERO?	IN /?ELS10
	CALL	JIGS-UP,STR?206
	JUMP	?CND8
?ELS10:	EQUAL?	HERE,LEDGE-1,LEDGE-2,VOLCANO-BOTTOM \?CND8
	PRINTI	"You watch the balloon drift out over the rim and away on the wind."
	CRLF	
?CND8:	SET	'BLOC,VOLCANO-BOTTOM
	RETURN	BLOC
?ELS7:	CALL	LKP,BLOC,BALLOON-UPS >R
	ZERO?	R /?ELS17
	ZERO?	IN /?ELS22
	PRINTI	"The balloon ascends."
	CRLF	
	CRLF	
	SET	'BLOC,R
	CALL	GOTO,R
	RSTACK	
?ELS22:	CALL	PUT-BALLOON,R,STR?207
	RSTACK	
?ELS17:	CALL	LKP,BLOC,BALLOON-FLOATS >R
	ZERO?	R /?ELS29
	ZERO?	IN /?ELS34
	PRINTI	"The balloon leaves the ledge."
	CRLF	
	CRLF	
	SET	'BLOC,R
	CALL	GOTO,R
	RSTACK	
?ELS34:	CALL	QUEUE,I-GNOME,10
	PUT	STACK,0,1
	CALL	PUT-BALLOON,R,STR?208
	FSET	RECEPTACLE,OPENBIT
	RTRUE	
?ELS29:	ZERO?	IN /?ELS41
	SET	'BLOC,VAIR-1
	PRINTI	"The balloon rises slowly from the ground."
	CRLF	
	CRLF	
	CALL	GOTO,VAIR-1
	RSTACK	
?ELS41:	CALL	PUT-BALLOON,VAIR-1,STR?209
	RSTACK	


	.FUNCT	DECLINE-AND-FALL,IN,R
	IN?	WINNER,BALLOON /?PRD1
	PUSH	0
	JUMP	?PRD2
?PRD1:	PUSH	1
?PRD2:	SET	'IN,STACK
	CALL	QUEUE,I-BALLOON,3
	PUT	STACK,0,1
	EQUAL?	BLOC,VAIR-1 \?ELS7
	ZERO?	IN /?ELS12
	SET	'BLOC,VOLCANO-BOTTOM
	ZERO?	BINF-FLAG /?ELS18
	PRINTI	"The balloon has landed."
	CRLF	
	CRLF	
	CALL	GOTO,VOLCANO-BOTTOM
	RSTACK	
?ELS18:	REMOVE	BALLOON
	MOVE	DEAD-BALLOON,BLOC
	MOVE	WINNER,HERE
	CALL	INT,I-BALLOON
	PUT	STACK,0,0
	PRINTI	"You have landed, but the balloon did not survive."
	CRLF	
	CRLF	
	CALL	GOTO,VOLCANO-BOTTOM
	RSTACK	
?ELS12:	CALL	PUT-BALLOON,VOLCANO-BOTTOM,STR?210
	RSTACK	
?ELS7:	CALL	LKP,BLOC,BALLOON-DOWNS >R
	ZERO?	R /FALSE
	ZERO?	IN /?ELS34
	PRINTI	"The balloon descends."
	CRLF	
	CRLF	
	SET	'BLOC,R
	CALL	GOTO,R
	RSTACK	
?ELS34:	CALL	PUT-BALLOON,R,STR?211
	RSTACK	


	.FUNCT	BCONTENTS
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is an integral part of the basket and cannot be removed."
	EQUAL?	PRSO,BRAIDED-WIRE \?CND8
	PRINTI	" The wire might possibly be tied, though."
?CND8:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSO,CLOTH-BAG \?ELS14
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE \?ELS14
	EQUAL?	PRSA,V?OPEN \?ELS21
	PRINTR	"The bag is enormous. The concept of opening it here is ludicrous."
?ELS21:	PRINTR	"It doesn't appear that there's anything inside."
?ELS14:	EQUAL?	PRSA,V?EXAMINE \?ELS29
	EQUAL?	PRSO,RECEPTACLE \?ELS29
	PRINTI	"The receptacle is "
	FSET?	PRSO,OPENBIT \?ELS38
	PRINTR	"open."
?ELS38:	PRINTR	"closed."
?ELS29:	EQUAL?	PRSA,V?EXAMINE,V?FIND \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is part of the basket. It may be manipulated within the basket but cannot be removed."


	.FUNCT	WIRE-FCN
	EQUAL?	PRSA,V?EXAMINE,V?FIND,V?TAKE \?ELS5
	CALL	BCONTENTS
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?TIE \?ELS7
	EQUAL?	PRSO,BRAIDED-WIRE \FALSE
	EQUAL?	PRSI,HOOK-1,HOOK-2 \FALSE
	SET	'BTIE-FLAG,PRSI
	FSET	PRSI,NDESCBIT
	CALL	INT,I-BALLOON
	PUT	STACK,0,0
	PRINTR	"The balloon is fastened to the hook."
?ELS7:	EQUAL?	PRSA,V?UNTIE \FALSE
	EQUAL?	PRSO,BRAIDED-WIRE \FALSE
	ZERO?	BTIE-FLAG /?ELS25
	CALL	QUEUE,I-BALLOON,3
	PUT	STACK,0,1
	FCLEAR	BTIE-FLAG,NDESCBIT
	SET	'BTIE-FLAG,FALSE-VALUE
	PRINTR	"The wire falls off of the hook."
?ELS25:	PRINTR	"The wire is not tied to anything."


	.FUNCT	I-BURNUP,OBJ
	FIRST?	RECEPTACLE >OBJ /?KLU6
?KLU6:	EQUAL?	HERE,BLOC \?CND1
	PRINTI	"The "
	PRINTD	OBJ
	PRINTI	" has now burned out, and the cloth bag starts to deflate."
	CRLF	
?CND1:	REMOVE	OBJ
	SET	'BINF-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	SAFE-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a dusty old room which is featureless, except for an exit on the north side."
	CRLF	
	ZERO?	SAFE-FLAG \?ELS12
	PRINTR	"Imbedded in the far wall is a rusty box. It appears to be somewhat damaged, since an oblong hole has been chipped out of the front of it."
?ELS12:	PRINTR	"On the far wall is a rusty box, whose door has been blown off."


	.FUNCT	SAFE-FCN
	EQUAL?	PRSA,V?TAKE \?ELS5
	EQUAL?	PRSO,SAFE \?ELS5
	PRINTR	"The box is imbedded in the wall."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS11
	ZERO?	SAFE-FLAG /?ELS16
	PRINTR	"The box has no door!"
?ELS16:	PRINTR	"The box is rusted and will not open."
?ELS11:	EQUAL?	PRSA,V?CLOSE \FALSE
	ZERO?	SAFE-FLAG /?ELS30
	PRINTR	"The box has no door!"
?ELS30:	PRINTR	"The box isn't open!"


	.FUNCT	BRICK-FCN
	EQUAL?	PRSA,V?BURN \FALSE
	REMOVE	BRICK
	CALL	JIGS-UP,OTHER-PROPERTIES
	RSTACK	


	.FUNCT	FUSE-FCN
	EQUAL?	PRSA,V?BURN /?THN6
	EQUAL?	PRSA,V?LAMP-ON \FALSE
	IN?	MATCH,WINNER \FALSE
	FSET?	MATCH,ONBIT \FALSE
?THN6:	PRINTI	"The string starts to burn."
	CRLF	
	CALL	QUEUE,I-FUSE,2
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-FUSE,BRICK-ROOM,F
	LOC	BRICK >BRICK-ROOM
	IN?	FUSE,BRICK \?ELS3
?PRG4:	ZERO?	BRICK-ROOM /FALSE
	IN?	BRICK-ROOM,ROOMS \?ELS10
	JUMP	?REP5
?ELS10:	LOC	BRICK-ROOM >BRICK-ROOM
	JUMP	?PRG4
?REP5:	MOVE	EXPLOSION,BRICK-ROOM
	FCLEAR	BRICK-ROOM,TOUCHBIT
	EQUAL?	BRICK-ROOM,HERE \?ELS15
	CALL	MUNG-ROOM,BRICK-ROOM,STR?213
	CALL	JIGS-UP,OTHER-PROPERTIES
	JUMP	?CND13
?ELS15:	EQUAL?	BRICK-ROOM,SAFE-ROOM \?ELS17
	CALL	QUEUE,I-SAFE,5
	PUT	STACK,0,1
	SET	'MUNGED-ROOM,SAFE-ROOM
	PRINTI	"There is an explosion nearby."
	CRLF	
	IN?	BRICK,SLOT \?CND13
	FSET	SLOT,INVISIBLE
	FSET	SAFE,OPENBIT
	FCLEAR	SAFE-ROOM,TOUCHBIT
	SET	'SAFE-FLAG,TRUE-VALUE
	JUMP	?CND13
?ELS17:	PRINTI	"There is an explosion nearby."
	CRLF	
	CALL	QUEUE,I-SAFE,5
	PUT	STACK,0,1
	SET	'MUNGED-ROOM,BRICK-ROOM
	FIRST?	BRICK-ROOM >F \?CND13
?PRG30:	FSET?	F,TAKEBIT \?CND32
	FSET	F,INVISIBLE
?CND32:	NEXT?	F >F /?PRG30
?CND13:	REMOVE	BRICK
	JUMP	?CND1
?ELS3:	LOC	FUSE
	EQUAL?	STACK,WINNER,HERE \?CND1
	PRINTI	"The string rapidly burns into nothingness."
	CRLF	
?CND1:	REMOVE	FUSE
	RTRUE	


	.FUNCT	I-SAFE
	EQUAL?	HERE,MUNGED-ROOM \?ELS3
	CALL	JIGS-UP,STR?214
	JUMP	?CND1
?ELS3:	ZERO?	DEAD \?CND1
	PRINTI	"You may recall that recent explosion. Probably as a result of it, you hear an ominous rumbling, as if a nearby room had collapsed."
	CRLF	
	EQUAL?	MUNGED-ROOM,SAFE-ROOM \?CND1
	CALL	QUEUE,I-LEDGE,8
	PUT	STACK,0,1
?CND1:	CALL	MUNG-ROOM,MUNGED-ROOM,STR?213
	RSTACK	


	.FUNCT	I-LEDGE,RM=LEDGE-2
	EQUAL?	HERE,LEDGE-2 \?ELS3
	IN?	WINNER,BALLOON \?ELS6
	ZERO?	BTIE-FLAG /?ELS9
	SET	'BLOC,VOLCANO-BOTTOM
	REMOVE	BALLOON
	MOVE	DEAD-BALLOON,VOLCANO-BOTTOM
	SET	'BTIE-FLAG,FALSE-VALUE
	SET	'BINF-FLAG,FALSE-VALUE
	CALL	INT,I-BALLOON
	PUT	STACK,0,0
	CALL	INT,I-BURNUP
	PUT	STACK,0,0
	CALL	JIGS-UP,STR?215
	JUMP	?CND1
?ELS9:	PRINTI	"The ledge collapses, leaving you with no place to land."
	CRLF	
	JUMP	?CND1
?ELS6:	CALL	JIGS-UP,STR?216
	JUMP	?CND1
?ELS3:	ZERO?	DEAD \?CND1
	PRINTI	"The ledge collapses. (That was a narrow escape!)"
	CRLF	
?CND1:	CALL	MUNG-ROOM,RM,STR?217
	RSTACK	


	.FUNCT	LEDGE-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are on a wide ledge high in the volcano. The rim of the volcano is about 200 feet above and there is a precipitous drop to the bottom."
	FSET?	SAFE-ROOM,RMUNGBIT \?ELS12
	PRINTR	" The way to the south is blocked by rubble."
?ELS12:	PRINTR	" There is a small door to the south."


	.FUNCT	I-GNOME
	EQUAL?	HERE,LEDGE-1,LEDGE-2 \?ELS5
	PRINTI	"A volcano gnome seems to walk straight out of the wall and "
	IN?	WAND,WINNER \?ELS12
	PRINTR	"noticing the wand, straight back in."
?ELS12:	PRINTI	"says ""I have a busy appointment schedule and little time to waste on trespassers, but for a small fee I'll show you the way out."" You notice the gnome nervously glancing at his watch."
	CRLF	
	MOVE	GNOME,HERE
	RTRUE	
?ELS5:	CALL	QUEUE,I-GNOME,1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	GNOME-FCN
	EQUAL?	PRSA,V?TELL \?ELS5
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	ZERO?	GNOME-FLAG \?CND6
	CALL	QUEUE,I-NERVOUS,5
	PUT	STACK,0,1
?CND6:	SET	'GNOME-FLAG,TRUE-VALUE
	PRINTR	"The gnome appears increasingly nervous."
?ELS5:	EQUAL?	PRSA,V?THROW,V?GIVE \?ELS12
	EQUAL?	PRSI,GNOME \?ELS12
	GETPT	PRSO,P?VALUE
	ZERO?	STACK /?ELS19
	PRINTI	"""Thank you very much for the "
	PRINTD	PRSO
	PRINTI	". I don't believe I've ever seen one as beautiful. Follow me,"" he says, and a door appears on the west end of the ledge. Through the door, you can see a narrow chimney sloping steeply downward. The gnome moves quickly, and disappears from sight."
	CRLF	
	REMOVE	PRSO
	REMOVE	GNOME
	SET	'GNOME-DOOR-FLAG,TRUE-VALUE
	RETURN	GNOME-DOOR-FLAG
?ELS19:	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS23
	MOVE	BRICK,HERE
	REMOVE	GNOME
	CALL	INT,I-GNOME
	PUT	STACK,0,0
	CALL	INT,I-NERVOUS
	PUT	STACK,0,0
	PRINTR	"""That certainly wasn't what I had in mind,"" he says, and disappears."
?ELS23:	CALL	REMOVE-CAREFULLY,PRSO
	PRINTI	"""That wasn't quite what I had in mind,"" he says, crunching the "
	PRINTD	PRSO
	PRINTR	" in his rock-hard hands."
?ELS12:	PRINTI	"The gnome appears increasingly nervous."
	CRLF	
	ZERO?	GNOME-FLAG \?CND34
	CALL	QUEUE,I-NERVOUS,5
	PUT	STACK,0,1
?CND34:	SET	'GNOME-FLAG,TRUE-VALUE
	RETURN	GNOME-FLAG


	.FUNCT	I-NERVOUS
	IN?	GNOME,HERE \?CND1
	PRINTI	"The gnome glances at his watch. ""Oops. I'm late for an appointment!"" He disappears, leaving you alone on the ledge."
	CRLF	
?CND1:	REMOVE	GNOME
	RTRUE	


	.FUNCT	PURPLE-BOOK-FCN
	EQUAL?	PRSA,V?READ \?ELS5
	IN?	STAMP,PURPLE-BOOK \?ELS5
	FSET?	PURPLE-BOOK,OPENBIT /?ELS5
	GETP	PURPLE-BOOK,P?TEXT
	PRINT	STACK
	CRLF	
	CALL	PERFORM,V?OPEN,PURPLE-BOOK
	RTRUE	
?ELS5:	CALL	RANDOM-BOOK
	RSTACK	


	.FUNCT	RANDOM-BOOK
	EQUAL?	PRSA,V?PUT,V?MOVE,V?TAKE \FALSE
	FSET	WHITE-BOOK,TOUCHBIT
	FSET	PURPLE-BOOK,TOUCHBIT
	FSET	GREEN-BOOK,TOUCHBIT
	FSET	BLUE-BOOK,TOUCHBIT
	RFALSE	


	.FUNCT	HEAD-FCN
	EQUAL?	PRSA,V?HELLO \?ELS5
	PRINTR	"The Flatheads are dead; therefore they do not respond."
?ELS5:	EQUAL?	PRSA,V?RUB,V?ATTACK,V?KICK /?THN10
	EQUAL?	PRSA,V?BURN,V?TAKE,V?OPEN \FALSE
?THN10:	CALL	JIGS-UP,STR?218
	RSTACK	


	.FUNCT	CRYPT-ANTEROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The anteroom is large and empty. Marble bas reliefs depict the stirring times and afterlife of the Flatheads (the latter a bit optimistically). The exit is to the west. A huge marble door stands to the south. "
	PRINTI	"The door is "
	FSET?	CRYPT-DOOR,OPENBIT \?ELS12
	PRINTI	"open."
	JUMP	?CND10
?ELS12:	PRINTI	"closed."
?CND10:	PRINTR	" Above the door is the cryptic inscription: ""Feel Free""."


	.FUNCT	CRYPT-ROOM-FCN,RARG,CLIT?
	EQUAL?	RARG,M-LOOK \?ELS5
	FCLEAR	HERE,ONBIT
	CALL	LIT?,HERE
	ZERO?	STACK /?ELS8
	PRINTI	"The room contains the earthly remains of the mighty Flatheads, twelve somewhat flat heads mounted securely on poles. While the room might be expected to contain funerary urns or other evidence of the ritual practices of the ancient Zorkers, it is empty of all such objects. There is writing carved on the crypt. The only apparent exit is to the north through the door to the anteroom. The door is "
	FSET?	CRYPT-DOOR,OPENBIT \?ELS13
	PRINTI	"open."
	JUMP	?CND11
?ELS13:	PRINTI	"closed."
?CND11:	CRLF	
	FSET?	DIM-DOOR,INVISIBLE /?CND6
	PRINTI	"Looking closely at the south wall, you can see the dim outline of a secret door labelled with the letter ""F""."
	CRLF	
	JUMP	?CND6
?ELS8:	CALL	DIM-DOOR-APPEARS
?CND6:	FSET	HERE,ONBIT
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	SET	'CLIT?,CRYPT-LIT?
	FCLEAR	CRYPT-ROOM,ONBIT
	CALL	LIT?,CRYPT-ROOM >CRYPT-LIT?
	ZERO?	CLIT? /?CND29
	ZERO?	CRYPT-LIT? \?CND29
	CALL	DIM-DOOR-APPEARS
?CND29:	FSET	CRYPT-ROOM,ONBIT
	RTRUE	


	.FUNCT	DIM-DOOR-APPEARS
	PRINTI	"It is dark, but on the south wall is a faint outline of a rectangle, as though light were shining around a doorway. You can also make out a faintly glowing letter in the center of this area. It might be an ""F""."
	CRLF	
	FCLEAR	DIM-DOOR,INVISIBLE
	RTRUE	


	.FUNCT	CRYPT-OBJECT
	EQUAL?	PRSA,V?OPEN \?ELS5
	PRINTR	"The crypt is sealed for all time."
?ELS5:	EQUAL?	PRSA,V?RUB \FALSE
	PRINTR	"The marble is cool."


	.FUNCT	CRYPT-DOOR-FCN
	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	OPEN-CLOSE,PRSO,STR?219,STR?220
	RSTACK	


	.FUNCT	TOMB-PSEUDO
	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	DO-WALK,P?EAST
	RTRUE	


	.FUNCT	DIM-DOOR-FCN
	EQUAL?	PRSA,V?KNOCK \?ELS5
	PRINTR	"A hollow echo responds."
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	EQUAL?	PRSA,V?OPEN \?ELS12
	SET	'DIM-DOOR-FLAG,TRUE-VALUE
	JUMP	?CND10
?ELS12:	SET	'DIM-DOOR-FLAG,FALSE-VALUE
?CND10:	CALL	OPEN-CLOSE,PRSO,STR?221,STR?222
	RSTACK	


	.FUNCT	REPELLENT-FCN
	EQUAL?	PRSA,V?SHAKE \?ELS5
	ZERO?	SPRAY-USED? /?ELS10
	PRINTR	"The can seems empty."
?ELS10:	PRINTR	"There is a sloshing sound from inside."
?ELS5:	EQUAL?	PRSA,V?PUT,V?SPRAY \FALSE
	EQUAL?	PRSO,REPELLENT \FALSE
	ZERO?	SPRAY-USED? /?ELS26
	PRINTR	"The repellent is all gone."
?ELS26:	ZERO?	PRSI \?ELS31
	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray stinks amazingly for a few moments, then drifts away."
?ELS31:	EQUAL?	PRSI,ME \?CND36
	CALL	QUEUE,I-SPRAY,8
	PUT	STACK,0,1
	SET	'SPRAYED?,TRUE-VALUE
?CND36:	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray smells like a mixture of old socks and burning rubber. If I were a grue I'd sure stay clear!"


	.FUNCT	I-SPRAY
	SET	'SPRAYED?,FALSE-VALUE
	PRINTR	"That horrible smell is much less pungent now."


	.FUNCT	ZORK3-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Beyond the door is a roughly hewn staircase leading down into darkness. The landing on which you stand is covered with carefully drawn magical runes like those sketched upon the workbench of the Wizard of Frobozz. These have been overlaid with sweeping green lines of enormous power, which undulate back and forth across the landing. "
	IN?	WAND,WINNER \?ELS12
	PRINTI	"The wand begins to vibrate in harmony with the motion of the lines. You feel yourself compelled downward, and you yield, stepping onto the staircase. As you pass the green lines, they flare and disappear with a burst of light, and you tumble down the staircase!

At the bottom, a vast red-lit hall stretches off into the distance. Sinister statues guard the entrance to a dimly visible room far ahead. With courage and cunning you have conquered the Wizard of Frobozz and become the master of his domain, but the final challenge awaits!

(The ultimate adventure concludes in ""Zork III: The Dungeon Master"".)

"
	CRLF	
	SET	'WON-FLAG,TRUE-VALUE
	CALL	FINISH
	RSTACK	
?ELS12:	CALL	JIGS-UP,STR?223
	RSTACK	


	.FUNCT	I-BUCKET
	IN?	WATER,BUCKET \FALSE
	SET	'EVAPORATED,TRUE-VALUE
	REMOVE	WATER
	RFALSE	


	.FUNCT	WATER-FCN,AV,W,PI?
	EQUAL?	PRSA,V?SGIVE /FALSE
	EQUAL?	PRSA,V?THROUGH \?ELS5
	CALL	PERFORM,V?SWIM,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?FILL \?ELS7
	SET	'W,PRSI
	SET	'PRSA,V?PUT
	SET	'PRSI,PRSO
	SET	'PRSO,W
	SET	'PI?,FALSE-VALUE
	JUMP	?CND1
?ELS7:	EQUAL?	PRSO,GLOBAL-WATER,WATER \?ELS9
	SET	'W,PRSO
	SET	'PI?,FALSE-VALUE
	JUMP	?CND1
?ELS9:	ZERO?	PRSI /?CND1
	SET	'W,PRSI
	SET	'PI?,TRUE-VALUE
?CND1:	EQUAL?	W,GLOBAL-WATER \?CND13
	SET	'W,WATER
	EQUAL?	PRSA,V?PUT,V?TAKE \?CND13
	REMOVE	W
?CND13:	ZERO?	PI? /?ELS21
	SET	'PRSI,W
	JUMP	?CND19
?ELS21:	SET	'PRSO,W
?CND19:	LOC	WINNER >AV
	FSET?	AV,VEHBIT /?CND25
	SET	'AV,FALSE-VALUE
?CND25:	EQUAL?	PRSA,V?PUT,V?TAKE \?ELS32
	ZERO?	PI? \?ELS32
	ZERO?	AV /?ELS39
	EQUAL?	AV,PRSI \?ELS39
	CALL	PUDDLE,AV
	RSTACK	
?ELS39:	ZERO?	AV /?ELS43
	ZERO?	PRSI \?ELS43
	IN?	W,AV /?ELS43
	CALL	PUDDLE,AV
	RSTACK	
?ELS43:	ZERO?	PRSI /?ELS47
	EQUAL?	PRSI,TEAPOT /?ELS47
	PRINTI	"The water leaks out of the "
	PRINTD	PRSI
	PRINTI	" and evaporates immediately."
	CRLF	
	REMOVE	W
	RTRUE	
?ELS47:	IN?	TEAPOT,WINNER \?ELS53
	FIRST?	TEAPOT /?ELS58
	EQUAL?	HERE,POOL-ROOM \?ELS61
	MOVE	SALTY-WATER,TEAPOT
	JUMP	?CND59
?ELS61:	MOVE	WATER,TEAPOT
?CND59:	PRINTR	"The teapot is now full of water."
?ELS58:	PRINTR	"The teapot isn't currently empty."
?ELS53:	IN?	PRSO,TEAPOT \?ELS71
	EQUAL?	PRSA,V?TAKE \?ELS71
	ZERO?	PRSI \?ELS71
	SET	'PRSO,TEAPOT
	CALL	ITAKE
	SET	'PRSO,W
	RETURN	PRSO
?ELS71:	PRINTR	"The water slips through your fingers."
?ELS32:	ZERO?	PI? /?ELS79
	PRINTR	"Nice try."
?ELS79:	EQUAL?	PRSA,V?GIVE,V?DROP \?ELS84
	EQUAL?	PRSO,WATER \?CND85
	CALL	HELD?,WATER
	ZERO?	STACK \?CND85
	PRINTR	"You don't have any water."
?CND85:	REMOVE	WATER
	ZERO?	AV /?ELS96
	CALL	PUDDLE,AV
	RSTACK	
?ELS96:	PRINTI	"The water spills to the floor and evaporates."
	CRLF	
	REMOVE	WATER
	RTRUE	
?ELS84:	EQUAL?	PRSA,V?THROW \FALSE
	PRINTI	"The water splashes on the walls and evaporates."
	CRLF	
	REMOVE	WATER
	RTRUE	


	.FUNCT	PUDDLE,AV
	PRINTI	"There is now a puddle in the bottom of the "
	PRINTD	AV
	PRINTI	"."
	CRLF	
	MOVE	PRSO,AV
	RTRUE	


	.FUNCT	BUCKET-FCN,RARG=M-BEG
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?BURN \?ELS10
	EQUAL?	PRSO,BUCKET \?ELS10
	PRINTR	"The bucket is fireproof, and won't burn."
?ELS10:	EQUAL?	PRSA,V?PUT,V?DROP \?ELS16
	EQUAL?	PRSO,WATER \?ELS16
	EQUAL?	PRSI,BUCKET \?ELS16
	IN?	BUCKET,WELL-BOTTOM \?ELS16
	IN?	WINNER,BUCKET /?ELS16
	PRINTI	"The bucket swiftly rises up, and is gone."
	CRLF	
	MOVE	BUCKET,WELL-TOP
	MOVE	WATER,BUCKET
	SET	'BUCKET-TOP-FLAG,TRUE-VALUE
	CALL	QUEUE,I-BUCKET,100
	PUT	STACK,0,1
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?KICK \FALSE
	CALL	JIGS-UP,STR?224
	RSTACK	
?ELS5:	EQUAL?	RARG,M-END \?ELS24
	IN?	WATER,BUCKET \?ELS29
	ZERO?	BUCKET-TOP-FLAG \?ELS29
	PRINTI	"The bucket rises and comes to a stop."
	CRLF	
	CRLF	
	SET	'BUCKET-TOP-FLAG,TRUE-VALUE
	SET	'EVAPORATED,FALSE-VALUE
	CALL	PASS-THE-BUCKET,WELL-TOP
	CALL	QUEUE,I-BUCKET,100
	PUT	STACK,0,1
	RTRUE	
?ELS29:	ZERO?	BUCKET-TOP-FLAG /FALSE
	IN?	WATER,BUCKET /FALSE
	ZERO?	EVAPORATED /?ELS40
	PRINTI	"The last of the water evaporates, and the bucket descends."
	CRLF	
	CRLF	
	JUMP	?CND38
?ELS40:	PRINTI	"The bucket descends and comes to a stop."
	CRLF	
	CRLF	
?CND38:	SET	'BUCKET-TOP-FLAG,FALSE-VALUE
	CALL	PASS-THE-BUCKET,WELL-BOTTOM
	RSTACK	
?ELS24:	EQUAL?	PRSA,V?CLIMB-ON \FALSE
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	


	.FUNCT	PASS-THE-BUCKET,R
	MOVE	BUCKET,R
	IN?	WINNER,BUCKET \FALSE
	CALL	GOTO,R
	RSTACK	


	.FUNCT	POSTS-ROOM-FCN,RARG
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?TAKE \FALSE
	FSET?	PRSO,NONLANDBIT \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is now much larger than you are. You have no hope of taking it."


	.FUNCT	EATME-FCN,F,N
	EQUAL?	PRSA,V?EAT \?ELS5
	EQUAL?	PRSO,EAT-ME-CAKE \?ELS5
	EQUAL?	HERE,TEA-ROOM \?ELS5
	PRINTI	"Suddenly, the room appears to have become very large (although everything you are carrying seems to be its normal size)."
	CRLF	
	CRLF	
	REMOVE	EAT-ME-CAKE
	FSET	ROBOT,INVISIBLE
	FSET	ALICE-TABLE,INVISIBLE
	FIRST?	HERE >F /?KLU24
?KLU24:	
?PRG10:	ZERO?	F \?ELS14
	JUMP	?REP11
?ELS14:	NEXT?	F >N /?KLU25
?KLU25:	EQUAL?	F,ADVENTURER /?CND12
	FSET?	F,TAKEBIT \?CND12
	FSET	F,NONLANDBIT
	FSET	F,TRYTAKEBIT
	MOVE	F,POSTS-ROOM
?CND12:	SET	'F,N
	JUMP	?PRG10
?REP11:	CALL	GOTO,POSTS-ROOM
	RSTACK	
?ELS5:	CALL	CAKE-CRUMBLE
	RSTACK	


	.FUNCT	CAKE-CRUMBLE,CAKE
	FSET?	PRSO,FOODBIT \?ELS3
	SET	'CAKE,PRSO
	JUMP	?CND1
?ELS3:	SET	'CAKE,PRSI
?CND1:	EQUAL?	HERE,TEA-ROOM,POSTS-ROOM,POOL-ROOM /FALSE
	EQUAL?	HERE,MACHINE-ROOM,MAGNET-ROOM,CAGE-ROOM /FALSE
	EQUAL?	HERE,WELL-TOP,IN-CAGE /FALSE
	REMOVE	CAKE
	PRINTI	"The "
	PRINTD	CAKE
	PRINTR	" has crumbled to dust."


	.FUNCT	CAKE-FCN,F,N
	EQUAL?	PRSA,V?READ \?ELS5
	FSET?	PRSO,NONLANDBIT \?ELS10
	PRINTR	"The cake is much too tall now for you to read the lettering."
?ELS10:	ZERO?	PRSI /?ELS14
	EQUAL?	PRSI,PALANTIR-1,PALANTIR-2,PALANTIR-3 \?ELS20
	CALL	PERFORM,V?LOOK-INSIDE,PRSI
	RSTACK	
?ELS20:	EQUAL?	PRSI,FLASK \?ELS22
	PRINTI	"The letters, now visible, say """
	EQUAL?	PRSO,RED-ICING \?ELS27
	PRINTI	"Evaporate"
	JUMP	?CND25
?ELS27:	EQUAL?	PRSO,ORANGE-ICING \?ELS31
	PRINTI	"Explode"
	JUMP	?CND25
?ELS31:	PRINTI	"Enlarge"
?CND25:	PRINTR	"""."
?ELS22:	PRINTR	"You can't see through that!"
?ELS14:	PRINTR	"The first letter is a capital E. The rest is too small to read."
?ELS5:	EQUAL?	PRSA,V?EAT \?ELS49
	EQUAL?	HERE,TEA-ROOM,POSTS-ROOM,POOL-ROOM \?ELS49
	EQUAL?	PRSO,ORANGE-ICING \?ELS56
	REMOVE	PRSO
	CALL	ICEBOOM
	RSTACK	
?ELS56:	EQUAL?	PRSO,RED-ICING \?ELS58
	REMOVE	PRSO
	CALL	JIGS-UP,STR?225
	RSTACK	
?ELS58:	EQUAL?	PRSO,BLUE-ICING \FALSE
	REMOVE	PRSO
	PRINTI	"The room around you seems to be getting smaller."
	CRLF	
	CRLF	
	EQUAL?	HERE,POSTS-ROOM \?ELS67
	FCLEAR	ROBOT,INVISIBLE
	FCLEAR	ALICE-TABLE,INVISIBLE
	FSET	POSTS,INVISIBLE
	FIRST?	HERE >F /?KLU99
?KLU99:	
?PRG68:	ZERO?	F \?ELS72
	JUMP	?REP69
?ELS72:	NEXT?	F >N /?KLU100
?KLU100:	EQUAL?	F,ADVENTURER /?CND70
	FSET?	F,TAKEBIT \?CND70
	FCLEAR	F,NONLANDBIT
	FCLEAR	F,TRYTAKEBIT
	MOVE	F,TEA-ROOM
?CND70:	SET	'F,N
	JUMP	?PRG68
?REP69:	CALL	GOTO,TEA-ROOM
	RSTACK	
?ELS67:	CALL	JIGS-UP,STR?226
	RSTACK	
?ELS49:	EQUAL?	PRSA,V?PUT,V?THROW \?ELS83
	EQUAL?	PRSO,ORANGE-ICING \?ELS83
	EQUAL?	HERE,TEA-ROOM,POSTS-ROOM,POOL-ROOM \?ELS83
	REMOVE	PRSO
	CALL	ICEBOOM
	RSTACK	
?ELS83:	EQUAL?	PRSA,V?PUT,V?THROW \?ELS87
	EQUAL?	PRSO,RED-ICING,BLUE-ICING,ORANGE-ICING \?ELS87
	EQUAL?	PRSI,POOL \?ELS87
	EQUAL?	PRSO,BLUE-ICING,ORANGE-ICING \?CND90
	PRINTI	"The cake sinks majestically into the pool."
	CRLF	
	REMOVE	PRSO
	RTRUE	
?CND90:	MOVE	PRSO,HERE
	REMOVE	PRSI
	PRINTI	"Most of the pool evaporates, revealing a (slightly damp but still valuable) package of rare candies. The red cake must be pretty strong stuff, since it remains intact!"
	CRLF	
	FCLEAR	CANDY,INVISIBLE
	RTRUE	
?ELS87:	CALL	CAKE-CRUMBLE
	RSTACK	


	.FUNCT	CANDY-FCN
	EQUAL?	PRSA,V?READ,V?EXAMINE \?ELS5
	CALL	FIXED-FONT-ON
	PRINTI	"       Frobozz Magic Candy Company
         >>Special Assortment<<
          Candied Grasshoppers
             Chocolated Ants
              Worms Glacee
(By Appointment to His Majesty, Dimwit I)
"
	CALL	FIXED-FONT-OFF
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?OPEN,V?EAT \FALSE
	PRINTR	"Such rich food would probably not be good for you."


	.FUNCT	TOP-ETCHINGS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"       o  b  o
   r             z
f   M  A  G  I  C   z
c    W  E   L  L    y
   o             n
       m  p  a
"
	CALL	FIXED-FONT-OFF
	RTRUE	


	.FUNCT	BOTTOM-ETCHINGS-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"       o  b  o

       A  G  I
        E   L

       m  p  a
"
	CALL	FIXED-FONT-OFF
	RTRUE	


	.FUNCT	CUBE-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"              Bank of Zork
                   VAULT
                 *722 GUE*
        Frobozz Magic Vault Company
"
	CALL	FIXED-FONT-OFF
	RTRUE	


	.FUNCT	FIXED-FONT-ON
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	FIXED-FONT-OFF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	POOL-FCN
	EQUAL?	PRSA,V?DRINK \?ELS5
	PRINTR	"The water is extremely salty."
?ELS5:	EQUAL?	PRSA,V?LOOK-UNDER \?ELS9
	PRINTR	"You'd probably have to enter the pool to see what's below the surface."
?ELS9:	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	JIGS-UP,STR?227
	RSTACK	


	.FUNCT	FLASK-FCN
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	PRINTR	"You notice that objects behind the flask appear to be magnified. You might try looking at something through the flask."
?ELS5:	EQUAL?	PRSA,V?READ \?ELS9
	EQUAL?	PRSI,FLASK \?ELS9
	PRINTI	"The flask distorts and magnifies the "
	PRINTD	PRSO
	PRINTI	", showing details not noticed earlier."
	CRLF	
	RFALSE	
?ELS9:	EQUAL?	PRSA,V?OPEN \?ELS15
	CALL	MUNG-ROOM,HERE,STR?228
	CALL	JIGS-UP,FATAL-VAPORS
	RSTACK	
?ELS15:	EQUAL?	PRSA,V?THROW,V?MUNG \FALSE
	PRINTI	"The flask breaks into pieces."
	CRLF	
	REMOVE	PRSO
	CALL	JIGS-UP,FATAL-VAPORS
	RSTACK	


	.FUNCT	PLEAK
	EQUAL?	PRSA,V?TAKE \?ELS5
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PLUG \FALSE
	PRINTR	"The leak is too high above you to reach."


	.FUNCT	ICEBOOM
	CALL	MUNG-ROOM,HERE,STR?230
	CALL	JIGS-UP,STR?231
	RSTACK	


	.FUNCT	MAGNET-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTR	"You are in a circular room with a low ceiling. There are exits to the east and southeast."
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	CAROUSEL-FLIP-FLAG /FALSE
	ZERO?	CAROUSEL-ZOOM-FLAG /?ELS16
	EQUAL?	ADVENTURER,WINNER \?ELS22
	PUSH	STR?232
	JUMP	?CND18
?ELS22:	PUSH	STR?233
?CND18:	CALL	JIGS-UP,STACK
	RSTACK	
?ELS16:	EQUAL?	WINNER,ADVENTURER \FALSE
	PRINTI	"As you enter, your compass starts spinning wildly."
	CRLF	
	ZERO?	COMPASS-KLUDGE \?CND29
	PRINTI	"What compass, you ask? The one which allows you to specify compass directions for movement."
	SET	'COMPASS-KLUDGE,TRUE-VALUE
?CND29:	CRLF	
	RTRUE	


	.FUNCT	MAGNET-ROOM-EXIT
	ZERO?	CAROUSEL-FLIP-FLAG /?ELS5
	EQUAL?	WINNER,ADVENTURER \?ELS5
	PRINTI	"You cannot get your bearings..."
	CRLF	
	CRLF	
	RANDOM	100
	GRTR?	50,STACK \?ELS14
	RETURN	MACHINE-ROOM
?ELS14:	RETURN	TEA-ROOM
?ELS5:	EQUAL?	PRSO,P?EAST \?ELS18
	RETURN	MACHINE-ROOM
?ELS18:	EQUAL?	PRSO,P?SE /?THN21
	EQUAL?	PRSO,P?OUT \?ELS20
?THN21:	RETURN	TEA-ROOM
?ELS20:	PRINTI	"You can't go that way."
	CRLF	
	RFALSE	


	.FUNCT	BUTTONS
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	WINNER,ADVENTURER \?ELS10
	CALL	JIGS-UP,STR?234
	RSTACK	
?ELS10:	EQUAL?	PRSO,SQUARE-BUTTON \?ELS12
	ZERO?	CAROUSEL-ZOOM-FLAG /?ELS17
	PRINTR	"Nothing seems to happen."
?ELS17:	SET	'CAROUSEL-ZOOM-FLAG,TRUE-VALUE
	PRINTR	"The whirring increases in intensity."
?ELS12:	EQUAL?	PRSO,ROUND-BUTTON \?ELS26
	ZERO?	CAROUSEL-ZOOM-FLAG /?ELS31
	SET	'CAROUSEL-ZOOM-FLAG,FALSE-VALUE
	PRINTR	"The whirring decreases in intensity."
?ELS31:	PRINTR	"Nothing seems to happen."
?ELS26:	EQUAL?	PRSO,TRIANGULAR-BUTTON \FALSE
	ZERO?	CAROUSEL-FLIP-FLAG \?PRD41
	PUSH	1
	JUMP	?PRD42
?PRD41:	PUSH	0
?PRD42:	SET	'CAROUSEL-FLIP-FLAG,STACK
	IN?	IRON-BOX,CAROUSEL-ROOM \?ELS47
	PRINTI	"A dull thump is heard in the distance."
	CRLF	
	FSET?	IRON-BOX,INVISIBLE \?ELS52
	FCLEAR	IRON-BOX,INVISIBLE
	JUMP	?CND50
?ELS52:	FSET	IRON-BOX,INVISIBLE
?CND50:	FSET?	IRON-BOX,INVISIBLE /TRUE
	FCLEAR	CAROUSEL-ROOM,TOUCHBIT
	RTRUE	
?ELS47:	PRINTR	"Click."


	.FUNCT	SPHERE-FCN,FL
	ZERO?	CAGE-SOLVE-FLAG \?ELS3
	EQUAL?	PRSA,V?PUT,V?MOVE,V?TAKE \?ELS3
	SET	'FL,TRUE-VALUE
	JUMP	?CND1
?ELS3:	SET	'FL,FALSE-VALUE
?CND1:	ZERO?	FL /?ELS12
	EQUAL?	ADVENTURER,WINNER \?ELS12
	PRINTI	"As you reach for the sphere, a solid steel cage falls from the ceiling to entrap you. To make matters worse, poisonous gas starts coming into the room."
	CRLF	
	CRLF	
	IN?	ROBOT,HERE \?CND17
	MOVE	ROBOT,IN-CAGE
	FSET	ROBOT,NDESCBIT
?CND17:	CALL	GOTO,IN-CAGE
	MOVE	CAGE,HERE
	FSET	CAGE,NDESCBIT
	FCLEAR	CAGE,INVISIBLE
	CALL	QUEUE,I-SPHERE,6
	PUT	STACK,0,1
	RTRUE	
?ELS12:	ZERO?	FL /?ELS21
	FSET	PALANTIR-1,INVISIBLE
	REMOVE	ROBOT
	FSET	PRSO,INVISIBLE
	MOVE	CAGE,CAGE-ROOM
	FCLEAR	CAGE,INVISIBLE
	CALL	JIGS-UP,STR?235
	RTRUE	
?ELS21:	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \FALSE
	CALL	PALANTIR
	RSTACK	


	.FUNCT	I-SPHERE
	EQUAL?	HERE,CAGE-ROOM,IN-CAGE \FALSE
	FSET	PALANTIR-1,INVISIBLE
	CALL	MUNG-ROOM,CAGE-ROOM,STR?236
	CALL	JIGS-UP,STR?237
	RSTACK	


	.FUNCT	IN-CAGE-FCN,RARG
	ZERO?	CAGE-SOLVE-FLAG /FALSE
	SET	'HERE,CAGE-ROOM
	RETURN	HERE


	.FUNCT	ROBOT-FCN,RARG=M-OBJECT
	EQUAL?	WINNER,ROBOT \?ELS5
	EQUAL?	PRSA,V?SGIVE /FALSE
	EQUAL?	PRSA,V?FOLLOW \?ELS12
	PRINTR	"""My memory circuits are not that advanced. I can move as directed, though."""
?ELS12:	EQUAL?	PRSA,V?MOVE,V?TAKE,V?RAISE \?ELS16
	EQUAL?	PRSO,CAGE \?ELS16
	PRINTI	"The cage shakes and is hurled across the room. It's hard to say, but the robot appears to be smiling."
	CRLF	
	CRLF	
	CALL	INT,I-SPHERE
	PUT	STACK,0,0
	SET	'WINNER,ADVENTURER
	CALL	GOTO,CAGE-ROOM
	MOVE	MANGLED-CAGE,CAGE-ROOM
	FCLEAR	ROBOT,NDESCBIT
	FSET	PALANTIR-1,TAKEBIT
	MOVE	ROBOT,CAGE-ROOM
	SET	'CAGE-SOLVE-FLAG,TRUE-VALUE
	RETURN	CAGE-SOLVE-FLAG
?ELS16:	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS22
	IN?	ADVENTURER,HERE \TRUE
	PRINTR	"""I am sorry but that is difficult for a being with no mouth."""
?ELS22:	RANDOM	100
	GRTR?	2,STACK \?ELS29
	CALL	META-LOC,ADVENTURER
	EQUAL?	STACK,HERE \?ELS29
	PRINTR	"""Buzz! Buzz! Buzz! My circuits are getting rusty. Try again."""
?ELS29:	EQUAL?	PRSA,V?EXAMINE,V?READ \?ELS35
	CALL	META-LOC,ADVENTURER
	EQUAL?	STACK,HERE \TRUE
	PRINTR	"""My vision is not sufficiently acute to do that."""
?ELS35:	EQUAL?	PRSA,V?THROW,V?PUT,V?DROP \?ELS42
	CALL	META-LOC,ADVENTURER
	EQUAL?	STACK,HERE \FALSE
	IN?	PRSO,ROBOT \?ELS49
	PRINTI	"""Whirr, buzz, click!"""
	CRLF	
	RFALSE	
?ELS49:	PRINTR	"""Click! I don't have that. Buzz! Whirr!"""
?ELS42:	EQUAL?	PRSA,V?WALK /?THN58
	EQUAL?	PRSA,V?TURN,V?PUSH,V?TAKE \?ELS57
	FSET?	PRSO,ACTORBIT /?ELS57
?THN58:	CALL	META-LOC,ADVENTURER
	EQUAL?	STACK,HERE \FALSE
	RANDOM	100
	GRTR?	80,STACK \?ELS66
	PRINTI	"""Whirr, buzz, click!"""
	CRLF	
	RFALSE	
?ELS66:	PRINTI	"""Buzz, click, whirr!"""
	CRLF	
	RFALSE	
?ELS57:	CALL	META-LOC,ADVENTURER
	EQUAL?	STACK,HERE \TRUE
	PRINTR	"""My programming is insufficient to allow me to perform that task."""
?ELS5:	EQUAL?	PRSA,V?CLOSE,V?LOOK-INSIDE,V?OPEN \?ELS81
	PRINTR	"There's no access panel or door on the robot."
?ELS81:	EQUAL?	PRSA,V?GIVE \?ELS85
	EQUAL?	PRSI,ROBOT \?ELS85
	MOVE	PRSO,ROBOT
	PRINTI	"The robot gladly takes the "
	PRINTD	PRSO
	PRINTR	" and nods his head-like appendage in thanks."
?ELS85:	EQUAL?	PRSA,V?MUNG,V?THROW \FALSE
	PRINTI	"The robot falls to the ground and (being of shoddy construction) disintegrates before your eyes."
	CRLF	
	EQUAL?	PRSA,V?THROW \?ELS98
	PUSH	PRSI
	JUMP	?CND94
?ELS98:	ZERO?	PRSO /?PRD96
	PUSH	1
	JUMP	?CND94
?PRD96:	PUSH	0
?CND94:	REMOVE	STACK
	RTRUE	


	.FUNCT	BILLS-OBJECT
	SET	'BANK-SOLVE-FLAG,TRUE-VALUE
	EQUAL?	PRSA,V?BURN \?ELS5
	PRINTI	"Nothing like having money to burn!"
	CRLF	
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?EAT \FALSE
	PRINTR	"Talk about eating rich foods!"


	.FUNCT	BKLEAVEE,RM=TELLER-EAST
	CALL	HELD?,BILLS
	ZERO?	STACK \?THN6
	CALL	HELD?,PORTRAIT
	ZERO?	STACK /?ELS5
?THN6:	PRINTI	"An alarm rings briefly, and an invisible force bars your way."
	CRLF	
	RFALSE	
?ELS5:	RETURN	RM


	.FUNCT	BKLEAVEW
	CALL	BKLEAVEE,TELLER-WEST
	RSTACK	


	.FUNCT	DEPOSITORY-FCN,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	CALL	LKP,PRSO,SCOL-ROOMS >SCOL-ROOM
	RETURN	SCOL-ROOM


	.FUNCT	TELLER-ROOM,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a small room, which was used by a bank officer who retrieved safety deposit boxes for the customer. On the north side of the room is a sign which reads  ""Viewing Room"". On the "
	EQUAL?	HERE,TELLER-WEST \?ELS10
	PRINTI	"west"
	JUMP	?CND8
?ELS10:	PRINTI	"east"
?CND8:	PRINTR	" side of the room, above an open door, is a sign reading:

          BANK PERSONNEL ONLY
"


	.FUNCT	SCOL-OBJECT,OBJ=0
	EQUAL?	PRSA,V?TAKE,V?MOVE,V?PUSH /?THN6
	EQUAL?	PRSA,V?RUB \?ELS5
?THN6:	PRINTR	"As you try, your hand seems to go through it."
?ELS5:	EQUAL?	PRSA,V?ATTACK \?ELS11
	ZERO?	PRSI /?ELS11
	PRINTI	"The "
	PRINTD	PRSI
	PRINTR	" goes through it."
?ELS11:	EQUAL?	PRSA,V?OVERBOARD,V?THROW \FALSE
	EQUAL?	PRSI,CURTAIN,OBJ \FALSE
	IN?	PRSO,WINNER \?ELS24
	CALL	V-THROUGH,PRSO
	RSTACK	
?ELS24:	PRINTR	"You don't have that!"


	.FUNCT	GET-WALL,RM,W
	SET	'W,SCOL-WALLS
?PRG1:	GET	W,0
	EQUAL?	STACK,RM \?ELS5
	RETURN	W
?ELS5:	ADD	W,6 >W
	JUMP	?PRG1


	.FUNCT	SCOLWALL
	EQUAL?	PRSA,V?PUT,V?OVERBOARD,V?THROW \FALSE
	EQUAL?	HERE,SCOL-ACTIVE \FALSE
	CALL	GET-WALL,HERE
	GET	STACK,1
	EQUAL?	PRSI,STACK \FALSE
	CALL	SCOL-OBJECT,PRSI
	RSTACK	


	.FUNCT	SCOL-GO,OBJ
	SET	'SCOL-ACTIVE,SCOL-ROOM
	ZERO?	OBJ /?ELS5
	CALL	SCOL-OBJ,OBJ,0,SCOL-ROOM
	RSTACK	
?ELS5:	CALL	SCOL-THROUGH,12,SCOL-ROOM
	RSTACK	


	.FUNCT	SCOL-OBJ,OBJ,CINT,RM
	CALL	QUEUE,I-CURTAIN,CINT
	PUT	STACK,0,1
	MOVE	OBJ,RM
	EQUAL?	RM,DEPOSITORY \?ELS5
	PRINTI	"The "
	PRINTD	OBJ
	PRINTR	" passes through the wall and vanishes."
?ELS5:	PRINTI	"The curtain dims slightly as the "
	PRINTD	OBJ
	PRINTI	" passes through."
	CRLF	
	SET	'SCOL-ROOM,FALSE-VALUE
	RTRUE	


	.FUNCT	SCOL-THROUGH,CINT,RM
	CALL	QUEUE,I-CURTAIN,CINT
	PUT	STACK,0,1
	PRINTI	"You feel somewhat disoriented as you pass through..."
	CRLF	
	CRLF	
	CALL	GOTO,RM
	RSTACK	


	.FUNCT	I-CURTAIN
	SET	'SCOL-ACTIVE,FALSE-VALUE
	EQUAL?	HERE,VAULT \?ELS5
	CALL	JIGS-UP,STR?238
	RSTACK	
?ELS5:	EQUAL?	HERE,VIEWING-EAST,VIEWING-WEST,SMALL-ROOM \FALSE
	PRINTI	"You hear a faint voice say ""Curtain Door Closed."""
	CRLF	
	EQUAL?	HERE,SMALL-ROOM \FALSE
	ZERO?	ZGNOME-FLAG \TRUE
	CALL	QUEUE,I-ZGNOME,3
	PUT	STACK,0,1
	SET	'ZGNOME-FLAG,TRUE-VALUE
	RETURN	ZGNOME-FLAG


	.FUNCT	I-ZGNOME
	EQUAL?	HERE,SMALL-ROOM \FALSE
	CALL	QUEUE,I-ZGNOME-OUT,12
	PUT	STACK,0,1
	PRINTI	"An epicene gnome of Zurich wearing a three-piece suit and carrying a safety deposit box materializes in the room."
	IN?	WAND,WINNER \?ELS12
	PRINTR	" He notices the wand and dematerializes speedily."
?ELS12:	PRINTI	" ""You seem to have forgotten to deposit your valuables,"" he says, tapping the lid of the box impatiently. ""We don't usually allow customers to use the boxes here, but we can make this ONE exception, I suppose..."" He looks askance at you over his wire-rimmed bifocals."
	CRLF	
	MOVE	GNOME-OF-ZURICH,HERE
	RTRUE	


	.FUNCT	BOX-F
	PRINTR	"The gnome clutches it possessively."


	.FUNCT	ZGNOME-FCN
	EQUAL?	PRSA,V?TELL \?ELS5
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"The gnome appears increasingly impatient."
?ELS5:	EQUAL?	PRSA,V?THROW,V?GIVE \?ELS9
	EQUAL?	PRSI,GNOME-OF-ZURICH \?ELS9
	GETPT	PRSO,P?VALUE
	ZERO?	STACK /?ELS16
	PRINTI	"The gnome carefully places the "
	PRINTD	PRSO
	PRINTI	" in the deposit box. ""Let me show you the way out,"" he says, making it clear he will be pleased to see the last of you. Then, you are momentarily disoriented, and when you recover you are back at the Bank Entrance."
	CRLF	
	REMOVE	GNOME-OF-ZURICH
	REMOVE	PRSO
	CALL	INT,I-ZGNOME-OUT
	PUT	STACK,0,0
	CALL	GOTO,BANK-ENTRANCE
	RTRUE	
?ELS16:	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS20
	REMOVE	GNOME-OF-ZURICH
	MOVE	PRSO,HERE
	CALL	INT,I-ZGNOME
	PUT	STACK,0,0
	CALL	INT,I-ZGNOME-OUT
	PUT	STACK,0,0
	PRINTR	"""You are so very gracious. I really cannot accept."" he says. He disappears, a wry smile on his lips."
?ELS20:	PRINTI	"""I wouldn't put THAT in a safety deposit box,"" remarks the gnome with disdain, tossing it over his shoulder, where it disappears with an understated ""pop""."
	CRLF	
	CALL	REMOVE-CAREFULLY,PRSO
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?ATTACK \?ELS28
	PRINTI	"The gnome says ""Well, I never..."" and disappears with a snap of his fingers, leaving you alone."
	CRLF	
	REMOVE	GNOME-OF-ZURICH
	CALL	INT,I-ZGNOME-OUT
	PUT	STACK,0,0
	RTRUE	
?ELS28:	PRINTR	"The gnome appears increasingly impatient."


	.FUNCT	I-ZGNOME-OUT
	REMOVE	GNOME-OF-ZURICH
	EQUAL?	HERE,SMALL-ROOM \FALSE
	PRINTR	"The gnome looks impatient: ""I may have another customer waiting; you'll just have to fend for yourself, I'm afraid."" He disappears, leaving you alone."


	.FUNCT	BOMB?,O
	EQUAL?	O,BRICK \FALSE
	IN?	FUSE,BRICK \FALSE
	CALL	INT,I-FUSE
	GET	STACK,C-ENABLED?
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	GO&LOOK,RM,OHERE,OLIT,OSEEN=0
	SET	'OHERE,HERE
	FSET?	OHERE,TOUCHBIT \?CND1
	SET	'OSEEN,TRUE-VALUE
?CND1:	SET	'OLIT,LIT
	SET	'HERE,RM
	CALL	LIT?,RM >LIT
	CALL	PERFORM,V?LOOK
	ZERO?	OSEEN \?CND4
	FCLEAR	OHERE,TOUCHBIT
?CND4:	SET	'HERE,OHERE
	SET	'LIT,OLIT
	RTRUE	


	.FUNCT	TINY-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a tiny room carved out of the wall of the ravine. There is an exit down a precarious climb. "
	CALL	P-DOOR,STR?239,LID-1,KEYHOLE-1
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOOK /FALSE
	CALL	PCHECK
	RFALSE	


	.FUNCT	DREARY-ROOM-FCN,RARG,?TMP1
	EQUAL?	RARG,M-LOOK \?CND1
	PRINTI	"This is a small and rather dreary room, eerily illuminated by a red glow emanating from a crack in one wall. The light falls upon a dusty wooden table in the center of the room. "
	CALL	P-DOOR,STR?240,LID-2,KEYHOLE-2
	RTRUE	
?CND1:	CALL	PCHECK >?TMP1
	RFALSE	


	.FUNCT	PCHECK,LID
	CALL	PLID >LID
	SET	'PLOOK-FLAG,FALSE-VALUE
	IN?	KEY,KEYHOLE-1 /?THN4
	IN?	KEY,KEYHOLE-2 \?ELS3
?THN4:	FSET	KEY,NDESCBIT
	JUMP	?CND1
?ELS3:	FCLEAR	KEY,NDESCBIT
?CND1:	CALL	HELD?,PLACE-MAT
	ZERO?	STACK /?CND8
	SET	'MUD-FLAG,FALSE-VALUE
?CND8:	ZERO?	MUD-FLAG /?ELS15
	MOVE	PLACE-MAT,HERE
	FSET	PLACE-MAT,NDESCBIT
	RTRUE	
?ELS15:	FCLEAR	PLACE-MAT,NDESCBIT
	RTRUE	


	.FUNCT	P-DOOR,STR,LID,KEYHOLE,F
	ZERO?	PLOOK-FLAG /?CND1
	SET	'PLOOK-FLAG,FALSE-VALUE
	RFALSE	
?CND1:	PRINTI	"On the "
	PRINT	STR
	PRINTI	" side of the room is a massive wooden door, which has a small window barred with iron. A formidable bolt lock is set within the door frame. A keyhole "
	FSET?	LID,OPENBIT /?CND7
	PRINTI	"covered by a thin metal lid "
?CND7:	PRINTI	"lies within the lock."
	FIRST?	KEYHOLE >F \?CND14
	PRINTI	" A "
	PRINTD	F
	PRINTI	" is in place within the keyhole."
?CND14:	ZERO?	MUD-FLAG /?CND19
	PRINTI	" The edge of a place mat is visible under the door."
	ZERO?	MATOBJ /?CND19
	PRINTI	" Lying on the place mat is a "
	PRINTD	MATOBJ
	PRINTI	"."
?CND19:	CRLF	
	RTRUE	


	.FUNCT	PLID,OBJ1=LID-1,OBJ2=LID-2
	IN?	OBJ1,HERE \?ELS5
	RETURN	OBJ1
?ELS5:	RETURN	OBJ2


	.FUNCT	PKH,KEYHOLE,THIS=0
	EQUAL?	KEYHOLE,KEYHOLE-1 \?ELS5
	ZERO?	THIS \?ELS5
	RETURN	KEYHOLE-2
?ELS5:	EQUAL?	KEYHOLE,KEYHOLE-1 /?ELS9
	ZERO?	THIS /?ELS9
	RETURN	KEYHOLE-2
?ELS9:	RETURN	KEYHOLE-1


	.FUNCT	PKH-FCN,OBJ,KH
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	FSET?	LID-1,OPENBIT \?ELS10
	FSET?	LID-2,OPENBIT \?ELS10
	FIRST?	KEYHOLE-1 /?ELS10
	FIRST?	KEYHOLE-2 /?ELS10
	EQUAL?	HERE,DREARY-ROOM \?ELS17
	PUSH	TINY-ROOM
	JUMP	?CND13
?ELS17:	PUSH	DREARY-ROOM
?CND13:	CALL	LIT?,STACK
	ZERO?	STACK /?ELS10
	PRINTR	"You can see a lighted room at the other end."
?ELS10:	PRINTR	"No light can be seen through the keyhole."
?ELS5:	EQUAL?	PRSA,V?PUT \FALSE
	CALL	PLID
	FSET?	STACK,OPENBIT \?ELS32
	CALL	PKH,PRSI,TRUE-VALUE
	FIRST?	STACK \?ELS37
	PRINTR	"The keyhole is blocked."
?ELS37:	EQUAL?	PRSO,LETTER-OPENER,KEY \?ELS41
	CALL	PKH,PRSI >KH
	FIRST?	KH \FALSE
	PRINTI	"There is a faint noise from behind the door and a small cloud of dust rises from beneath it."
	CRLF	
	FIRST?	KH >OBJ /?KLU61
?KLU61:	REMOVE	OBJ
	ZERO?	MUD-FLAG /FALSE
	SET	'MATOBJ,OBJ
	RFALSE	
?ELS41:	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" doesn't fit."
?ELS32:	PRINTR	"The lid is in the way."


	.FUNCT	PLID-FCN
	EQUAL?	PRSA,V?MOVE,V?RAISE,V?OPEN \?ELS5
	FSET?	PRSO,OPENBIT \?ELS8
	CALL	RANDOM-ELEMENT,DUMMY
	PRINT	STACK
	CRLF	
	JUMP	?CND6
?ELS8:	PRINTI	"The lid is now open."
	CRLF	
?CND6:	FSET	PRSO,OPENBIT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOWER,V?CLOSE \?ELS16
	EQUAL?	HERE,DREARY-ROOM \?ELS26
	PUSH	KEYHOLE-2
	JUMP	?CND22
?ELS26:	PUSH	KEYHOLE-1
?CND22:	FIRST?	STACK \?ELS21
	PRINTR	"The keyhole is occupied."
?ELS21:	PRINTI	"The lid covers the keyhole."
	CRLF	
	FCLEAR	PRSO,OPENBIT
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?LOOK-BEHIND \FALSE
	PRINTR	"There's a keyhole behind the lid."


	.FUNCT	ROOM?,OBJ,NOBJ
?PRG1:	LOC	OBJ >NOBJ
	ZERO?	NOBJ /FALSE
	EQUAL?	NOBJ,WINNER /FALSE
	EQUAL?	NOBJ,ROOMS \?CND3
	RETURN	OBJ
?CND3:	SET	'OBJ,NOBJ
	JUMP	?PRG1


	.FUNCT	PALANTIR
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	EQUAL?	PRSO,PALANTIR-1 \?ELS10
	PUSH	PALANTIR-2
	JUMP	?CND6
?ELS10:	EQUAL?	PRSO,PALANTIR-2 \?ELS12
	PUSH	PALANTIR-3
	JUMP	?CND6
?ELS12:	EQUAL?	PRSO,PALANTIR-3 \?ELS14
	PUSH	PALANTIR-1
	JUMP	?CND6
?ELS14:	PUSH	PALANTIR-4
?CND6:	CALL	PALANTIR-LOOK,STACK
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS18
	PRINTR	"There is something misty in the sphere. Perhaps if you were to look into it..."
?ELS18:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,PALANTIR-3 \FALSE
	PUTP	PRSO,P?LDESC,FALSE-VALUE
	RFALSE	


	.FUNCT	DEAD-PALANTIR,RARG,P
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are inside a huge crystalline sphere filled with thin "
	EQUAL?	HERE,DEAD-PALANTIR-1 \?ELS12
	SET	'P,PALANTIR-1
	PUSH	STR?241
	JUMP	?CND8
?ELS12:	EQUAL?	HERE,DEAD-PALANTIR-2 \?ELS14
	SET	'P,PALANTIR-2
	PUSH	STR?242
	JUMP	?CND8
?ELS14:	SET	'P,PALANTIR-3
	PUSH	STR?243
?CND8:	PRINT	STACK
	PRINTI	" mist. The mist becomes "
	EQUAL?	HERE,DEAD-PALANTIR-1 \?ELS21
	PUSH	STR?242
	JUMP	?CND17
?ELS21:	EQUAL?	HERE,DEAD-PALANTIR-2 \?ELS23
	PUSH	STR?243
	JUMP	?CND17
?ELS23:	PUSH	STR?244
?CND17:	PRINT	STACK
	PRINTI	" to the west."
	CRLF	
	PRINTI	"You strain to look out through the mist... "
	CRLF	
	FSET?	P,TOUCHBIT \?ELS30
	CALL	PALANTIR-LOOK,P,TRUE-VALUE
	RTRUE	
?ELS30:	EQUAL?	P,PALANTIR-1 \?ELS32
	PRINTR	"You see a small room with a sign on the wall, but it is too blurry to read."
?ELS32:	EQUAL?	P,PALANTIR-2 \?ELS36
	PRINTR	"You look out into a large, dreary room with a great door and a huge table. There is an odd glow to the mist."
?ELS36:	EQUAL?	P,PALANTIR-3 \TRUE
	PRINTI	"A strange blurry room is barely visible."
	IN?	SERPENT,AQUARIUM \?CND43
	RANDOM	100
	GRTR?	25,STACK \?CND43
	PRINTI	" An odd sinuous shadow crosses the mist as you look."
?CND43:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	EQUAL?	HERE,DEAD-PALANTIR-4 \FALSE
	PRINTI	"You follow a corridor of black mist into a black walled spherical room."
	IN?	GENIE,PENTAGRAM-ROOM \?CND56
	PRINTI	" The room is empty. A huge face looks down on you from outside and laughs sardonically. It doesn't look like you're getting out of this predicament!"
	CRLF	
	CALL	FINISH
?CND56:	PRINTI	" As you enter, a huge and horrible face materializes out of the mist.

""What brings you here to trouble my imprisonment, wanderer?"" it asks. Hearing no immediate answer, it studies you for a moment."
	CRLF	
	LESS?	DEATHS,3 /?ELS67
	PRINTI	"""Not you again! This is getting tedious. You'll obviously never be much help to me. Better luck next time, oh wondrous adventurer."" The face disappears and everything goes black."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS67:	PRINTI	"""Perhaps you may be of some use to me in gaining my freedom from this place. Return to your foolish quest! I shall not destroy you this time. Mayhap you will repay this favor in kind someday."" The face vanishes and the mist begins to swirl. When it clears you are returned to the world of life."
	CRLF	
	SET	'DEAD,FALSE-VALUE
	CALL	GOTO,INSIDE-BARROW
	RTRUE	


	.FUNCT	GLOBAL-PALANTIRS
	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \?ELS5
	CALL	DEAD-PALANTIR,M-LOOK
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTR	"The sphere is unbreakable."


	.FUNCT	PALANTIR-LOOK,OBJ,INSIDE?=0,RM,OHERE
	EQUAL?	OBJ,PALANTIR-4 \?CND1
	PRINTR	"As you peer into the sphere, a strange vision takes shape...a huge and fearful face with yellow eyes. The face peers out at you expectantly."
?CND1:	EQUAL?	HERE,OBJ /?PRD6
	PUSH	0
	JUMP	?PRD7
?PRD6:	PUSH	1
?PRD7:	SET	'RM,STACK
	ZERO?	RM /?THN11
	CALL	LIT?,RM
	ZERO?	STACK \?ELS10
?THN11:	PRINTR	"You see only darkness."
?ELS10:	IN?	OBJ,RM /?THN17
	LOC	OBJ
	CALL	SEE-INSIDE?,STACK
	ZERO?	STACK /?ELS16
?THN17:	SET	'OHERE,HERE
	ZERO?	INSIDE? /?ELS21
	PRINTI	"As you peer through the mist, a strangely colored vision of a huge room takes shape..."
	CRLF	
	CRLF	
	JUMP	?CND19
?ELS21:	PRINTI	"As you peer into the sphere, a strange vision takes shape of a distant room, which can be described clearly...."
	CRLF	
	CRLF	
?CND19:	FSET	OBJ,INVISIBLE
	CALL	GO&LOOK,RM
	EQUAL?	OHERE,RM \?CND29
	PRINTI	"An astonished adventurer is staring into a crystal sphere."
	CRLF	
?CND29:	FCLEAR	OBJ,INVISIBLE
	ZERO?	INSIDE? \TRUE
	PRINTR	"The vision fades, revealing only an ordinary crystal sphere."
?ELS16:	PRINTR	"You see only darkness."


	.FUNCT	PWINDOW-FCN
	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS5
	SET	'PLOOK-FLAG,TRUE-VALUE
	FSET?	PDOOR,OPENBIT \?ELS10
	PRINTR	"The door is open, dummy."
?ELS10:	EQUAL?	HERE,DREARY-ROOM \?ELS14
	CALL	GO&LOOK,TINY-ROOM
	RSTACK	
?ELS14:	CALL	GO&LOOK,DREARY-ROOM
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"Perhaps if you were diced...."


	.FUNCT	PDOOR-FCN,K
	EQUAL?	PRSA,V?LOOK-UNDER \?ELS5
	ZERO?	MUD-FLAG /?ELS5
	PRINTR	"The place mat is under the door."
?ELS5:	EQUAL?	PRSA,V?UNLOCK \?ELS11
	EQUAL?	PRSI,KEY \?ELS16
	CALL	PLID,KEYHOLE-1,KEYHOLE-2
	FIRST?	STACK >K \?ELS21
	EQUAL?	K,KEY /?ELS21
	PRINTR	"The keyhole is blocked."
?ELS21:	PRINTI	"The door is now unlocked."
	CRLF	
	SET	'PUNLOCK-FLAG,TRUE-VALUE
	RETURN	PUNLOCK-FLAG
?ELS16:	EQUAL?	PRSI,GOLD-KEY \?ELS31
	PRINTR	"It doesn't fit the lock."
?ELS31:	PRINTR	"It can't be unlocked with that."
?ELS11:	EQUAL?	PRSA,V?LOCK \?ELS39
	EQUAL?	PRSI,KEY \?ELS44
	PRINTI	"The door is locked."
	CRLF	
	SET	'PUNLOCK-FLAG,FALSE-VALUE
	RTRUE	
?ELS44:	EQUAL?	PRSI,GOLD-KEY \?ELS48
	PRINTR	"It doesn't fit the lock."
?ELS48:	PRINTR	"It can't be locked with that."
?ELS39:	EQUAL?	PRSA,V?PUT-UNDER \?ELS56
	EQUAL?	PRSO,ROBOT-LABEL \?ELS61
	PRINTI	"The paper is very small and vanishes under the door."
	CRLF	
	EQUAL?	HERE,TINY-ROOM \?ELS68
	PUSH	DREARY-ROOM
	JUMP	?CND64
?ELS68:	PUSH	TINY-ROOM
?CND64:	MOVE	PRSO,STACK
	RTRUE	
?ELS61:	EQUAL?	PRSO,NEWSPAPER \FALSE
	PRINTR	"The newspaper crumples up and won't go under the door."
?ELS56:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	ZERO?	PUNLOCK-FLAG /?ELS81
	CALL	OPEN-CLOSE,PRSO,STR?245,STR?246
	RSTACK	
?ELS81:	PRINTR	"The door is locked."


	.FUNCT	PKEY-FCN
	EQUAL?	PRSA,V?TURN \FALSE
	ZERO?	PUNLOCK-FLAG /?ELS10
	CALL	PERFORM,V?LOCK,PDOOR,PRSO
	RSTACK	
?ELS10:	CALL	PERFORM,V?UNLOCK,PDOOR,PRSO
	RSTACK	


	.FUNCT	PLACE-MAT-FCN
	EQUAL?	PRSA,V?PUT-UNDER \?ELS5
	EQUAL?	PRSI,PDOOR \?ELS10
	PRINTI	"The place mat fits easily under the door."
	CRLF	
	MOVE	PRSO,HERE
	SET	'MUD-FLAG,TRUE-VALUE
	RETURN	MUD-FLAG
?ELS10:	EQUAL?	PRSI,WIZ-DOOR,RIDDLE-DOOR,CRYPT-DOOR \FALSE
	PRINTR	"There's not enough room under this door."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	ZERO?	MATOBJ /FALSE
	MOVE	MATOBJ,HERE
	PRINTI	"As the place mat is moved, a "
	PRINTD	MATOBJ
	PRINTI	" falls from it and onto the floor."
	CRLF	
	SET	'MATOBJ,FALSE-VALUE
	SET	'MUD-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	WISH-FCN
	EQUAL?	PRSA,V?MAKE \FALSE
	EQUAL?	HERE,WELL-BOTTOM \?ELS10
	IN?	COIN,HERE \?ELS10
	PRINTI	"A whispering voice replies: ""Water makes the bucket go."" Unfortunately, wishing makes the coin go...."
	CRLF	
	REMOVE	COIN
	RTRUE	
?ELS10:	PRINTR	"No one is listening."


	.FUNCT	WELL-FCN
	FSET?	PRSO,TAKEBIT \?ELS5
	EQUAL?	PRSA,V?DROP,V?PUT,V?THROW \?ELS5
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is now sitting at the bottom of the well."
	CRLF	
	MOVE	PRSO,WELL-BOTTOM
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-DOWN,V?CLIMB-UP \FALSE
	PRINTR	"You can't climb the well."


	.FUNCT	MATCH-FCN,CNT
	EQUAL?	PRSA,V?BURN,V?LAMP-ON \?ELS5
	EQUAL?	PRSO,MATCH \?ELS5
	GRTR?	MATCH-COUNT,0 \?CND8
	DEC	'MATCH-COUNT
?CND8:	GRTR?	MATCH-COUNT,0 /?ELS15
	PRINTR	"I'm afraid you have run out of matches."
?ELS15:	FSET	MATCH,FLAMEBIT
	FSET	MATCH,ONBIT
	CALL	QUEUE,I-MATCH,2
	PUT	STACK,0,1
	PRINTR	"One of the matches starts to burn."
?ELS5:	EQUAL?	PRSA,V?LAMP-OFF \?ELS23
	FSET?	MATCH,FLAMEBIT \?ELS23
	PRINTI	"The match is out."
	CRLF	
	FCLEAR	MATCH,FLAMEBIT
	FCLEAR	MATCH,ONBIT
	CALL	QUEUE,I-MATCH,0
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?COUNT \?ELS29
	PRINTI	"You have "
	SUB	MATCH-COUNT,1 >CNT
	PRINTN	CNT
	PRINTI	" match"
	EQUAL?	CNT,1 /?ELS36
	PRINTI	"es."
	JUMP	?CND34
?ELS36:	PRINTI	"."
?CND34:	CRLF	
	RTRUE	
?ELS29:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	MATCH,ONBIT \?ELS47
	PRINTI	"A match is burning."
	JUMP	?CND45
?ELS47:	PRINTI	"No match is burning."
?CND45:	CRLF	
	RTRUE	


	.FUNCT	I-MATCH
	PRINTI	"The match has gone out."
	CRLF	
	FCLEAR	MATCH,FLAMEBIT
	FCLEAR	MATCH,ONBIT
	RTRUE	


	.FUNCT	LANTERN
	EQUAL?	PRSA,V?THROW \?ELS5
	EQUAL?	PRSO,LAMP \?ELS5
	PRINTI	"The lamp has smashed into the floor, and the light has gone out."
	CRLF	
	CALL	INT,I-LANTERN
	PUT	STACK,0,0
	REMOVE	LAMP
	MOVE	BROKEN-LAMP,HERE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS11
	FSET?	LAMP,RMUNGBIT \?ELS16
	PRINTR	"A burned-out lamp won't light."
?ELS16:	CALL	INT,I-LANTERN
	PUT	STACK,0,1
	RFALSE	
?ELS11:	EQUAL?	PRSA,V?LAMP-OFF \?ELS22
	FSET?	LAMP,RMUNGBIT \?ELS27
	PRINTR	"The lamp has already burned out."
?ELS27:	CALL	INT,I-LANTERN
	PUT	STACK,0,0
	RFALSE	
?ELS22:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	LAMP,RMUNGBIT \?ELS36
	PRINTI	"The lamp has burned out."
	JUMP	?CND34
?ELS36:	FSET?	LAMP,ONBIT \?ELS40
	PRINTI	"The lamp is on."
	JUMP	?CND34
?ELS40:	PRINTI	"The lamp is turned off."
?CND34:	CRLF	
	RTRUE	


	.FUNCT	I-LANTERN,TICK,TBL
	VALUE	'LAMP-TABLE >TBL
	GET	TBL,0 >TICK
	CALL	QUEUE,I-LANTERN,TICK
	PUT	STACK,0,1
	CALL	LIGHT-INT,LAMP,TBL,TICK
	ZERO?	TICK /FALSE
	ADD	TBL,4 >LAMP-TABLE
	RETURN	LAMP-TABLE


	.FUNCT	LIGHT-INT,OBJ,TBL,TICK
	ZERO?	TICK \?CND1
	FCLEAR	OBJ,ONBIT
	FSET	OBJ,RMUNGBIT
?CND1:	CALL	HELD?,OBJ
	ZERO?	STACK \?THN9
	IN?	OBJ,HERE \FALSE
?THN9:	ZERO?	TICK \?ELS15
	PRINTI	"You'd better have more light than from the "
	PRINTD	OBJ
	PRINTR	"."
?ELS15:	GET	TBL,1
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	RIDDLE-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a room which is bare on all sides. There is an exit down in the northwest corner of the room. To the east is a great "
	FSET?	RIDDLE-DOOR,OPENBIT \?ELS10
	PRINTI	"open"
	JUMP	?CND8
?ELS10:	PRINTI	"closed"
?CND8:	PRINTI	" door made of stone. Above the stone, the following words are written: ""No man shall pass this door without solving this riddle:

  What is tall as a house,
    round as a cup,
      and all the king's horses
        can't draw it up?""
"
	RTRUE	
?ELS5:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?SAY,V?ANSWER \FALSE
	FSET?	RIDDLE-DOOR,OPENBIT /FALSE
	GET	P-LEXV,P-CONT
	EQUAL?	STACK,W?WELL /?THN31
	ADD	P-CONT,2
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?WELL \?ELS30
?THN31:	PRINTI	"There is a deafening clap of thunder and the stone door quietly swings open to reveal a passageway beyond."
	CRLF	
	CALL	SCORE-UPD,5
	FSET	RIDDLE-DOOR,OPENBIT
	JUMP	?CND26
?ELS30:	PRINTI	"A hollow laugh seems to come from the stone door."
	CRLF	
?CND26:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	RIDDLE-DOOR-FCN
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	RIDDLE-DOOR,OPENBIT \?ELS10
	PRINTR	"It is open!"
?ELS10:	PRINTR	"The door can only be opened by answering the riddle."
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	RIDDLE-DOOR,OPENBIT \?ELS23
	PRINTR	"Not a chance. The door weighs many tons."
?ELS23:	PRINTR	"It is closed!"


	.FUNCT	RIDDLE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"Use the ""Look"" command."


	.FUNCT	MAGIC-ACTOR,V
	ZERO?	SPELL? /FALSE
	EQUAL?	SPELL?,S-FALL \?ELS11
	EQUAL?	PRSA,V?CROSS,V?CLIMB-DOWN,V?CLIMB-UP /?THN17
	EQUAL?	PRSA,V?WALK \?ELS16
	GETPT	HERE,P?DOWN
	ZERO?	STACK /?ELS16
?THN17:	GETPT	HERE,P?GLOBAL >V
	PTSIZE	V
	CALL	ZMEMQB,BRIDGE,V,STACK
	ZERO?	STACK /?ELS25
	CALL	JIGS-UP,STR?252
	RSTACK	
?ELS25:	RANDOM	100
	GRTR?	25,STACK \?ELS27
	CALL	JIGS-UP,STR?253
	RSTACK	
?ELS27:	PRINTR	"You just tripped on an invisible cord, or perhaps your own feet. But this must be your lucky day, as you managed to regain your balance before what could have been a fatal fall."
?ELS16:	EQUAL?	PRSA,V?BOARD \FALSE
	PRINTI	"You get in the "
	PRINTD	PRSO
	PRINTR	" but you fall out again, almost as though an invisible hand had tipped it over."
?ELS11:	EQUAL?	SPELL?,S-FLOAT \?ELS37
	EQUAL?	PRSA,V?WAIT,V?DIAGNOSE /FALSE
	EQUAL?	PRSA,V?WALK \?ELS44
	PRINTR	"I suppose you plan to do that by flapping your arms?"
?ELS44:	EQUAL?	PRSA,V?DROP \?ELS48
	MOVE	PRSO,HERE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" drops to the ground."
?ELS48:	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	PRSO,HERE \FALSE
	PRINTR	"You can't reach that! It's on the ground."
?ELS37:	EQUAL?	SPELL?,S-FREEZE \?ELS58
	EQUAL?	PRSA,V?WAIT,V?DIAGNOSE /FALSE
	PRINTR	"You are frozen solid. You might as well wait it out, because you can't do anything else in this state."
?ELS58:	EQUAL?	SPELL?,S-FENCE \?ELS69
	EQUAL?	PRSA,V?WALK \?ELS69
	PRINTR	"An invisible fence of magical force bars your way."
?ELS69:	EQUAL?	SPELL?,S-FIERCE \?ELS75
	CALL	INFESTED?,HERE >V
	ZERO?	V /?ELS75
	EQUAL?	PRSA,V?MUNG,V?ATTACK /FALSE
	CALL	FORCE-FIGHT,V
	RTRUE	
?ELS75:	EQUAL?	SPELL?,S-FERMENT \?ELS86
	EQUAL?	PRSA,V?WALK \?ELS86
	IN?	WINNER,HERE \?ELS86
	PRINTI	"Oops, you seem a little unsteady... I'm not sure you got where you intended going."
	CRLF	
	CRLF	
	CALL	RANDOM-WALK
	RSTACK	
?ELS86:	EQUAL?	SPELL?,S-FEAR \FALSE
	CALL	INFESTED?,HERE >V
	ZERO?	V /FALSE
	PRINTI	"All at once, you are overcome by fear! There's is a "
	PRINTD	V
	PRINTI	" in here! Maybe it's after you! "
	LOC	WINNER
	FSET?	STACK,VEHBIT \?ELS101
	PRINTR	"You huddle in the corner, terrified."
?ELS101:	PRINTI	"You run from the room screaming in terror!"
	CRLF	
	CRLF	
	CALL	RANDOM-WALK
	RSTACK	


	.FUNCT	RANDOM-WALK,P,TX,L,S,D=0
	SET	'P,0
?PRG1:	NEXTP	HERE,P >P
	LESS?	P,LOW-DIRECTION \?ELS5
	ZERO?	D /TRUE
	SET	'S,SPELL?
	SET	'SPELL?,FALSE-VALUE
	SET	'WINNER,ADVENTURER
	MOVE	WINNER,HERE
	CALL	DO-WALK,D
	SET	'SPELL?,S
	RTRUE	
?ELS5:	GETPT	HERE,P >TX
	PTSIZE	TX >L
	EQUAL?	L,UEXIT /?THN15
	EQUAL?	L,CEXIT \?ELS18
	GETB	TX,CEXITFLAG
	VALUE	STACK
	ZERO?	STACK \?THN15
?ELS18:	EQUAL?	L,DEXIT \?PRG1
	GETB	TX,DEXITOBJ
	FSET?	STACK,OPENBIT \?PRG1
?THN15:	ZERO?	D \?ELS23
	SET	'D,P
	JUMP	?PRG1
?ELS23:	RANDOM	100
	GRTR?	50,STACK \?PRG1
	SET	'D,P
	JUMP	?PRG1


	.FUNCT	FORCE-FIGHT,V,W
	CALL	FIND-IN,ADVENTURER,WEAPONBIT >W
	ZERO?	W \?CND1
	SET	'W,HANDS
?CND1:	PRINTI	"You are maddened by an overwhelming ferocity, and attack the "
	PRINTD	V
	PRINTI	" instead."
	CRLF	
	CALL	PERFORM,V?ATTACK,V,W
	RSTACK	


	.FUNCT	DWINDOW-DESC
	PRINTI	"On the floor is a very small diamond shaped window which is "
	ZERO?	DIAMOND-SOLVE /?ELS5
	PRINTI	"glowing serenely"
	JUMP	?CND3
?ELS5:	GET	DWDESCS,DIAMOND-COUNT
	PRINT	STACK
?CND3:	PRINTR	"."


	.FUNCT	DWINDOW-FCN
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTR	"The window is an integral part of the floor."
?ELS5:	EQUAL?	PRSA,V?MUNG \?ELS9
	PRINTR	"The window is diamond-hard and cannot be broken."
?ELS9:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	CALL	DWINDOW-DESC
	RSTACK	


	.FUNCT	DIAMOND-MOTION,RARG,DC,DIR,RM
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a room with oddly angled walls and passages in all directions. The walls are made of some glassy substance."
	CRLF	
	EQUAL?	HERE,DIAMOND-5 \?ELS10
	PRINTI	"A marble stairway leads upward."
	ZERO?	DIAMOND-SOLVE /?CND13
	PRINTI	" The floor has swung down at the end of the stairway to reveal a secret passage leading down into unrelieved darkness."
?CND13:	CRLF	
	RTRUE	
?ELS10:	CALL	DWINDOW-DESC
	RTRUE	
?ELS5:	EQUAL?	RARG,M-FLASH \?ELS22
	CALL	DWINDOW-DESC
	RTRUE	
?ELS22:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	ZERO?	DIAMOND-SOLVE \FALSE
	EQUAL?	HERE,DIAMOND-2,DIAMOND-4 /?THN32
	EQUAL?	HERE,DIAMOND-6,DIAMOND-8 \?ELS31
?THN32:	SUB	DIAMOND-COUNT,1
	GET	DIDIRS,STACK >DIR
	EQUAL?	PRSO,DIR \?ELS36
	INC	'DIAMOND-COUNT
	GRTR?	DIAMOND-COUNT,DIAMOND-BASE \?CND37
	SET	'DIAMOND-BASE,DIAMOND-COUNT
	SET	'DIAMOND-MOVES,0
?CND37:	EQUAL?	DIAMOND-COUNT,5 \?CND40
	PRINTI	"You hear a strange rusty squeal echoing in the distance."
	CRLF	
	FCLEAR	DIAMOND-5,TOUCHBIT
	CALL	SCORE-UPD,5
	SET	'DIAMOND-SOLVE,TRUE-VALUE
?CND40:	EQUAL?	HERE,DIAMOND-2 \?ELS47
	SET	'DIR,DIAMOND-4
	JUMP	?CND45
?ELS47:	EQUAL?	HERE,DIAMOND-4 \?ELS49
	SET	'DIR,DIAMOND-8
	JUMP	?CND45
?ELS49:	EQUAL?	HERE,DIAMOND-8 \?ELS51
	SET	'DIR,DIAMOND-6
	JUMP	?CND45
?ELS51:	EQUAL?	HERE,DIAMOND-6 \?CND45
	SET	'DIR,DIAMOND-2
?CND45:	CALL	GOTO,DIR
	RTRUE	
?ELS36:	CALL	DIAMOND-LOSS
	RTRUE	
?ELS31:	EQUAL?	HERE,DIAMOND-5 \?ELS57
	EQUAL?	PRSO,P?UP /FALSE
?ELS57:	SET	'DIAMOND-COUNT,0
	RANDOM	100
	GRTR?	33,STACK \?ELS66
	PRINTR	"There is no way to go in that direction."
?ELS66:	RANDOM	100
	GRTR?	25,STACK \?ELS70
	CALL	DIAMOND-LOSS
	RTRUE	
?ELS70:	SET	'DIAMOND-COUNT,1
	GRTR?	DIAMOND-COUNT,DIAMOND-BASE \?CND73
	SET	'DIAMOND-BASE,DIAMOND-COUNT
	SET	'DIAMOND-MOVES,0
?CND73:	RANDOM	4
	SUB	STACK,1
	GET	DIAMOND-ROOMS,STACK >RM
	FSET?	BAT,INVISIBLE \?CND76
	FCLEAR	BAT,INVISIBLE
	MOVE	BAT,RM
?CND76:	CALL	GOTO,RM
	RTRUE	


	.FUNCT	DIAMOND-LOSS
	INC	'DIAMOND-MOVES
	EQUAL?	DIAMOND-MOVES,20 \?CND1
	PRINTI	"As you thrash about in the maze, the mirthful voice of the Wizard taunts you: ""Fool! You'll never get past "
	GET	BASES,DIAMOND-BASE
	PRINT	STACK
	PRINTI	" base at this rate!"""
	CRLF	
?CND1:	RANDOM	5
	ADD	3,STACK
	GET	DIAMOND-ROOMS,STACK
	CALL	GOTO,STACK
	RSTACK	


	.FUNCT	CERBERUS-FCN
	EQUAL?	PRSA,V?RAISE,V?RUB,V?WAVE \?ELS5
	EQUAL?	PRSO,WAND \?ELS5
	PRINTI	"The dog looks puzzled."
	CRLF	
	RFALSE	
?ELS5:	ZERO?	WAND-ON /?ELS11
	EQUAL?	PRSA,V?INCANT,V?SAY /FALSE
?ELS11:	CALL	HELLO?,CERBERUS
	ZERO?	STACK /?ELS15
	ZERO?	CERBERUS-LEASHED /?ELS20
	PRINTR	"""Arf! Arf! Arf!"""
?ELS20:	PRINTR	"""Grrrr!"""
?ELS15:	EQUAL?	PRSA,V?STAB,V?MUNG,V?ATTACK \?ELS29
	ZERO?	CERBERUS-LEASHED /?ELS34
	REMOVE	CERBERUS
	PRINTR	"With a quiet bark of disappointment, the creature expires. Its six eyes look at you reproachfully. As it dies, it collapses into a small pile of dust which blows away into nothing."
?ELS34:	RANDOM	100
	GRTR?	50,STACK \?ELS39
	CALL	JIGS-UP,STR?263
	RSTACK	
?ELS39:	PRINTR	"The maddened dog-thing snaps viciously at you."
?ELS29:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?ELS45
	EQUAL?	PRSO,COLLAR \?ELS45
	MOVE	COLLAR,CERBERUS
	FSET	COLLAR,NDESCBIT
	FSET	COLLAR,TRYTAKEBIT
	PUTP	CERBERUS,P?LDESC,STR?264
	SET	'CERBERUS-LEASHED,TRUE-VALUE
	PRINTR	"The creature whines happily, then the center head licks your face (which is roughly like experiencing a sandpaper washcloth). The other two heads look about, as though the monster felt a sudden need to find a pair of slippers somewhere. Its huge tail wags enthusiastically, knocking small rocks around and almost blowing you over from the breeze it creates."
?ELS45:	EQUAL?	PRSA,V?ENCHANT \?ELS51
	EQUAL?	SPELL-USED,W?FLOAT \?ELS56
	SET	'SPELL-HANDLED?,TRUE-VALUE
	PRINTR	"The huge dog rises about an inch off the ground, for a moment."
?ELS56:	EQUAL?	SPELL-USED,W?FIERCE \?ELS60
	SET	'SPELL-HANDLED?,TRUE-VALUE
	CALL	JIGS-UP,STR?265
	RSTACK	
?ELS60:	EQUAL?	SPELL-USED,W?FEEBLE \FALSE
	PRINTR	"What an effect! He now has the strength of just one elephant, rather than ten!"
?ELS51:	ZERO?	CERBERUS-LEASHED \?ELS66
	PRINTR	"The three-headed dog snaps at you viciously!"
?ELS66:	ZERO?	CERBERUS-LEASHED /FALSE
	EQUAL?	PRSA,V?RUB \FALSE
	PRINTR	"The dog is now insanely happy, slobbering all over the place and whining with uncontained doggish joy."


	.FUNCT	COLLAR-FCN
	EQUAL?	PRSA,V?TAKE \?ELS5
	ZERO?	CERBERUS-LEASHED /?ELS5
	CALL	JIGS-UP,STR?266
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?ENCHANT \FALSE
	EQUAL?	SPELL-USED,W?FLOAT \FALSE
	CALL	PERFORM,V?ENCHANT,CERBERUS
	RTRUE	


	.FUNCT	GLACIER-FCN
	EQUAL?	PRSA,V?MELT \FALSE
	PRINTR	"This is a big glacier; you'll need a lot of heat."


	.FUNCT	GLACIER-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large hall of ancient lava, since worn smooth by the movement of a glacier. A large passage exits to the east and an upward lava tube is at the top of a jumble of fallen rocks."
	CRLF	
	ZERO?	ICE-MELTED /TRUE
	PRINTR	"A damp and scorched passage leads west. It is still partly full of steam."


	.FUNCT	DRAGON-FCN
	CALL	QUEUE,I-DRAGON,-1
	PUT	STACK,0,1
	CALL	HELLO?,DRAGON
	ZERO?	STACK /?ELS5
	PRINTI	"The dragon looks amused. He speaks in a voice so deep you feel it rather than hear it, but the tongue is unknown to you. You find yourself almost hypnotized."
	CRLF	
	ADD	DRAGON-ANGER,2 >DRAGON-ANGER
	RETURN	DRAGON-ANGER
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTI	"He turns and looks back at you, his cat's eyes yellow in the gloom. You start to feel weak, and quickly turn away."
	CRLF	
	INC	'DRAGON-ANGER
	RETURN	DRAGON-ANGER
?ELS9:	EQUAL?	PRSA,V?KICK,V?MUNG,V?ATTACK /?THN14
	EQUAL?	PRSA,V?LAMP-ON \?ELS13
?THN14:	EQUAL?	PRSA,V?LAMP-ON /?THN19
	EQUAL?	PRSA,V?ATTACK \?ELS18
	ZERO?	PRSI \?ELS18
?THN19:	PRINTI	"With your bare hands? I doubt the dragon even noticed."
	CRLF	
	JUMP	?CND16
?ELS18:	CALL	RANDOM-ELEMENT,DRAGON-ATTACKS
	PRINT	STACK
	CRLF	
?CND16:	ADD	DRAGON-ANGER,4 >DRAGON-ANGER
	RETURN	DRAGON-ANGER
?ELS13:	EQUAL?	PRSA,V?GIVE \?ELS30
	EQUAL?	PRSI,DRAGON \?ELS30
	INC	'DRAGON-ANGER
	GETPT	PRSO,P?VALUE
	ZERO?	STACK /?ELS37
	MOVE	PRSO,CHEST
	PRINTR	"The dragon is pleased by your gift, excuses himself for a moment, and returns without it."
?ELS37:	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS41
	ADD	DRAGON-ANGER,2 >DRAGON-ANGER
	REMOVE	BRICK
	PRINTR	"The dragon snakes his long red tongue around the bomb and politely swallows it. A few moments later he belches and smoke curls out of his nostrils."
?ELS41:	PRINTR	"The dragon refuses your gift."
?ELS30:	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	HERE,DRAGON-ROOM \FALSE
	EQUAL?	PRSO,P?NORTH \FALSE
	ADD	DRAGON-ANGER,3 >DRAGON-ANGER
	PRINTR	"The dragon puts out a claw, grins (all of his sword-sharp teeth glinting in the light), and blocks your way."


	.FUNCT	HELLO?,WHO
	EQUAL?	WINNER,WHO /?THN6
	EQUAL?	PRSA,V?REPLY,V?ANSWER,V?TELL /?THN6
	EQUAL?	PRSA,V?INCANT,V?HELLO,V?SAY \FALSE
?THN6:	EQUAL?	PRSA,V?SAY,V?ANSWER,V?TELL /?THN11
	EQUAL?	PRSA,V?REPLY,V?INCANT \TRUE
?THN11:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	


	.FUNCT	FIND-TARGET,TARGET,P,TX,L,ROOM
	IN?	TARGET,HERE \?ELS5
	RETURN	HERE
?ELS5:	SET	'P,0
?PRG8:	NEXTP	HERE,P >P
	ZERO?	P /FALSE
	LESS?	P,LOW-DIRECTION /?PRG8
	GETPT	HERE,P >TX
	PTSIZE	TX >L
	EQUAL?	L,UEXIT,CEXIT,DEXIT \?PRG8
	GETB	TX,0 >ROOM
	IN?	TARGET,ROOM \?PRG8
	RETURN	ROOM


	.FUNCT	I-DRAGON,ROOM
	GRTR?	DRAGON-ANGER,6 \?ELS3
	PRINTI	"The dragon tires of this game. With an almost bored yawn, he opens his mouth and "
	EQUAL?	SPELL?,S-FIREPROOF \?ELS8
	PRINTI	"blasts you with a great gout of fire, but it washes over you harmlessly."
	CRLF	
	JUMP	?CND1
?ELS8:	CALL	DRAGON-LEAVES
	CALL	JIGS-UP,STR?272
	JUMP	?CND1
?ELS3:	IN?	WINNER,DRAGON-ROOM \?ELS14
	IN?	DRAGON,DRAGON-ROOM /?ELS14
	MOVE	DRAGON,DRAGON-ROOM
	PRINTI	"The dragon doubles back and charges into the room, maddened by your attempt to sneak past him. His eyes glow with a white heat of anger."
	CRLF	
	EQUAL?	SPELL?,S-FIREPROOF \?ELS21
	CALL	JIGS-UP,STR?273
	JUMP	?CND1
?ELS21:	CALL	JIGS-UP,STR?274
	JUMP	?CND1
?ELS14:	GRTR?	DRAGON-ANGER,0 /?ELS25
	RANDOM	100
	GRTR?	50,STACK \?ELS28
	IN?	DRAGON,HERE \?ELS28
	PRINTI	"The dragon looks bored."
	CRLF	
	JUMP	?CND1
?ELS28:	CALL	DRAGON-LEAVES
	EQUAL?	HERE,GLACIER-ROOM \?ELS37
	PRINTI	"The dragon is no longer around. He must have become bored with you."
	CRLF	
	JUMP	?CND1
?ELS37:	EQUAL?	HERE,OLD-HERE \?CND1
	PRINTI	"The dragon seems to have lost interest in you."
	EQUAL?	OLD-HERE,DRAGON-ROOM \?ELS46
	CRLF	
	JUMP	?CND1
?ELS46:	PRINTI	" He wanders off."
	CRLF	
	JUMP	?CND1
?ELS25:	CALL	FIND-TARGET,WINNER >ROOM
	ZERO?	ROOM \?ELS55
	RANDOM	100
	GRTR?	25,STACK \?CND53
	CALL	DRAGON-LEAVES
	JUMP	?CND53
?ELS55:	EQUAL?	ROOM,CAROUSEL-ROOM,TINY-ROOM /?THN61
	EQUAL?	ROOM,RAVINE-LEDGE,FRESCO-ROOM \?ELS60
?THN61:	RANDOM	100
	GRTR?	25,STACK \?CND63
	CALL	DRAGON-LEAVES
?CND63:	PRINTI	"The dragon will follow no further."
	CRLF	
	JUMP	?CND1
?ELS60:	EQUAL?	ROOM,GLACIER-ROOM \?ELS69
	CRLF	
	PRINTI	"As the dragon enters, he sees his reflection on the icy surface of the glacier at its western end. He becomes enraged: There is another dragon here, behind that glass, he thinks! Dragons are smart, but sometimes naive, and this one has never seen ice before. He rears up to his full height to challenge this intruder into his territory. He roars a challenge! The intruder responds! The dragon takes a deep breath, and out of his mouth pours a massive gout of flame. It washes over the ice, which melts rapidly, sending out torrents of water and a huge cloud of steam! You manage to clamber up to a small shelf, but the dragon is terrified! A huge splash goes down his throat! There is a muffled explosion and the dragon, a puzzled expression on his face, dies. He is carried away by the water.

When the flood recedes you climb gingerly down. While no trace of the dragon can be found, the melting of the ice has revealed a passage leading west."
	CRLF	
	REMOVE	DRAGON
	REMOVE	ICE
	MOVE	DEAD-DRAGON,DEEP-FORD
	CALL	INT,I-DRAGON
	PUT	STACK,0,0
	CALL	SCORE-UPD,5
	SET	'ICE-MELTED,TRUE-VALUE
	JUMP	?CND1
?ELS69:	EQUAL?	ROOM,OLD-HERE /?ELS76
	MOVE	DRAGON,ROOM
	PRINTI	"The dragon follows you, out of mingled curiosity and anger."
	CRLF	
	JUMP	?CND74
?ELS76:	PRINTI	"The dragon continues to watch you carefully."
	CRLF	
?CND74:	GRTR?	DRAGON-ANGER,0 /?CND53
	SET	'DRAGON-ANGER,0
	CALL	INT,I-DRAGON
	PUT	STACK,0,0
?CND53:	
?CND1:	LOC	DRAGON >OLD-HERE
	SUB	DRAGON-ANGER,2 >DRAGON-ANGER
	LESS?	DRAGON-ANGER,0 \TRUE
	SET	'DRAGON-ANGER,0
	RTRUE	


	.FUNCT	DRAGON-LEAVES
	LOC	DEAD-DRAGON
	ZERO?	STACK \FALSE
	MOVE	DRAGON,DRAGON-ROOM
	SET	'DRAGON-ANGER,0
	CALL	INT,I-DRAGON
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	I-GARDEN
	EQUAL?	HERE,GARDEN-NORTH,GAZEBO-ROOM /?THN6
	EQUAL?	HERE,TOPIARY-ROOM,FORMAL-GARDEN \?ELS5
?THN6:	IN?	UNICORN,GARDEN-NORTH \?ELS12
	RANDOM	100
	GRTR?	33,STACK \?ELS12
	REMOVE	UNICORN
	EQUAL?	HERE,TOPIARY-ROOM /FALSE
	PRINTR	"The unicorn bounds lightly away."
?ELS12:	IN?	PRINCESS,DRAGON-LAIR \?ELS23
	IN?	UNICORN,GARDEN-NORTH /?ELS23
	RANDOM	100
	GRTR?	25,STACK \?ELS23
	EQUAL?	HERE,TOPIARY-ROOM /?ELS23
	ZERO?	UNICORN-FRIGHTENED /?CND26
	SET	'UNICORN-FRIGHTENED,FALSE-VALUE
	RFALSE	
?CND26:	MOVE	UNICORN,GARDEN-NORTH
	EQUAL?	HERE,GARDEN-NORTH \?ELS34
	CALL	RANDOM-ELEMENT,UNICORN-MSGS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS34:	PRINTR	"A unicorn is peacefully cropping grass at the north end of the garden. There is something hanging around its neck."
?ELS23:	EQUAL?	HERE,TOPIARY-ROOM \FALSE
	ZERO?	TOPIARY-MOVED \?ELS47
	RANDOM	100
	GRTR?	12,STACK \?ELS47
	SET	'TOPIARY-MOVED,TRUE-VALUE
	PRINTR	"You look around, and strangely, the topiary animals seem to have changed position slightly."
?ELS47:	ZERO?	TOPIARY-MOVED /?ELS53
	ZERO?	TOPIARY-NEAR \?ELS53
	RANDOM	100
	GRTR?	8,STACK \?ELS53
	SET	'TOPIARY-NEAR,TRUE-VALUE
	PRINTR	"The topiary animals seem to close in on you. You turn and they are very close. They seem to be leering at you."
?ELS53:	ZERO?	TOPIARY-NEAR /FALSE
	RANDOM	100
	GRTR?	4,STACK \FALSE
	SET	'TOPIARY-MOVED,FALSE-VALUE
	SET	'TOPIARY-NEAR,FALSE-VALUE
	CALL	JIGS-UP,STR?275
	RSTACK	
?ELS5:	REMOVE	UNICORN
	CALL	INT,I-GARDEN
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	GARDEN-ROOM-FCN,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-GARDEN,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	GLOBAL-UNICORN-FCN
	IN?	UNICORN,GARDEN-NORTH \?ELS5
	PRINTR	"The unicorn is way up at the north end of the garden."
?ELS5:	EQUAL?	PRSA,V?FOLLOW,V?FIND \?ELS9
	FSET?	UNICORN,TOUCHBIT \?ELS14
	PRINTR	"I don't know where it is now."
?ELS14:	PRINTR	"The unicorn is a mythical beast."
?ELS9:	PRINTR	"Unicorn? What unicorn?"


	.FUNCT	UNICORN-FCN
	CALL	HELLO?,UNICORN
	ZERO?	STACK /?ELS5
	PRINTR	"The unicorn listens distractedly, then goes back to cropping grass."
?ELS5:	EQUAL?	PRSA,V?FOLLOW \?ELS9
	PRINTR	"The unicorn shies away as you approach."
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	EQUAL?	PRSO,UNICORN \?ELS13
	PRINTR	"The unicorn shies away as you approach for a closer look, but you do notice a tiny gold key hanging from a red satin ribbon looped around the animal's neck."
?ELS13:	EQUAL?	PRSA,V?EXAMINE \?ELS19
	PRINTR	"The unicorn shies away as you approach."
?ELS19:	EQUAL?	PRSA,V?RUB,V?PUT,V?TAKE /?THN24
	EQUAL?	PRSA,V?ATTACK,V?MUNG \FALSE
?THN24:	REMOVE	UNICORN
	SET	'UNICORN-FRIGHTENED,TRUE-VALUE
	PRINTR	"The unicorn, unsurprised by this evidence that you are indeed the uncouth sort of vagabond it suspected you were, melts into the hedges and is gone."


	.FUNCT	GAZEBO-FCN
	EQUAL?	HERE,GARDEN-NORTH \?ELS5
	EQUAL?	PRSA,V?THROUGH \?ELS5
	CALL	DO-WALK,P?IN
	RTRUE	
?ELS5:	EQUAL?	HERE,GAZEBO-ROOM \?ELS9
	EQUAL?	PRSA,V?THROUGH \?ELS9
	PRINTR	"You're already in it."
?ELS9:	EQUAL?	HERE,GAZEBO-ROOM \FALSE
	EQUAL?	PRSA,V?EXIT,V?LEAVE \FALSE
	CALL	DO-WALK,P?OUT
	RTRUE	


	.FUNCT	CHEST-FCN
	EQUAL?	PRSA,V?OPEN \FALSE
	RANDOM	100
	GRTR?	25,STACK \?ELS8
	CALL	V-OPEN
	IN?	PRINCESS,HERE \?CND6
	ZERO?	PRINCESS-AWAKE \?CND6
	PRINTI	"The opening of the squeaky lid startles the young woman."
	CRLF	
	JUMP	?CND6
?ELS8:	PRINTI	"The hinges are very rusty, but they seem to be starting to give. You can probably open it if you try again. There is something bumping around inside."
	IN?	PRINCESS,HERE \?CND20
	ZERO?	PRINCESS-AWAKE \?CND20
	PRINTI	" All this rummaging around has startled the young woman."
?CND20:	CRLF	
?CND6:	PUTP	CHEST,P?ACTION,0
	IN?	PRINCESS,HERE \TRUE
	ZERO?	PRINCESS-AWAKE \TRUE
	CALL	PERFORM,V?ALARM,PRINCESS
	RTRUE	


	.FUNCT	PRINCESS-FCN,DEM
	CALL	INT,I-PRINCESS >DEM
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	IN?	PRINCESS,HERE \?ELS8
	PRINTR	"You can't follow her until she leaves..."
?ELS8:	ZERO?	PRFOLLOW /?ELS12
	CALL	DO-WALK,PRFOLLOW
	RTRUE	
?ELS12:	PRINTR	"I seem to have lost track of her."
?ELS5:	IN?	PRINCESS,HERE /?ELS19
	PRINTR	"There is no princess here."
?ELS19:	EQUAL?	PRSA,V?RAPE,V?MUNG,V?ATTACK \?ELS23
	REMOVE	PRINCESS
	PRINTI	"The princess screams as you approach. ""Won't someone deliver me from this awful fate?"" she cries. "
	IN?	WIZARD,HERE \?ELS28
	PRINTI	"Shocked, the Wizard of Frobozz turns toward you."
	JUMP	?CND26
?ELS28:	PRINTI	"Just in time, the Wizard of Frobozz appears, seeming to unroll himself out of nothing like a window shade."
?CND26:	PRINTI	" ""Fry!"" he intones, and a massive bolt of lightning reduces you to a pile of smoking ashes. (Serves you right, too, if you ask me.)"
	CALL	JIGS-UP
	RSTACK	
?ELS23:	CALL	HELLO?,PRINCESS
	ZERO?	STACK \?THN39
	EQUAL?	PRSA,V?EXAMINE,V?KISS,V?ALARM /?THN39
	EQUAL?	PRSA,V?RUB \?ELS38
?THN39:	IN?	PRINCESS,DRAGON-LAIR \?ELS45
	GET	DEM,C-ENABLED?
	ZERO?	STACK \?ELS45
	PUTP	PRINCESS,P?LDESC,STR?280
	CALL	QUEUE,I-PRINCESS,2
	PUT	STACK,0,1
	SET	'PRINCESS-AWAKE,TRUE-VALUE
	PRINTR	"The princess (for she is obviously one) shakes herself awake, then notices you for the first time. She smiles. ""Thank you for rescuing me from that horrid worm,"" she says. ""I must depart. My parents will be worried about me."" With that, she arises, looking purposefully out of the lair."
?ELS45:	PRINTI	"The princess ignores you. She looks about the room, but her eyes fix on the "
	EQUAL?	HERE,GAZEBO-ROOM \?ELS56
	PRINTI	"garden outside"
	JUMP	?CND54
?ELS56:	EQUAL?	HERE,GARDEN-NORTH \?ELS60
	PRINTI	"gazebo"
	JUMP	?CND54
?ELS60:	EQUAL?	HERE,RAVINE-LEDGE \?ELS64
	PRINTI	"ledge"
	JUMP	?CND54
?ELS64:	MUL	PRCOUNT,4
	GET	PRDIRS,STACK
	PRINT	STACK
?CND54:	PRINTR	"."
?ELS38:	ZERO?	PRINCESS-AWAKE \FALSE
	PRINTR	"She's in a trance!"


	.FUNCT	I-PRINCESS,DEM,OLDP,PC
	CALL	INT,I-PRINCESS >DEM
	LOC	PRINCESS >OLDP
	MUL	PRCOUNT,4 >PC
	ADD	PC,1
	GET	PRDIRS,STACK
	MOVE	PRINCESS,STACK
	SET	'PRFOLLOW,FALSE-VALUE
	IN?	PRINCESS,STREAM-PATH \?ELS3
	IN?	WINNER,MARBLE-HALL \?ELS3
	PRINTI	"The princess presses a loose piece of marble in the wall and a large section of the wall slides away, revealing a passage to the east. She enters it."
	CRLF	
	IN?	WINNER,OLDP \?CND8
	ADD	PC,3
	GET	PRDIRS,STACK >PRFOLLOW
?CND8:	SET	'SECRET-DOOR,TRUE-VALUE
	JUMP	?CND1
?ELS3:	IN?	PRINCESS,STREAM-PATH \?ELS12
	IN?	WINNER,STREAM-PATH \?ELS12
	SET	'SECRET-DOOR,TRUE-VALUE
	PRINTI	"The princess appears from behind some rocks, as though she had walked through a wall."
	CRLF	
	JUMP	?CND1
?ELS12:	IN?	WINNER,OLDP \?ELS18
	ADD	PC,3
	GET	PRDIRS,STACK >PRFOLLOW
	EQUAL?	OLDP,GARDEN-NORTH \?ELS21
	PRINTI	"The princess enters the gazebo"
	FSET?	GAZEBO-ROOM,RMUNGBIT \?CND24
	PRINTI	", although you would never get past the debris. She must be magically protected."
?CND24:	PRINTI	"."
	CRLF	
	JUMP	?CND1
?ELS21:	EQUAL?	OLDP,RAVINE-LEDGE \?ELS32
	PRINTI	"The princess climbs daintily down the rock face."
	CRLF	
	JUMP	?CND1
?ELS32:	PRINTI	"The princess walks "
	GET	PRDIRS,PC
	PRINT	STACK
	PRINTI	". She glances back at you as she goes."
	CRLF	
	JUMP	?CND1
?ELS18:	IN?	PRINCESS,HERE \?CND1
	EQUAL?	HERE,GAZEBO-ROOM \?ELS47
	PRINTI	"The princess joins you in the gazebo."
	CRLF	
	JUMP	?CND1
?ELS47:	EQUAL?	HERE,DEEP-FORD \?ELS51
	PRINTI	"The princess climbs down the rock wall onto the beach."
	CRLF	
	JUMP	?CND1
?ELS51:	PRINTI	"The princess enters from the "
	ADD	2,PC
	GET	PRDIRS,STACK
	PRINT	STACK
	PRINTI	". She seems surprised to see you."
	CRLF	
?CND1:	IN?	PRINCESS,GAZEBO-ROOM \?ELS64
	PUT	DEM,0,0
	CALL	QUEUE,I-UNICORN,6
	PUT	STACK,0,1
	RTRUE	
?ELS64:	INC	'PRCOUNT
	RANDOM	100
	GRTR?	75,STACK \?ELS71
	PUSH	1
	JUMP	?CND67
?ELS71:	PUSH	2
?CND67:	CALL	QUEUE,I-PRINCESS,STACK
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-UNICORN
	EQUAL?	HERE,GAZEBO-ROOM,GARDEN-NORTH \?ELS5
	MOVE	ROSE,WINNER
	FCLEAR	GOLD-KEY,NDESCBIT
	MOVE	GOLD-KEY,WINNER
	CALL	SCORE-OBJ,GOLD-KEY
	PUTP	GOLD-KEY,P?ACTION,0
	PRINTI	"Shyly, a unicorn peeks out of the hedges. It notices the princess and seems captivated. It approaches her and bows its head as though curtseying to her. Around its neck is a red satin ribbon on which is strung a delicate gold key. The princess takes the ribbon and uses it to tie up her hair. She looks at you and then, smiling, hands you the key and a fresh rose which she plucks from the arbor. ""You may have use of such a thing,"" she says. ""It is the least I can do for one who rescued me from a fate I dare not contemplate."" With that, she mounts the unicorn (side-saddle, of course) and rides off into the gloom."
	CRLF	
	REMOVE	PRINCESS
	RTRUE	
?ELS5:	REMOVE	PRINCESS
	MOVE	ROSE,GAZEBO-ROOM
	RFALSE	


	.FUNCT	MENHIR-ROOM-FCN,RARG
	EQUAL?	RARG,M-FLASH \?ELS5
	ZERO?	MENHIR-POSITION /?ELS5
	CALL	DESCRIBE-MENHIR
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large room which was evidently used once as a quarry. Many large limestone chunks lie helter-skelter around the room. Some are rough-hewn and unworked, others smooth and well-finished. One side of the room appears to have been used to quarry building blocks, the other to produce menhirs (standing stones). Obvious passages lead north and south."
	CRLF	
	IN?	MENHIR,LOCAL-GLOBALS \TRUE
	CALL	DESCRIBE-MENHIR
	RTRUE	


	.FUNCT	DESCRIBE-MENHIR
	EQUAL?	HERE,MENHIR-ROOM \?ELS5
	EQUAL?	MENHIR-POSITION,FALSE-VALUE \?ELS8
	PRINTI	"One particularly large menhir, at least twenty feet tall and eight feet thick, is leaning against the wall blocking a dark opening leading southwest. On this side of the menhir is carved an ornate letter ""F""."
	CRLF	
	JUMP	?CND6
?ELS8:	EQUAL?	MENHIR-POSITION,1 \?ELS12
	PRINTI	"There is a huge menhir lying on the floor near a southwest passage."
	CRLF	
	JUMP	?CND6
?ELS12:	EQUAL?	MENHIR-POSITION,2 \?ELS16
	PRINTI	"A dark opening leads southwest."
	CRLF	
	JUMP	?CND6
?ELS16:	EQUAL?	MENHIR-POSITION,3 \?ELS20
	PRINTI	"There is a huge menhir here."
	CRLF	
	JUMP	?CND6
?ELS20:	PRINTI	"There is a huge menhir floating like a feather in midair here. A passage to the southwest opens beneath it."
	CRLF	
?CND6:	EQUAL?	HERE,MUNGED-ROOM \TRUE
	PRINTR	"The explosion appears to have had no effect on the menhir."
?ELS5:	PRINTR	"A dark opening leads southwest."


	.FUNCT	MENHIR-FCN
	EQUAL?	PRSA,V?LOOK-BEHIND,V?LOOK-UNDER \?ELS5
	ZERO?	MENHIR-POSITION /?ELS10
	PRINTR	"Behind the menhir is some air and then a wall."
?ELS10:	PRINTR	"The gap between the menhir and the wall is very narrow, but it is clear that there is a sizeable room in there. Your light only reveals a part of the far wall."
?ELS5:	EQUAL?	PRSA,V?TURN,V?MOVE,V?TAKE \?ELS19
	PRINTR	"The menhir weighs many tons and is eight feet wide. You can't even get a grip on it, much less move it."
?ELS19:	EQUAL?	PRSA,V?READ \?ELS23
	PRINTR	"""F"""
?ELS23:	EQUAL?	PRSA,V?EXAMINE \?ELS27
	PRINTR	"It is nicely finished, and the letter ""F"" on it is particularly well carved."
?ELS27:	EQUAL?	PRSA,V?ENCHANT \?ELS31
	EQUAL?	SPELL-USED,W?FLOAT \?ELS31
	PRINTI	"The menhir floats majestically into the air, rising about ten feet. The passage beneath it beckons invitingly."
	CRLF	
	SET	'MENHIR-POSITION,3
	RETURN	MENHIR-POSITION
?ELS31:	EQUAL?	PRSA,V?DISENCHANT \FALSE
	EQUAL?	SPELL-USED,W?FLOAT \FALSE
	SET	'MENHIR-POSITION,FALSE-VALUE
	EQUAL?	HERE,MENHIR-ROOM,KENNEL \FALSE
	PRINTR	"The menhir sinks to the ground."


	.FUNCT	DOOR-KEEPER-FCN
	EQUAL?	PRSA,V?ALARM \?ELS5
	ZERO?	GUARDIAN-FED /?ELS5
	PRINTR	"Try as you may, you can't wake it."
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS11
	EQUAL?	PRSI,DOOR-KEEPER \?ELS11
	ZERO?	GUARDIAN-FED /?ELS18
	PRINTR	"He is asleep, at least for the moment."
?ELS18:	EQUAL?	PRSO,CANDY \?ELS23
	SET	'GUARDIAN-FED,TRUE-VALUE
	REMOVE	CANDY
	PRINTR	"The guardian greedily wolfs down the candy, including the package. (It seemed to enjoy the grasshoppers particularly.) It then becomes quiet and its eyes close. (Lizards are known to sleep a long time while digesting their meals.)"
?ELS23:	EQUAL?	PRSO,FLASK \?ELS27
	PRINTR	"The lizard sniffs it experimentally, then looks at you angrily, hissing and snapping."
?ELS27:	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS31
	REMOVE	PRSO
	PRINTR	"The guardian greedily wolfs it down. After a while, you hear a very small pop and the guardian's eyes bulge out. It hisses nastily at you."
?ELS31:	EQUAL?	PRSO,PALANTIR-1,PALANTIR-2,PALANTIR-3 \?ELS35
	PRINTI	"The guardian greedily gobbles the sphere, but finds it unchewable. He then tries repeatedly to swallow it whole, with disappointing results. Finally, he spits it on the ground."
	CRLF	
	MOVE	PRSO,HERE
	RTRUE	
?ELS35:	REMOVE	PRSO
	PRINTI	"The lizard wolfs down the "
	PRINTD	PRSO
	PRINTR	", crunching greedily."
?ELS11:	EQUAL?	PRSA,V?MUNG,V?ATTACK \FALSE
	PRINTR	"The guardian seems impervious to your attack. In fact, your blows don't even seem to be landing."


	.FUNCT	WIZ-DOOR-FCN
	ZERO?	GUARDIAN-FED \?ELS5
	EQUAL?	PRSA,V?OPEN \?ELS10
	PRINTR	"The lizard comes to life and snaps at you as you reach for the handle."
?ELS10:	EQUAL?	PRSA,V?UNLOCK \FALSE
	PRINTI	"The lizard door keeper comes awake and bites at your hand. You jerk away just in time."
	EQUAL?	PRSI,GOLD-KEY \?ELS21
	RANDOM	100
	GRTR?	5,STACK \?ELS21
	REMOVE	GOLD-KEY
	PRINTR	" The guardian does get the key, though. It grins maniacally."
?ELS21:	RANDOM	100
	GRTR?	20,STACK \?ELS27
	MOVE	GOLD-KEY,HERE
	PRINTR	" You drop the key, though."
?ELS27:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?UNLOCK \?ELS33
	ZERO?	WIZ-DOOR-FLAG /?ELS38
	PRINTR	"It is already!"
?ELS38:	EQUAL?	PRSI,GOLD-KEY \?ELS43
	SET	'WIZ-DOOR-FLAG,TRUE-VALUE
	PRINTR	"The key turns and the bolt clicks. The door is unlocked."
?ELS43:	SET	'WIZ-DOOR-FLAG,FALSE-VALUE
	PRINTR	"That won't unlock it."
?ELS33:	EQUAL?	PRSA,V?LOCK \?ELS51
	ZERO?	WIZ-DOOR-FLAG \?ELS56
	PRINTR	"It is locked already."
?ELS56:	EQUAL?	PRSI,GOLD-KEY \?ELS60
	PRINTI	"The door is now locked."
	CRLF	
	SET	'WIZ-DOOR-FLAG,FALSE-VALUE
	RTRUE	
?ELS60:	PRINTR	"That won't lock it."
?ELS51:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	ZERO?	WIZ-DOOR-FLAG /?ELS73
	CALL	OPEN-CLOSE,PRSO,STR?287,STR?288
	RSTACK	
?ELS73:	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"The door is locked!"


	.FUNCT	GUARDIAN-ROOM-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This room is cobwebby and musty, but tracks in the dust show that it has seen visitors recently. At the south end of the room is a stained and battered (but very strong-looking) door. To the north, a corridor exits."
	CRLF	
	FSET?	WIZ-DOOR,OPENBIT \?CND8
	PRINTI	"The door is open."
	CRLF	
?CND8:	ZERO?	GUARDIAN-FED \?ELS17
	PRINTI	"Imbedded in the door is a nasty-looking lizard head, with sharp teeth and beady eyes. "
	IN?	CANDY,WINNER \?ELS24
	PRINTR	"The lizard is sniffing at you."
?ELS24:	PRINTR	"The eyes move to watch you approach."
?ELS17:	PRINTR	"A sleepy-looking lizard head is mounted on the door."


	.FUNCT	WORKSHOP-FCN,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are standing in the entry hall of the Wizard's Workshop. Dark corridors lead west and south from here. The corridor to the west smells slightly of incense or candle smoke."
	FSET?	WIZ-DOOR,OPENBIT \?CND8
	PRINTI	" The workshop door is open."
?CND8:	CRLF	
	RTRUE	


	.FUNCT	ARCANA-PSEUDO
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"The stuff on the bench appears to be so much junk, and you decide that it would only get in your way if you took it."


	.FUNCT	TROPHY-PSEUDO
	EQUAL?	PRSA,V?READ /FALSE
	EQUAL?	PRSA,V?RUB,V?TAKE \FALSE
	PRINTR	"As your fingers near it, you get a nasty shock (but fortunately not a fatal one)."


	.FUNCT	STAND-FCN
	EQUAL?	PRSA,V?TAKE \?ELS5
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" is firmly attached to the bench."
?ELS5:	EQUAL?	PRSA,V?PUT-ON,V?PUT \FALSE
	EQUAL?	PRSO,PALANTIR-1,PALANTIR-2,PALANTIR-3 \FALSE
	EQUAL?	PRSI,STAND-1,STAND-2,STAND-3 \FALSE
	CALL	V-PUT
	IN?	PALANTIR-1,STAND-1 \TRUE
	IN?	PALANTIR-2,STAND-2 \TRUE
	IN?	PALANTIR-3,STAND-3 \TRUE
	REMOVE	PALANTIR-1
	REMOVE	PALANTIR-2
	REMOVE	PALANTIR-3
	MOVE	STAND-4,WORKBENCH
	PRINTI	"As you place the "
	PRINTD	PRSO
	PRINTI	" in the "
	PRINTD	PRSI
	PRINTI	", a low humming noise begins, and you can feel the hairs on the back of your neck begin to stand up. The three spheres begin to vibrate, faster and faster, as the noise becomes higher and higher pitched. Three puffs of smoke, one red, one blue, one white, rise up from empty stands. The spheres are gone! But in the center of the triangle formed by the stands is now a black stand of obsidian in which rests a strange black sphere."
	CRLF	
	RTRUE	


	.FUNCT	IN-AQUARIUM-FCN,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"There is a sandy floor here, and your vision seems murky and blurred. The wall you are looking at is nicely dressed stone."
	CRLF	
	IN?	SERPENT,AQUARIUM \TRUE
	RANDOM	100
	GRTR?	25,STACK \?ELS13
	PRINTR	"While you watch a shadow seems to pass overhead."
?ELS13:	RANDOM	100
	GRTR?	5,STACK \TRUE
	PRINTI	"The head of some horrible serpent pokes into view, its beady green eyes almost seeming to see you."
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	IN?	SERPENT,AQUARIUM \?ELS26
	CALL	JIGS-UP,STR?289
	RSTACK	
?ELS26:	CALL	JIGS-UP,STR?290
	RSTACK	


	.FUNCT	AQUARIUM-FCN,OBJ
	EQUAL?	PRSA,V?THROUGH,V?BOARD \?ELS5
	CALL	DO-WALK,P?IN
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS7
	IN?	SERPENT,AQUARIUM \?ELS7
	PRINTR	"In the aquarium is a baby sea-serpent who eyes you suspiciously. His scaly body writhes about in the huge tank."
?ELS7:	EQUAL?	PRSA,V?ATTACK,V?MUNG \?ELS17
	EQUAL?	PRSO,AQUARIUM /?THN14
?ELS17:	EQUAL?	PRSA,V?THROW \FALSE
	EQUAL?	PRSI,AQUARIUM \FALSE
?THN14:	EQUAL?	PRSO,AQUARIUM \?ELS22
	ZERO?	PRSI /FALSE
	SET	'OBJ,PRSI
	JUMP	?CND20
?ELS22:	SET	'OBJ,PRSO
?CND20:	MOVE	OBJ,HERE
	IN?	DEAD-SERPENT,HERE \?ELS34
	PRINTR	"The aquarium is already broken!"
?ELS34:	EQUAL?	OBJ,FLASK \?ELS38
	CALL	JIGS-UP,STR?291
	RTRUE	
?ELS38:	CALL	BOMB?,OBJ
	ZERO?	STACK /?ELS40
	CALL	INT,I-FUSE
	PUT	STACK,0,0
	RTRUE	
?ELS40:	FSET?	OBJ,WEAPONBIT /?THN43
	GETP	OBJ,P?SIZE
	GRTR?	STACK,10 \?ELS42
?THN43:	REMOVE	SERPENT
	MOVE	PALANTIR-3,AQUARIUM
	FCLEAR	PALANTIR-3,NDESCBIT
	PUTP	AQUARIUM,P?LDESC,STR?292
	MOVE	DEAD-SERPENT,HERE
	PRINTI	"The "
	PRINTD	OBJ
	PRINTI	" shatters the glass wall of the aquarium, spilling out an impressive amount of salt water and wet sand. It also spills out an extremely annoyed sea serpent who bites angrily at the "
	PRINTD	OBJ
	PRINTI	", and then at you. He is having difficulty breathing, and he seems to hold you responsible for his current problem."
	EQUAL?	PRSA,V?MUNG \?ELS51
	PRINTI	" He manages to rend you limb from limb before he drowns in the air."
	CRLF	
	CALL	JIGS-UP,STR?293
	RSTACK	
?ELS51:	PRINTR	" He tries to slither across the stone floor towards you. Fortunately, he expires mere inches away from biting off your foot. A clear crystal sphere sits amid the sand and broken glass on the bottom of the aquarium."
?ELS42:	PRINTI	"The "
	PRINTD	OBJ
	PRINTR	" bounces harmlessly off the glass."


	.FUNCT	SERPENT-FCN
	EQUAL?	SERPENT,WINNER \?ELS5
	PRINTR	"The serpent only stares hungrily at you."
?ELS5:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?ELS9
	PRINTR	"He swims towards you with a powerful stroke of his flippers, dagger-like teeth dripping. Fortunately, he doesn't want to crash into the aquarium wall, and contents himself with splashing you with water."
?ELS9:	EQUAL?	PRSA,V?PUT \?ELS13
	EQUAL?	PRSO,SERPENT \?ELS13
	PRINTR	"Impossible for many reasons."
?ELS13:	EQUAL?	PRSA,V?GIVE,V?TAKE \FALSE
	CALL	JIGS-UP,STR?294
	RSTACK	


	.FUNCT	DEAD-SERPENT-FCN
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"This may only be a baby sea serpent, but it's as big as a small whale."


	.FUNCT	GENIE-FCN,RARG=M-OBJECT,V,HOARD
	EQUAL?	PRSA,V?HELLO \?ELS5
	PRINTR	"The genie grins demonically, but says nothing."
?ELS5:	EQUAL?	WINNER,GENIE \?ELS9
	ZERO?	GENIE-READY? \?ELS14
	PRINTI	"""My fee is not paid! I perform no tasks for free! We demons have a strong union these days."""
	CRLF	
	RETURN	2
?ELS14:	EQUAL?	PRSA,V?SGIVE /FALSE
	GET	P-PRSO,0
	GRTR?	STACK,1 /?THN23
	GET	P-PRSI,0
	GRTR?	STACK,1 \?ELS22
?THN23:	PRINTI	"""I will do one thing only, oh gracious master!"""
	CRLF	
	RETURN	2
?ELS22:	EQUAL?	PRSA,V?MOVE \?ELS30
	EQUAL?	PRSO,GLOBAL-MENHIR \?ELS30
	SET	'MENHIR-POSITION,1
	PRINTI	"The demon is gone for a moment. ""A trifle... My little finger alone was enough."""
	CRLF	
	CALL	GENIE-LEAVES
	RSTACK	
?ELS30:	EQUAL?	PRSA,V?TAKE \?ELS36
	EQUAL?	PRSO,GLOBAL-MENHIR \?ELS41
	REMOVE	MENHIR
	SET	'MENHIR-POSITION,2
	PRINTI	"The demon flashes away for a second. ""I have little use for such a thing, but perhaps as a doorstop..."""
	CRLF	
	CALL	GENIE-LEAVES
	RSTACK	
?ELS41:	EQUAL?	PRSO,WAND \?ELS45
	PRINTI	"""This I do gladly, oh fool!"" cackles the demon gleefully. He stretches out an enormous hand towards the wand and taking it like a toothpick (this is a large demon), points it at himself. ""Free!"" he commands, and the demon and his wand vanish forever."
	CRLF	
	CALL	GENIE-LEAVES,FALSE-VALUE
	REMOVE	WAND
	RTRUE	
?ELS45:	FSET?	PRSO,TAKEBIT \?ELS49
	CALL	GENIE-LEAVES,FALSE-VALUE
	REMOVE	PRSO
	PRINTI	"The demon snaps his fingers, the "
	PRINTD	PRSO
	PRINTR	" spins wildly in the air in front of him, then he and it depart."
?ELS49:	PRINTR	"""I fear that I cannot take such a thing."""
?ELS36:	EQUAL?	PRSA,V?GIVE \?ELS57
	EQUAL?	PRSI,ME \?ELS57
	EQUAL?	PRSO,WAND \?ELS64
	PRINTI	"""I hear and obey!"" says the demon. He stretches out an enormous hand towards the wand. The Wizard is unsure what to do, pointing it threateningly at the demon, then at you. ""Fudge!"" he cries, but aside from a strong odor of chocolate in the air, there is no effect. The demon plucks the wand out of his hand (it's about toothpick-size to him) and gingerly lays it before you. He fades into the smoke, which disperses. The wizard runs from the room in terror."
	CRLF	
	REMOVE	WIZARD
	CALL	GENIE-LEAVES,FALSE-VALUE
	FCLEAR	WAND,NDESCBIT
	MOVE	WAND,HERE
	RTRUE	
?ELS64:	EQUAL?	PRSO,GLOBAL-MENHIR \?ELS68
	MOVE	MENHIR,PENTAGRAM-ROOM
	FCLEAR	MENHIR,NDESCBIT
	FCLEAR	MENHIR,TAKEBIT
	SET	'MENHIR-POSITION,3
	PRINTI	"He waves his hands, and the menhir drops softly at your feet."
	CRLF	
	CALL	GENIE-LEAVES
	RSTACK	
?ELS68:	FSET?	PRSO,TAKEBIT \?ELS72
	MOVE	PRSO,PENTAGRAM-ROOM
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" appears before you and settles to the ground."
	CRLF	
	CALL	GENIE-LEAVES
	RSTACK	
?ELS72:	PRINTR	"""Were it possible, this would be my fondest wish, but alas..."""
?ELS57:	EQUAL?	PRSA,V?ATTACK \?ELS80
	EQUAL?	PRSO,GLOBAL-CERBERUS \?ELS85
	PRINTR	"""This may prove taxing, but we'll see. Perhaps I'll tame him for a pup instead."" The demon disappears for an instant, then reappears. He looks rather gnawed and scratched. He winces. ""Too much for me. Puppy dog, indeed. You're welcome to him. Never did like dogs anyway... Any other orders, oh beneficent one?"""
?ELS85:	EQUAL?	PRSO,WIZARD \?ELS89
	PRINTI	"The demon grins hideously. ""This has been my desire e'er since this charlatan bent me to his service. I perform this deed with pleasure!"" The demon forms himself back into a cloud of greasy smoke. The cloud envelops the Wizard, who waves his wand fruitlessly, mumbling various phrases which begin with ""F"". A horrible scream is heard, and the smoke begins to clear. Nothing remains of the Wizard but his wand."
	CRLF	
	REMOVE	WIZARD
	FCLEAR	WAND,NDESCBIT
	MOVE	WAND,HERE
	CALL	GENIE-LEAVES
	RSTACK	
?ELS89:	EQUAL?	PRSO,ME \?ELS93
	CALL	GENIE-LEAVES,FALSE-VALUE
	SET	'WINNER,ADVENTURER
	CALL	JIGS-UP,STR?295
	RSTACK	
?ELS93:	PRINTI	"""I know no way to kill a "
	PRINTD	PRSO
	PRINTR	"."""
?ELS80:	EQUAL?	PRSA,V?EXAMINE,V?FIND \?ELS99
	PRINTI	"""I am not permitted to "
	EQUAL?	PRSA,V?FIND \?ELS104
	PRINTI	"answer questions"
	JUMP	?CND102
?ELS104:	PRINTI	"perform such menial tasks"
?CND102:	PRINTR	". The terms of my contract are explicit on this matter, learned one. Surely you would not wish to violate my contract?"" He licks his lips with a forked tongue like a snake's. ""The penalty clauses are ... hmm ... devilish."""
?ELS99:	PRINTR	"""Apologies, oh master, but even for such a one as I this is not possible."" He seems somewhat chagrined to have to admit this."
?ELS9:	EQUAL?	PRSA,V?MUNG,V?ATTACK,V?EXORCISE \?ELS118
	PRINTR	"The demon laughs uproariously."
?ELS118:	EQUAL?	PRSA,V?GIVE \FALSE
	EQUAL?	PRSI,GENIE \FALSE
	EQUAL?	PRSO,IRON-BOX \?CND125
	IN?	VIOLIN,PRSO \?CND125
	PRINTI	"The genie frowns briefly, then "
	FSET?	PRSO,OPENBIT \?ELS134
	PRINTI	"looks inside"
	JUMP	?CND132
?ELS134:	PRINTI	"opens"
?CND132:	PRINTI	" the box. He smiles horribly."
	CRLF	
	CALL	REMOVE-CAREFULLY,IRON-BOX
	SET	'PRSO,VIOLIN
?CND125:	GETPT	PRSO,P?VALUE
	ZERO?	STACK /?ELS147
	EQUAL?	PRSO,SWORD /?ELS147
	CALL	REMOVE-CAREFULLY,PRSO
	INC	'GENIE-HOARD
	CALL	SCORE-UPD,2
	CALL	CASE-WORTH
	ADD	GENIE-HOARD,STACK >HOARD
	LESS?	HOARD,TREASURES-MAX /?ELS154
	SET	'GENIE-READY?,TRUE-VALUE
	PUTP	WIZARD,P?LDESC,STR?296
	PRINTR	"""This will do for my fee. 'Tis a paltry hoard, but as you have done me a small service by loosing me from this wizard, it will suffice."""
?ELS154:	PRINTI	""""
	GET	GENIE-THANKS,HOARD
	PRINT	STACK
	PRINTI	""""
	CRLF	
	EQUAL?	HOARD,8 \TRUE
	PRINTR	"The Wizard looks at you as if you are a madman. He tears his beard and stares at you fearfully."
?ELS147:	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS167
	CALL	GENIE-LEAVES,FALSE-VALUE
	PRINTR	"""I fear that this violates my contract, oh foolish one. Thus, I am free to depart."""
?ELS167:	CALL	REMOVE-CAREFULLY,PRSO
	PRINTI	"The demon gladly takes the "
	PRINTD	PRSO
	PRINTR	" and smiles balefully, revealing enormous fangs."


	.FUNCT	GENIE-LEAVES,NOISY?=1
	FSET	GENIE,INVISIBLE
	ZERO?	NOISY? /?CND1
	PRINTI	"The genie departs, his agreement fulfilled."
	CRLF	
?CND1:	SET	'P-CONT,FALSE-VALUE
	RETURN	2


	.FUNCT	CASE-WORTH,F,W=0
	FIRST?	WIZARD-CASE >F /?KLU9
?KLU9:	
?PRG1:	ZERO?	F \?CND3
	RETURN	W
?CND3:	GETPT	F,P?VALUE
	ZERO?	STACK /?CND6
	INC	'W
?CND6:	NEXT?	F >F /?KLU10
?KLU10:	JUMP	?PRG1


	.FUNCT	PENTAGRAM-FCN,RARG=M-BEG
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?BOARD,V?THROUGH \?ELS10
	PRINTR	"You try to enter the pentagram, but are forced back by an invisible power."
?ELS10:	EQUAL?	PRSA,V?PUT-ON,V?PUT \FALSE
	EQUAL?	PRSO,PALANTIR-4 \FALSE
	REMOVE	PALANTIR-4
	FCLEAR	GENIE,INVISIBLE
	MOVE	GENIE,PENTAGRAM-ROOM
	PRINTR	"A cold wind blows outward from the sphere. The candles flicker, and a low moan, almost inaudible, is heard. It rises in volume and pitch until it becomes a high-pitched keening. A dim shape becomes visible in the air above the sphere. The shape resolves into a large and somewhat formidable looking demon. He looks around, tests the walls of the pentagram experimentally, then sees you! ""Hmm, a new master..."" he says under his breath. ""Greetings, oh master! Wouldst desire a service, as our contract stateth? For some pittance of wealth, some trifle, I will gratify thy desires to the utmost limit of my powers, and they are not inconsiderable."" He makes a pass with his massive arms and the walls begin to shake a little. Another pass and the shaking stops. ""A nice effect... I find it makes for a better relationship to give such a demonstration early on."" He grins vilely."


	.FUNCT	WIZARD-FCN,RARG=M-OBJECT,OLIT
	EQUAL?	WINNER,WIZARD \?ELS5
	EQUAL?	PRSA,V?GIVE \?ELS10
	PRINTR	"The Wizard replies ""Foolishment!"""
?ELS10:	PRINTR	"The Wizard considers your statement carefully. His expression indicates he regards it as fanciful."
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS18
	EQUAL?	PRSI,WIZARD \?ELS18
	SET	'OLIT,LIT
	CALL	REMOVE-CAREFULLY,PRSO
	CALL	BOMB?,PRSO
	ZERO?	STACK /?ELS25
	IN?	GENIE,PENTAGRAM-ROOM \?ELS30
	MOVE	PRSO,HERE
	PRINTR	"The wizard accepts this final folly resignedly."
?ELS30:	REMOVE	WIZARD
	PRINTR	"""Hmm..."" The Wizard mutters something, then waves his wand over the bomb. It transforms into a bouquet of flowers. Both Wizard and flowers disappear."
?ELS25:	ZERO?	OLIT /?ELS38
	ZERO?	LIT \?ELS38
	PRINTI	"""Thank you."" As the Wizard places the "
	PRINTD	PRSO
	PRINTR	" under his robe, the room becomes dark."
?ELS38:	PRINTR	"""Thank you."""
?ELS18:	CALL	HELLO?,WIZARD
	ZERO?	STACK /?ELS48
	PRINTR	"The Wizard seems surprised, much as you might be if a dog talked."
?ELS48:	EQUAL?	PRSA,V?MUNG,V?ATTACK \FALSE
	REMOVE	WIZARD
	IN?	WAND,WIZARD \?ELS55
	PRINTI	"The Wizard retreats, waving his wand and chanting. He says ""Fear!"" "
	JUMP	?CND53
?ELS55:	PRINTI	"The Wizard tries to cast the ""Fear!"" spell, but without his wand! "
?CND53:	FSET?	GENIE,INVISIBLE /?ELS66
	PRINTR	"Nothing happens! With a terrified glance at the demon, the wizard runs past you and out of the room."
?ELS66:	PRINTI	"You are suddenly terrified. The Wizard seems huge and terrible, looming over you. You flee, terrified. He chuckles, snaps his fingers, and disappears."
	CRLF	
	CRLF	
	SET	'SPELL?,S-FEAR
	PUTP	ADVENTURER,P?ACTION,MAGIC-ACTOR
	CALL	QUEUE,I-WIZARD,10
	PUT	STACK,0,1
	CALL	RANDOM-WALK
	RSTACK	


	.FUNCT	I-WIZARD,CAST-PROB,PCNT=0,F,WLOC
	LOC	WINNER >WLOC
	CALL	QUEUE,I-WIZARD,4
	PUT	STACK,0,1
	ZERO?	DEAD \FALSE
	ZERO?	SPELL? /?CND1
	EQUAL?	SPELL?,S-FLOAT \?ELS10
	EQUAL?	HERE,WELL-TOP \?ELS13
	CALL	JIGS-UP,STR?306
	RTRUE	
?ELS13:	FSET?	HERE,NONLANDBIT \?CND8
	EQUAL?	HERE,WELL-BOTTOM,VOLCANO-BOTTOM /?CND8
	CALL	JIGS-UP,STR?307
	RTRUE	
?ELS10:	EQUAL?	SPELL?,S-FEEBLE \?ELS19
	SET	'LOAD-ALLOWED,LOAD-MAX
	JUMP	?CND8
?ELS19:	EQUAL?	SPELL?,S-FIERCE \?ELS21
	SET	'SWORD-GLOW,0
	JUMP	?CND8
?ELS21:	EQUAL?	SPELL?,S-FUMBLE \?CND8
	SET	'FUMBLE-NUMBER,7
	SET	'FUMBLE-PROB,8
?CND8:	GET	SPELL-STOPS,SPELL?
	ZERO?	STACK /?CND24
	GET	SPELL-STOPS,SPELL?
	PRINT	STACK
	CRLF	
?CND24:	PUTP	ADVENTURER,P?ACTION,0
	SET	'SPELL?,FALSE-VALUE
	RTRUE	
?CND1:	IN?	GENIE,PENTAGRAM-ROOM \?CND29
	CALL	INT,I-WIZARD
	PUT	STACK,0,0
	IN?	WIZARD,PENTAGRAM-ROOM /TRUE
	MOVE	WIZARD,PENTAGRAM-ROOM
	IN?	WINNER,PENTAGRAM-ROOM \TRUE
	PRINTI	"Suddenly the Wizard materializes in the room. He is astonished by what he sees: his servant in deep conversation with a common adventurer! He draws forth his wand, waves it frantically, and incants ""Frobizz! Frobozzle! Frobnoid!"" The demon laughs heartily. ""You no longer control the Black Crystal, hedge-wizard! Your wand is powerless! Your doom is sealed!"" The demon turns to you, expectantly."
	CRLF	
	RTRUE	
?CND29:	ZERO?	LIT \?CND40
	FSET?	LAMP,RMUNGBIT \?CND40
	GRTR?	SCORE,200 \?CND40
	SET	'ALWAYS-LIT,TRUE-VALUE
	SET	'LIT,TRUE-VALUE
	PRINTR	"In the darkness you hear the voice of the Wizard. ""Dear me, you seem to have gotten into quite a pickle."" He chuckles. ""Fluoresce!"" he incants. It is no longer dark."
?CND40:	LOC	WIZARD
	ZERO?	STACK /?CND47
	RANDOM	100
	GRTR?	80,STACK \?CND47
	ZERO?	LIT /?CND52
	IN?	WIZARD,HERE \?CND52
	PRINTI	"The Wizard vanishes."
	CRLF	
?CND52:	REMOVE	WIZARD
	RTRUE	
?CND47:	RANDOM	100
	GRTR?	10,STACK \FALSE
	ZERO?	LIT \?ELS66
	PRINTI	"You feel a slight outrush of air as something moves nearby."
	CRLF	
	JUMP	?CND64
?ELS66:	EQUAL?	HERE,POSTS-ROOM,POOL-ROOM \?ELS70
	PRINTI	"A huge and terrible wizard appears before you, as large as the largest tree! He looks down on you as you would look upon a gnat!"
	CRLF	
	JUMP	?CND64
?ELS70:	FSET?	HERE,NONLANDBIT \?ELS74
	PRINTI	"The Wizard appears, floating nonchalantly in the air beside you. He grins sideways at you."
	CRLF	
	JUMP	?CND64
?ELS74:	PRINTI	"A strange little man in a long cloak appears suddenly in the room. He is wearing a high pointed hat embroidered with astrological signs. He has a long, stringy, and unkempt beard."
	CRLF	
?CND64:	IN?	PALANTIR-4,ADVENTURER \?ELS83
	ZERO?	LIT /?ELS86
	PRINTI	"The Wizard notices that you carry the Black Crystal, and with an unseemly haste, he disappears."
	CRLF	
	JUMP	?CND84
?ELS86:	PRINTI	"You feel a sudden inrush of air as though something disappeared."
	CRLF	
?CND84:	REMOVE	WIZARD
	RTRUE	
?ELS83:	RANDOM	100
	GRTR?	20,STACK \?CND81
	ZERO?	LIT /?ELS98
	PRINTI	"He mutters something (muffled by his beard) and disappears as suddenly as he came."
	CRLF	
	JUMP	?CND96
?ELS98:	PRINTI	"You hear low, confused muttering."
	CRLF	
?CND96:	REMOVE	WIZARD
	RTRUE	
?CND81:	IN?	PALANTIR-1,ADVENTURER \?CND106
	INC	'PCNT
?CND106:	IN?	PALANTIR-2,ADVENTURER \?CND109
	INC	'PCNT
?CND109:	IN?	PALANTIR-3,ADVENTURER \?CND112
	INC	'PCNT
?CND112:	MUL	PCNT,20
	SUB	80,STACK >CAST-PROB
	ZERO?	LIT /?ELS117
	PRINTI	"The Wizard draws forth his wand and waves it in your direction. It begins to glow with a faint blue glow."
	CRLF	
	JUMP	?CND115
?ELS117:	PRINTI	"Suddenly, illuminated by the faint blue glow of a magic wand pointed in your direction, you see the Wizard!"
	CRLF	
?CND115:	RANDOM	100
	GRTR?	CAST-PROB,STACK \?ELS129
	MOVE	WIZARD,HERE
	RANDOM	SPELLS >SPELL?
	PUTP	ADVENTURER,P?ACTION,MAGIC-ACTOR
	MUL	5,PCNT
	SUB	30,STACK
	RANDOM	STACK
	ADD	5,STACK
	CALL	QUEUE,I-WIZARD,STACK
	PUT	STACK,0,1
	RANDOM	100
	GRTR?	75,STACK \?ELS132
	PRINTI	"The Wizard, in a deep and resonant voice, speaks the word """
	GET	SPELL-NAMES,SPELL?
	PRINT	STACK
	PRINTI	"!"" He then vanishes, cackling gleefully."
	CRLF	
	JUMP	?CND130
?ELS132:	PRINTI	"The Wizard, almost inaudibly, whispers a word beginning with ""F,"" and then disappears, chuckling nastily."
	CRLF	
?CND130:	REMOVE	WIZARD
	GET	SPELL-HINTS,SPELL?
	ZERO?	STACK /?CND139
	GET	SPELL-HINTS,SPELL?
	PRINT	STACK
	CRLF	
?CND139:	EQUAL?	SPELL?,S-FALL \?ELS146
	FSET?	WLOC,VEHBIT \TRUE
	PRINTI	"You suddenly fall headlong out of the "
	PRINTD	WLOC
	PRINTI	" as though someone had flipped it over."
	CRLF	
	EQUAL?	HERE,WELL-TOP \?ELS154
	CALL	JIGS-UP,STR?308
	RTRUE	
?ELS154:	FSET?	HERE,NONLANDBIT \?ELS156
	EQUAL?	HERE,VOLCANO-BOTTOM,WELL-BOTTOM /?ELS156
	CALL	JIGS-UP,STR?309
	RTRUE	
?ELS156:	MOVE	WINNER,HERE
	RTRUE	
?ELS146:	EQUAL?	SPELL?,S-FLOAT \?ELS162
	FSET?	WLOC,VEHBIT \?ELS165
	PRINTI	" You rise majestically out of the "
	PRINTD	WLOC
	PRINTI	", coming to a stop about five feet above it and to one side."
	CRLF	
	MOVE	WINNER,HERE
	RTRUE	
?ELS165:	PRINTR	"Slowly, you and all your belongings rise into the air, stopping after about five feet."
?ELS162:	EQUAL?	SPELL?,S-FEEBLE \?ELS173
	SET	'LOAD-ALLOWED,50
	FIRST?	WINNER >F \TRUE
	PRINTI	"In fact, you feel so weak that you drop the "
	PRINTD	F
	PRINTI	"."
	CRLF	
	MOVE	F,WLOC
	RTRUE	
?ELS173:	EQUAL?	SPELL?,S-FEAR \?ELS180
	FSET?	WLOC,VEHBIT \?ELS183
	PRINTI	"You cower in the corner of the "
	PRINTD	WLOC
	PRINTR	", hoping the wizard won't see you."
?ELS183:	CRLF	
	CALL	RANDOM-WALK
	RTRUE	
?ELS180:	EQUAL?	SPELL?,S-FUMBLE \?ELS189
	SET	'FUMBLE-NUMBER,3
	SET	'FUMBLE-PROB,25
	FIRST?	ADVENTURER >F \TRUE
	PRINTI	"Ooops! You dropped the "
	PRINTD	F
	PRINTI	"."
	CRLF	
	MOVE	F,WLOC
	RTRUE	
?ELS189:	EQUAL?	SPELL?,S-FILCH \?ELS196
	CALL	ROB,WINNER,WIZARD-CASE
	ZERO?	STACK /TRUE
	PRINTR	"Something you are carrying has disappeared!"
?ELS196:	EQUAL?	SPELL?,S-FIERCE \TRUE
	PRINTR	"The Wizard mumbles something under his breath, and just before you reach him, he vanishes."
?ELS129:	RANDOM	100
	GRTR?	50,STACK \?ELS207
	REMOVE	WIZARD
	PRINTR	"There is a loud crackling noise. Blue smoke rises from out of the Wizard's sleeve. He sighs and disappears."
?ELS207:	RANDOM	100
	GRTR?	50,STACK \?ELS211
	REMOVE	WIZARD
	PRINTI	"The Wizard incants """
	CALL	RANDOM-ELEMENT,SPELL-NAMES
	PRINT	STACK
	PRINTR	"!"" but nothing happens. He shakes the wand. Nothing happens. With a slightly embarrassed glance in your direction, he vanishes."
?ELS211:	MOVE	WIZARD,HERE
	PRINTR	"The Wizard seems about to say something, but thinks better of it, and peers at you from under his bushy eyebrows."


	.FUNCT	ROB,WHO,WHERE,N,X,ROBBED?=0
	FIRST?	WHO >X /?KLU9
?KLU9:	
?PRG1:	ZERO?	X \?CND3
	RETURN	ROBBED?
?CND3:	NEXT?	X >N /?KLU10
?KLU10:	CALL	RIPOFF,X,WHERE
	ZERO?	STACK /?CND6
	SET	'ROBBED?,TRUE-VALUE
?CND6:	SET	'X,N
	JUMP	?PRG1


	.FUNCT	RIPOFF,X,WHERE
	FSET?	X,INVISIBLE /FALSE
	GETPT	X,P?VALUE
	ZERO?	STACK /FALSE
	EQUAL?	X,PALANTIR-1 /FALSE
	EQUAL?	X,PALANTIR-2 /FALSE
	EQUAL?	X,PALANTIR-3 /FALSE
	EQUAL?	X,GOLD-KEY /FALSE
	EQUAL?	X,CANDY /FALSE
	MOVE	X,WHERE
	FSET	X,TOUCHBIT
	RTRUE	


	.FUNCT	WIZARD-CASE-FCN
	EQUAL?	WINNER,GENIE \?ELS5
	EQUAL?	PRSA,V?OPEN,V?MUNG \FALSE
	REMOVE	WIZARD-CASE
	MOVE	BROKEN-CASE,TROPHY-ROOM
	PRINTR	"The demon smashes the case into smithereens. Everything in it smashes as well."
?ELS5:	EQUAL?	PRSA,V?ENCHANT \?ELS14
	EQUAL?	SPELL-USED,W?FILCH \?ELS14
	CALL	ROB,WIZARD-CASE,HERE
	SET	'SPELL-HANDLED?,TRUE-VALUE
	PRINTR	"The contents of the case are arrayed at your feet."
?ELS14:	EQUAL?	PRSA,V?CLOSE,V?MUNG,V?OPEN /?THN21
	EQUAL?	PRSA,V?TAKE \FALSE
?THN21:	PRINTR	"The case is protected by a fearful spell. You cannot touch it in any way."


	.FUNCT	WAND-FCN
	EQUAL?	PRSA,V?GIVE,V?PUT,V?TAKE \?ELS5
	IN?	WAND,WIZARD \?ELS5
	EQUAL?	WINNER,ADVENTURER \?ELS12
	PRINTR	"The Wizard snatches it away."
?ELS12:	EQUAL?	WINNER,ROBOT \FALSE
	CALL	JIGS-UP,STR?333
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?WAVE \?ELS18
	EQUAL?	PRSI,GRUE \?ELS18
	PRINTR	"There is no grue in sight, but a hissing sound issues forth from the darkness."
?ELS18:	EQUAL?	PRSA,V?RAISE,V?RUB,V?WAVE \FALSE
	EQUAL?	PRSO,WAND \?ELS27
	IN?	WAND,WINNER /?ELS27
	PRINTR	"You don't have the wand!"
?ELS27:	ZERO?	WAND-ON \?THN34
	ZERO?	SPELL-USED \?THN34
	ZERO?	SPELL-VICTIM /?ELS33
?THN34:	RANDOM	100
	GRTR?	5,STACK \?ELS38
	CALL	JIGS-UP,STR?334
	RTRUE	
?ELS38:	PRINTR	"A lot you know about magic! A magic wand takes a while to recharge after use! You might cause it to short-circuit!"
?ELS33:	EQUAL?	PRSA,V?WAVE \?ELS44
	EQUAL?	PRSO,WAND \?ELS47
	ZERO?	PRSI /?ELS47
	SET	'WAND-ON,PRSI
	SET	'WAND-ON-LOC,HERE
	JUMP	?CND25
?ELS47:	PRINTR	"At what?"
?ELS44:	EQUAL?	PRSA,V?RUB \?ELS55
	EQUAL?	PRSI,WAND \?ELS58
	ZERO?	PRSO /?ELS58
	SET	'WAND-ON,PRSO
	JUMP	?CND25
?ELS58:	PRINTR	"Touch what?"
?ELS55:	EQUAL?	PRSA,V?RAISE \?CND25
	PRINTR	"The wand grows warm and seems to vibrate."
?CND25:	ZERO?	WAND-ON /TRUE
	SET	'SPELL-USED,FALSE-VALUE
	SET	'SPELL-VICTIM,FALSE-VALUE
	EQUAL?	WAND-ON,ME,WAND \?ELS75
	SET	'WAND-ON,FALSE-VALUE
	PRINTI	"Fortunately a safety interlock prevents the fatal feedback loop that this would cause."
	CRLF	
	JUMP	?CND73
?ELS75:	PRINTI	"The wand grows warm, the "
	PRINTD	WAND-ON
	PRINTI	" seems to glow dimly with magical essences, and you feel suffused with power."
	CRLF	
?CND73:	CALL	QUEUE,I-WAND,2
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-WAND
	ZERO?	WAND-ON /?ELS5
	EQUAL?	WAND-ON-LOC,HERE /?THN8
	IN?	WAND-ON,WINNER \?ELS5
?THN8:	PRINTI	"The "
	PRINTD	WAND-ON
	PRINTI	" stops glowing and the power within you weakens."
	CRLF	
	SET	'WAND-ON,FALSE-VALUE
	RTRUE	
?ELS5:	SET	'WAND-ON,FALSE-VALUE
	RFALSE	


	.FUNCT	WIZARD-QUARTERS-FCN,RARG,PICK,L
	EQUAL?	RARG,M-LOOK,M-FLASH \FALSE
	PRINTI	"This is where the Wizard of Frobozz lives. The room is "
	GET	WIZQDESCS,0 >L
	RANDOM	L >PICK
	EQUAL?	PICK,WIZQLAST \?CND8
	EQUAL?	PICK,L \?ELS13
	DEC	'PICK
	JUMP	?CND8
?ELS13:	INC	'PICK
?CND8:	SET	'WIZQLAST,PICK
	GET	WIZQDESCS,PICK
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	BRIDGE-FCN
	EQUAL?	PRSA,V?CROSS \?ELS5
	CALL	DO-WALK,P?CROSS
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?LEAP \FALSE
	CALL	JIGS-UP,STR?343
	RSTACK	


	.FUNCT	STREAM-FCN
	EQUAL?	PRSA,V?THROUGH,V?SWIM \?ELS5
	PRINTR	"You can't swim in the stream."
?ELS5:	EQUAL?	PRSA,V?CROSS \FALSE
	PRINTR	"You'll have to find a ford or a bridge."


	.FUNCT	CHASM-FCN
	EQUAL?	PRSA,V?LEAP /?THN6
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSO,ME \?ELS5
?THN6:	PRINTR	"For a change, you look before leaping. You realize you would never survive."
?ELS5:	EQUAL?	PRSA,V?CROSS \?ELS13
	PRINTR	"You'll have to find a bridge."
?ELS13:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,PSEUDO-OBJECT \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" drops out of sight into the chasm."
	CRLF	
	REMOVE	PRSO
	RTRUE	


	.FUNCT	TUNNEL-OBJECT
	EQUAL?	PRSA,V?THROUGH \?ELS5
	GETPT	HERE,P?IN
	ZERO?	STACK /?ELS5
	CALL	DO-WALK,P?IN
	RTRUE	
?ELS5:	CALL	PATH-OBJECT
	RSTACK	


	.FUNCT	STALA-PSEUDO
	EQUAL?	PRSA,V?MUNG,V?TAKE \FALSE
	PRINTR	"The only ones you can reach are too large to successfully break off."


	.FUNCT	MOSS-FCN
	EQUAL?	PRSA,V?RUB,V?TAKE \FALSE
	PRINTR	"Some of the moss rubs off on you, but it stops glowing very quickly once plucked from its environment."


	.FUNCT	ROSE-BUSH-FCN
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"You prick your finger trying to take a rose, and jump back annoyed. The rose almost seemed to move its thorns into your path."


	.FUNCT	I-SPELL
	ZERO?	SPELL-HANDLED? \?CND1
	ZERO?	SPELL-VICTIM /?CND1
	CALL	PERFORM,V?DISENCHANT,SPELL-VICTIM
?CND1:	SET	'SPELL-HANDLED?,FALSE-VALUE
	SET	'WAND-ON,FALSE-VALUE
	SET	'SPELL-USED,FALSE-VALUE
	SET	'SPELL-VICTIM,FALSE-VALUE
	RETURN	SPELL-VICTIM


	.FUNCT	V-DIAGNOSE
	ZERO?	DEAD /?ELS3
	PRINTI	"You are dead."
	JUMP	?CND1
?ELS3:	EQUAL?	SPELL?,S-FERMENT \?ELS8
	PRINTI	"You are drunk."
	JUMP	?CND1
?ELS8:	EQUAL?	SPELL?,S-FEEBLE \?ELS12
	PRINTI	"You seem unusually weak right now."
	JUMP	?CND1
?ELS12:	EQUAL?	SPELL?,S-FLOAT \?ELS16
	PRINTI	"You seem somewhat light."
	JUMP	?CND1
?ELS16:	EQUAL?	SPELL?,S-FREEZE \?ELS20
	PRINTI	"You are frozen stiff."
	JUMP	?CND1
?ELS20:	PRINTI	"You are in perfect health."
?CND1:	CRLF	
	ZERO?	DEATHS /FALSE
	PRINTI	"You have been killed "
	EQUAL?	DEATHS,1 \?ELS36
	PRINTI	"once."
	JUMP	?CND34
?ELS36:	EQUAL?	DEATHS,2 \?ELS40
	PRINTI	"twice."
	JUMP	?CND34
?ELS40:	PRINTI	"an awful lot."
?CND34:	CRLF	
	RTRUE	


	.FUNCT	V-SCORE,ASK?=1
	PRINTI	"Your score "
	ZERO?	ASK? /?ELS5
	PRINTI	"would be "
	JUMP	?CND3
?ELS5:	PRINTI	"is "
?CND3:	PRINTN	SCORE
	PRINTI	" (total of 400 points), in "
	PRINTN	MOVES
	EQUAL?	MOVES,1 \?ELS21
	PRINTI	" move."
	JUMP	?CND19
?ELS21:	PRINTI	" moves."
?CND19:	CRLF	
	PRINTI	"This score gives you the rank of "
	EQUAL?	SCORE,400 \?ELS32
	PRINTI	"Master Adventurer"
	ZERO?	WON-FLAG \?CND30
	PRINTI	", but somehow you don't feel done"
	JUMP	?CND30
?ELS32:	GRTR?	SCORE,360 \?ELS41
	PRINTI	"Wizard"
	JUMP	?CND30
?ELS41:	GRTR?	SCORE,320 \?ELS45
	PRINTI	"Master"
	JUMP	?CND30
?ELS45:	GRTR?	SCORE,240 \?ELS49
	PRINTI	"Adventurer"
	JUMP	?CND30
?ELS49:	GRTR?	SCORE,160 \?ELS53
	PRINTI	"Junior Adventurer"
	JUMP	?CND30
?ELS53:	GRTR?	SCORE,80 \?ELS57
	PRINTI	"Novice Adventurer"
	JUMP	?CND30
?ELS57:	GRTR?	SCORE,40 \?ELS61
	PRINTI	"Amateur Adventurer"
	JUMP	?CND30
?ELS61:	PRINTI	"Beginner"
?CND30:	PRINTI	"."
	CRLF	
	RETURN	SCORE


	.FUNCT	JIGS-UP,DESC=0,PLAYER?=0
	ZERO?	DESC /?CND1
	PRINT	DESC
	CRLF	
?CND1:	EQUAL?	ADVENTURER,WINNER /?CND7
	PRINTI	" 
    ****  The "
	PRINTD	WINNER
	PRINTI	" has died  **** 

"
	REMOVE	WINNER
	SET	'WINNER,ADVENTURER
	LOC	WINNER >HERE
	RETURN	2
?CND7:	CALL	SCORE-UPD,-10
	PRINTI	" 
    ****  You have died  **** 

"
	SET	'DEAD,TRUE-VALUE
	SET	'SPELL?,FALSE-VALUE
	PUTP	ADVENTURER,P?ACTION,0
	INC	'DEATHS
	MOVE	WINNER,HERE
	PRINTI	"Now, let's take a look here... Well, you probably deserve another chance. I can't quite fix you up completely, but you can't have everything."
	CRLF	
	CRLF	
	FCLEAR	DEAD-PALANTIR-1,TOUCHBIT
	FCLEAR	DEAD-PALANTIR-2,TOUCHBIT
	FCLEAR	DEAD-PALANTIR-3,TOUCHBIT
	CALL	RANDOMIZE-OBJECTS
	CALL	GOTO,DEAD-PALANTIR-1
	SET	'P-CONT,FALSE-VALUE
	CALL	KILL-INTERRUPTS
	RETURN	2


	.FUNCT	RANDOMIZE-OBJECTS,R=0,F,N,L
	IN?	LAMP,WINNER \?CND1
	MOVE	LAMP,INSIDE-BARROW
?CND1:	FIRST?	WINNER >N /?KLU24
?KLU24:	
?PRG4:	SET	'F,N
	ZERO?	F /TRUE
	NEXT?	F >N /?KLU25
?KLU25:	EQUAL?	F,BILLS,PORTRAIT \?ELS11
	EQUAL?	HERE,VAULT,DEPOSITORY,OFFICE /?THN14
	EQUAL?	HERE,SMALL-ROOM \?ELS11
?THN14:	MOVE	F,HERE
	JUMP	?PRG4
?ELS11:	EQUAL?	F,GOLD-KEY /?THN18
	EQUAL?	F,CANDY /?THN18
	EQUAL?	F,PALANTIR-1 /?THN18
	EQUAL?	F,PALANTIR-2 /?THN18
	EQUAL?	F,PALANTIR-3 \?ELS17
?THN18:	MOVE	F,CAROUSEL-ROOM
	JUMP	?PRG4
?ELS17:	FSET?	F,STAGGERED \?ELS21
	MOVE	F,WIZARD-CASE
	JUMP	?PRG4
?ELS21:	MOVE	F,GAZEBO-ROOM
	JUMP	?PRG4


	.FUNCT	KILL-INTERRUPTS
	CALL	INT,I-GNOME
	PUT	STACK,0,0
	CALL	INT,I-LEDGE
	PUT	STACK,0,0
	CALL	INT,I-NERVOUS
	PUT	STACK,0,0
	CALL	INT,I-ZGNOME-OUT
	PUT	STACK,0,0
	CALL	INT,I-ZGNOME
	PUT	STACK,0,0
	CALL	DRAGON-LEAVES
	CALL	INT,I-MATCH
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	FIND-WEAPON,O,W
	FIRST?	O >W /?KLU11
?KLU11:	ZERO?	W /FALSE
?PRG4:	EQUAL?	W,SWORD \?ELS8
	RETURN	W
?ELS8:	NEXT?	W >W /?PRG4
	RFALSE	


	.FUNCT	BUCKET-CONT
	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	WINNER,BUCKET /FALSE
	PRINTR	"You'll need to get in the bucket to reach it."

	.ENDI
