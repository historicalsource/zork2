

	.FUNCT	NOT-HERE-OBJECT-F,TBL,PRSO?=1,OBJ
	EQUAL?	PRSO,NOT-HERE-OBJECT \?ELS3
	EQUAL?	PRSI,NOT-HERE-OBJECT \?ELS3
	PRINTR	"Those things aren't here!"
?ELS3:	EQUAL?	PRSO,NOT-HERE-OBJECT \?ELS9
	SET	'TBL,P-PRSO
	JUMP	?CND1
?ELS9:	SET	'TBL,P-PRSI
	SET	'PRSO?,FALSE-VALUE
?CND1:	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	EQUAL?	WINNER,PLAYER \?ELS14
	PRINTI	"You can't see any "
	CALL	NOT-HERE-PRINT,PRSO?
	PRINTR	" here!"
?ELS14:	PRINTI	"The "
	PRINTD	WINNER
	PRINTI	" seems confused. ""I don't see any "
	CALL	NOT-HERE-PRINT,PRSO?
	PRINTR	" here!"""


	.FUNCT	NOT-HERE-PRINT,PRSO?,?TMP1
	ZERO?	P-OFLAG /?ELS5
	ZERO?	P-XADJ /?CND7
	PRINTB	P-XADJN
?CND7:	ZERO?	P-XNAM /FALSE
	PRINTB	P-XNAM
	RTRUE	
?ELS5:	ZERO?	PRSO? /?ELS18
	GET	P-ITBL,P-NC1 >?TMP1
	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	
?ELS18:	GET	P-ITBL,P-NC2 >?TMP1
	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	NULL-F,A1,A2
	RFALSE	


	.FUNCT	STAIRS-F
	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"You should say whether you want to go up or down."


	.FUNCT	SAILOR-FCN
	EQUAL?	PRSA,V?TELL \?ELS5
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"You can't talk to the sailor that way."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTR	"There is no sailor to be seen."
?ELS9:	EQUAL?	PRSA,V?HELLO \FALSE
	INC	'HS
	MOD	HS,20
	ZERO?	STACK \?ELS18
	PRINTR	"You seem to be repeating yourself."
?ELS18:	MOD	HS,10
	ZERO?	STACK \?ELS22
	PRINTR	"I think that phrase is getting a bit worn out."
?ELS22:	PRINTR	"Nothing happens here."


	.FUNCT	GROUND-FUNCTION
	EQUAL?	PRSA,V?PUT-ON,V?PUT \?ELS5
	EQUAL?	PRSI,GROUND \?ELS5
	CALL	PERFORM,V?DROP,PRSO
	RTRUE	
?ELS5:	CALL	NULL-F
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?DIG \FALSE
	PRINTR	"The ground is too hard for digging here."


	.FUNCT	GRUE-FUNCTION
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The grue is a sinister, lurking presence in the dark places of the earth. Its favorite diet is adventurers, but its insatiable appetite is tempered by its fear of light. No grue has ever been seen by the light of day, and few have survived its fearsome jaws to tell the tale."
?ELS5:	EQUAL?	PRSA,V?FIND \?ELS9
	PRINTR	"There is no grue here, but I'm sure there is at least one lurking in the darkness nearby. I wouldn't let my light go out if I were you!"
?ELS9:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"It makes no sound but is always lurking in the darkness nearby."


	.FUNCT	CRETIN-FCN
	EQUAL?	PRSA,V?TELL \?ELS5
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	PRINTR	"Talking to yourself is said to be a sign of impending mental collapse."
?ELS5:	EQUAL?	PRSA,V?GIVE \?ELS9
	EQUAL?	PRSI,ME \?ELS9
	CALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?MAKE \?ELS13
	PRINTR	"Only you can do that."
?ELS13:	EQUAL?	PRSA,V?DISEMBARK \?ELS17
	PRINTR	"You'll have to do that on your own."
?ELS17:	EQUAL?	PRSA,V?EAT \?ELS21
	PRINTR	"Auto-cannibalism is not the answer."
?ELS21:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?ELS25
	ZERO?	PRSI /?ELS30
	FSET?	PRSI,WEAPONBIT \?ELS30
	CALL	JIGS-UP,STR?167
	RSTACK	
?ELS30:	PRINTR	"Suicide is not the answer."
?ELS25:	EQUAL?	PRSA,V?THROW \?ELS38
	EQUAL?	PRSO,ME \FALSE
	PRINTR	"Why don't you just walk like normal people?"
?ELS38:	EQUAL?	PRSA,V?TAKE \?ELS47
	PRINTR	"How romantic!"
?ELS47:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	NULL-F
	ZERO?	STACK \TRUE
	PRINTR	"That's difficult unless your eyes are prehensile."


	.FUNCT	PATH-OBJECT
	EQUAL?	PRSA,V?FOLLOW,V?TAKE \?ELS5
	PRINTR	"You must specify a direction to go."
?ELS5:	EQUAL?	PRSA,V?FIND \?ELS9
	PRINTR	"I can't help you there...."
?ELS9:	EQUAL?	PRSA,V?DIG \FALSE
	PRINTR	"Not a chance."


	.FUNCT	ZORKMID-FUNCTION
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The zorkmid is the unit of currency of the Great Underground Empire."
?ELS5:	EQUAL?	PRSA,V?FIND \FALSE
	PRINTR	"The best way to find zorkmids is to go out and look for them."

	.ENDI
