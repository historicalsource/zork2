"ACTIONS2 for
		      Zork II: The Wizard of Frobozz
	(c) Copyright 1981, 1983 Infocom, Inc.  All Rights Reserved."

<ROUTINE SWORD-FCN ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<RFALSE>)>>

"SWORD demon"

<GLOBAL SWORD-GLOW 0>

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) G P TX L)
	 <SET G ,SWORD-GLOW>
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET TX <GETPT ,HERE .P>>
				      <SET L <PTSIZE .TX>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .TX 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Your sword has begun to glow very brightly." CR>)
		      (<1? .NG>
		       <TELL "Your sword is glowing with a faint blue glow."
			     CR>)
		      (<0? .NG>
		       <TELL "Your sword is no longer glowing." CR>)>
		<SETG SWORD-GLOW .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT>
			     <NOT <FSET? .F ,INVISIBLE>>
			     <NOT <EQUAL? .F ,ROBOT>>>
			<RETURN .F>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

<ROUTINE CAROUSEL-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a large circular room whose high ceiling is lost in gloom. Eight
identical passages leave the room." CR>
		<COND (<NOT ,CAROUSEL-FLIP-FLAG>
		       <TELL
"A loud whirring sound comes from all around, and you feel
sort of disoriented in here." CR>)>
		<RTRUE>)
	       (<AND <NOT ,CAROUSEL-FLIP-FLAG>
		     <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>>
		<COND (<EQUAL? ,PRSO ,P?UP ,P?DOWN>
		       <RFALSE>)>
		<COND (<EQUAL? ,PRSO ,P?OUT>
		       <TELL
"Feeling dizzy, you pick a direction at random." CR CR>
		       <SETG PRSO ,P?EAST>)
		      (T
		       <TELL
"You're not sure which direction is which. This
room is very disorienting." CR CR>)>
		<COND (<OR <EQUAL? ,PRSO ,P?WEST> <PROB 80>>
		       <SETG PRSO <GET ,EIGHT-DIRECTIONS <- <RANDOM 7> 1>>>)>
		<V-WALK>
		<RTRUE>)>>

<ROUTINE VIOLIN-FCN ()
	 <COND (<AND <VERB? PLAY>
		     <EQUAL? ,PRSO ,VIOLIN>>
	        <TELL
"An amazingly offensive noise issues from the violin." CR>)>>

<GLOBAL EIGHT-DIRECTIONS
	<TABLE P?NORTH P?EAST P?SOUTH P?NE P?SE P?SW P?NW>>

<GLOBAL MUNGED-ROOM <>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 #DECL ((OBJ) OBJECT (STROPN STRCLS) STRING)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <RANDOM-ELEMENT ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <RANDOM-ELEMENT ,DUMMY> CR>)>
		<CRLF>)>>

;"SUBTITLE THE VOLCANO"

<GLOBAL BTIE-FLAG <>>
<GLOBAL BINF-FLAG <>>
<GLOBAL BLAB-FLAG <>>
<GLOBAL SAFE-FLAG <>>

<ROUTINE BALLOON-FCN ("OPTIONAL" (RARG <>) "AUX" M R RC)
	 #DECL ((RARG) <OR FIX FALSE> (M) <OR FALSE TABLE> (R) OBJECT)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,BINF-FLAG
		       <TELL "The cloth bag is inflated and ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL
"there is a " D ,BINF-FLAG " burning in the receptacle.">)
			     (T
			      <TELL
"some smoke is leaking out of the closed receptacle.">)>)
		      (T
		       <TELL "The cloth bag is draped over the side
of the basket. Directly in the middle of the basket is a metal receptacle
which is ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL "open">
			      <SET RC <FIRST? ,RECEPTACLE>>
			      <COND (.RC
				     <TELL ". A "
					   D .RC
					   " is "
					   <COND (<EQUAL? ,BINF-FLAG .RC>
						  "burning")
						 (T
						  "nestled")>
					   " inside">)>)
			     (T <TELL "closed">)>
		       <TELL ".">)>
		<COND (,BTIE-FLAG
		       <TELL
" The balloon is tied to a hook by the braided wire." CR>)
		      (T
		       <TELL
" A braided wire is dangling over the side of the basket." CR>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"There is a large and extremely heavy wicker basket here. An
enormous cloth bag ">
		<COND (,BINF-FLAG
		       <TELL
"attached to the basket is inflated. A metal receptacle is fastened to
the center of the basket. ">
		       <COND (<FSET? ,RECEPTACLE ,OPENBIT>
			      <TELL "In it is a burning " D ,BINF-FLAG>)
			     (T
			      <TELL
"Some smoke leaks out around its closed lid">)>)
		      (T
		       <TELL
"is draped over the side and is firmly attached to the basket. A metal
receptacle is fastened to the center of the basket">)>
		<COND (,BTIE-FLAG
		       <TELL
". A piece of wire tied to a hook holds the balloon in place." CR>)
		      (T
		       <TELL
". Dangling from the basket is a piece of braided wire." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<SET M <GETPT ,HERE ,PRSO>>
			      <COND (,BTIE-FLAG
				     <TELL "You are tied to the ledge." CR>
				     <RTRUE>)
				    (T
				     <AND <EQUAL? <PTSIZE .M> 1>
					  <NOT <FSET? <SET R <GETB .M 0>>
						      ,RMUNGBIT>>
					  <SETG BLOC .R>>
				     <ENABLE <QUEUE I-BALLOON 3>>
				     <RFALSE>)>)
			     (T
			      <TELL
"You can't control the balloon this way." CR>
			      <RTRUE>)>)
		      (<AND <VERB? OPEN>
			    ,BINF-FLAG
			    <EQUAL? ,PRSO ,RECEPTACLE>
			    <FIRST? ,RECEPTACLE>>
		       <TELL "Opening it reveals a burning "
			     D ,BINF-FLAG "." CR>
		       <FSET ,RECEPTACLE ,OPENBIT>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <EQUAL? ,BINF-FLAG ,PRSO>>
		       <TELL "You don't really want to hold a burning "
			     D ,PRSO "." CR>
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,RECEPTACLE>
			    <FIRST? ,RECEPTACLE>>
		       <TELL "The receptacle is already occupied." CR>
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,RECEPTACLE>>
		       <FSET ,PRSO ,NDESCBIT>
		       <RFALSE>)
		      (<VERB? INFLATE>
		       <TELL
"It takes more than words to inflate a balloon." CR>)>)>>

<ROUTINE I-BALLOON ()
	 <COND (<AND <FSET? ,RECEPTACLE ,OPENBIT> ,BINF-FLAG>
		<RISE-AND-SHINE>)
	       (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2>
		<RISE-AND-SHINE>)
	       (T
		<DECLINE-AND-FALL>)>>

<ROUTINE BALLOON-BURN ()
 	<TELL "The " D ,PRSO " burns inside the receptacle." CR>
	<ENABLE <QUEUE I-BURNUP <* <GETP ,PRSO ,P?SIZE> 20>>>
	<FSET ,PRSO ,FLAMEBIT>
	<FSET ,PRSO ,ONBIT>
	<FCLEAR ,PRSO ,TAKEBIT>
	<FCLEAR ,PRSO ,READBIT>
	<COND (,BINF-FLAG <RTRUE>)
	      (T
	       <TELL
		"The cloth bag inflates as it fills with hot air." CR>
	       <COND (<NOT ,BLAB-FLAG>
		      <TELL
"A small label drops from the bag into the basket." CR>
		      <MOVE ,BALLOON-LABEL ,BALLOON>)>
	       <SETG BLAB-FLAG T>
	       <SETG BINF-FLAG ,PRSO>
	       <ENABLE <QUEUE I-BALLOON 3>>)>>

<ROUTINE PUT-BALLOON (THERE STR)
	#DECL ((THERE) OBJECT (STR) STRING)
	<COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
	       <TELL "You watch as the balloon slowly " .STR CR>)>
	<MOVE ,BALLOON .THERE>
	<SETG BLOC .THERE>>

<GLOBAL BALLOON-UPS
	<LTABLE VAIR-1 VAIR-2 VAIR-3 VAIR-4>>

<GLOBAL BALLOON-FLOATS
	<LTABLE LEDGE-1 VAIR-2 LEDGE-2 VAIR-4>>

<GLOBAL BALLOON-DOWNS
	<LTABLE VAIR-4 VAIR-3 VAIR-2 VAIR-1>>

<ROUTINE RISE-AND-SHINE ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)
	#DECL ((IN) <OR ATOM FALSE> (R) <OR FALSE OBJECT>)
	<ENABLE <QUEUE I-BALLOON 3>>
	<COND (<EQUAL? ,BLOC ,VAIR-4>
	       <DISABLE <INT I-BURNUP>>
	       <DISABLE <INT I-BALLOON>>
	       <REMOVE ,BALLOON>
	       <COND (.IN
		      <JIGS-UP
"The balloon floats majestically out of the volcano, revealing a
breathtaking view of a wooded river valley surrounded by impassable
mountains. In a clearing stands a white house. You drift into high winds,
which carry you towards the snow-capped peaks. Oh, no! You crash into the
jagged cliffs of the Flathead Mountains!">)
		     (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2 ,VOLCANO-BOTTOM>
		      <TELL
"You watch the balloon drift out over the rim and away on the wind." CR>)>
	       <SETG BLOC ,VOLCANO-BOTTOM>)
	      (<SET R <LKP ,BLOC ,BALLOON-UPS>>
	       <COND (.IN
		      <TELL "The balloon ascends." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <PUT-BALLOON .R "ascends.">)>)
	      (<SET R <LKP ,BLOC ,BALLOON-FLOATS>>
	       <COND (.IN
		      <TELL "The balloon leaves the ledge." CR CR>
		      <SETG BLOC .R>
		      <GOTO .R>)
		     (T
		      <ENABLE <QUEUE I-GNOME 10>>
		      <PUT-BALLOON .R
"floats away. It seems to be ascending, due to its light load.">
		      <FSET ,RECEPTACLE ,OPENBIT>)>)
	      (.IN
	       <SETG BLOC ,VAIR-1>
	       <TELL "The balloon rises slowly from the ground." CR CR>
	       <GOTO ,VAIR-1>)
	      (T
	       <PUT-BALLOON ,VAIR-1 "lifts off.">)>>

<ROUTINE DECLINE-AND-FALL ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)
    #DECL ((IN) <OR ATOM FALSE> (R) <OR FALSE OBJECT>)
    <ENABLE <QUEUE I-BALLOON 3>>
    <COND (<EQUAL? ,BLOC ,VAIR-1>
	   <COND (.IN
		  <SETG BLOC ,VOLCANO-BOTTOM>
		  <COND (,BINF-FLAG
			 <TELL "The balloon has landed." CR CR>
			 <GOTO ,VOLCANO-BOTTOM>
			 ;<QUEUE I-BALLOON 0>)
			(T
			 <REMOVE ,BALLOON>
			 <MOVE ,DEAD-BALLOON ,BLOC>
			 <MOVE ,WINNER ,HERE>
			 <DISABLE <INT I-BALLOON>>
			 <TELL
			  "You have landed, but the balloon did not survive."
			  CR CR>
			 <GOTO ,VOLCANO-BOTTOM>)>)
		 (T <PUT-BALLOON ,VOLCANO-BOTTOM "lands.">)>)
	   (<SET R <LKP ,BLOC ,BALLOON-DOWNS>>
	    <COND (.IN
		   <TELL "The balloon descends." CR CR>
		   <SETG BLOC .R>
		   <GOTO .R>)
		  (T <PUT-BALLOON .R "descends.">)>)>>

<ROUTINE BCONTENTS ()
	 <COND (<VERB? TAKE>
		<TELL
"The " D ,PRSO " is an integral part of the basket and cannot
be removed.">
		<COND (<EQUAL? ,PRSO ,BRAIDED-WIRE>
		       <TELL " The wire might possibly be tied, though.">)>
		<CRLF>)
	       (<AND <EQUAL? ,PRSO ,CLOTH-BAG>
		     <VERB? LOOK-INSIDE OPEN>>
		<COND (<VERB? OPEN>
		       <TELL
"The bag is enormous. The concept of opening it here is ludicrous." CR>)
		      (T
		       <TELL
"It doesn't appear that there's anything inside." CR>)>)
	       (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,RECEPTACLE>>
		<TELL "The receptacle is ">
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "open." CR>)
		      (T <TELL "closed." CR>)>)
	       (<VERB? FIND EXAMINE>
	        <TELL
"The " D ,PRSO " is part of the basket. It may be manipulated
within the basket but cannot be removed." CR>)>>

<ROUTINE WIRE-FCN ()
        <COND (<VERB? TAKE FIND EXAMINE>
	       <BCONTENTS>)
	      (<VERB? TIE>
	       <COND (<AND <EQUAL? ,PRSO ,BRAIDED-WIRE>
			   <EQUAL? ,PRSI ,HOOK-1 ,HOOK-2>>
		      <SETG BTIE-FLAG ,PRSI>
		      <FSET ,PRSI ,NDESCBIT>
		      <DISABLE <INT I-BALLOON>>
		      <TELL "The balloon is fastened to the hook." CR>)>)
	      (<AND <VERB? UNTIE>
	            <EQUAL? ,PRSO ,BRAIDED-WIRE>>
	       <COND (,BTIE-FLAG
		      <ENABLE <QUEUE I-BALLOON 3>>
	       	      <FCLEAR ,BTIE-FLAG ,NDESCBIT>
		      <SETG BTIE-FLAG <>>
	              <TELL "The wire falls off of the hook." CR>)
		     (T <TELL "The wire is not tied to anything." CR>)>)>>

<ROUTINE I-BURNUP ("AUX" (OBJ <FIRST? ,RECEPTACLE>))
    #DECL ((OBJ) OBJECT)
    <COND (<EQUAL? ,HERE ,BLOC>
	   <TELL
"The " D .OBJ " has now burned out, and the cloth bag starts to deflate." CR>)>
    <REMOVE .OBJ>
    <SETG BINF-FLAG <>>
    T>

<ROUTINE SAFE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a dusty old room which is featureless, except
for an exit on the north side." CR>
		<COND (<NOT ,SAFE-FLAG>
		       <TELL
"Imbedded in the far wall is a rusty box. It appears to be somewhat
damaged, since an oblong hole has been chipped out of the front of it." CR>)
		      (T
		       <TELL
"On the far wall is a rusty box, whose door has been blown off." CR>)>)>>

<ROUTINE SAFE-FCN ()
	<COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,SAFE>>
	       <TELL "The box is imbedded in the wall." CR>)
	      (<VERB? OPEN>
	       <COND (,SAFE-FLAG <TELL "The box has no door!" CR>)
		     (T <TELL "The box is rusted and will not open." CR>)>)
	      (<VERB? CLOSE>
	       <COND (,SAFE-FLAG <TELL "The box has no door!" CR>)
		     (T <TELL "The box isn't open!" CR>)>)>>

<ROUTINE BRICK-FCN ()
	 <COND (<VERB? BURN>
		<REMOVE ,BRICK>
		<JIGS-UP ,OTHER-PROPERTIES>)>>

<GLOBAL OTHER-PROPERTIES
"Now you've done it. It seems that the brick has other properties
than weight, namely the ability to blow you to smithereens.">

<ROUTINE FUSE-FCN ()
	<COND (<OR <VERB? BURN>
		   <AND <VERB? LAMP-ON>
			<IN? ,MATCH ,WINNER>
			<FSET? ,MATCH ,ONBIT>>>
	       <TELL "The string starts to burn." CR>
	       <ENABLE <QUEUE I-FUSE 2>>)>>

<ROUTINE I-FUSE ("AUX" (BRICK-ROOM <LOC ,BRICK>) F)
	 <COND (<IN? ,FUSE ,BRICK>
		<REPEAT ()
			<COND (<NOT .BRICK-ROOM> <RFALSE>)
			      (<IN? .BRICK-ROOM ,ROOMS>
			       <RETURN>)
			      (T
			       <SET BRICK-ROOM <LOC .BRICK-ROOM>>)>>
		<MOVE ,EXPLOSION .BRICK-ROOM>
		<FCLEAR .BRICK-ROOM ,TOUCHBIT>
		<COND (<EQUAL? .BRICK-ROOM ,HERE>
		       <MUNG-ROOM .BRICK-ROOM
			  "The way is blocked by debris from an explosion.">
		       <JIGS-UP ,OTHER-PROPERTIES>)
		      (<EQUAL? .BRICK-ROOM ,SAFE-ROOM>
		       <ENABLE <QUEUE I-SAFE 5>>
		       <SETG MUNGED-ROOM ,SAFE-ROOM>
		       <TELL "There is an explosion nearby." CR>
		       <COND (<IN? ,BRICK ,SLOT>
			      <FSET ,SLOT ,INVISIBLE>
			      <FSET ,SAFE ,OPENBIT>
			      <FCLEAR ,SAFE-ROOM ,TOUCHBIT>
			      <SETG SAFE-FLAG T>)>)
		      (T
		       <TELL "There is an explosion nearby." CR>
		       <ENABLE <QUEUE I-SAFE 5>>
		       <SETG MUNGED-ROOM .BRICK-ROOM>
		       <COND (<SET F <FIRST? .BRICK-ROOM>>
			      <REPEAT ()
				      <COND (<FSET? .F ,TAKEBIT>
					     <FSET .F ,INVISIBLE>)>
				      <COND (<NOT <SET F <NEXT? .F>>>
					     <RETURN>)>>)>)>
		<REMOVE ,BRICK>)
	       (<EQUAL? <LOC ,FUSE> ,WINNER ,HERE>
		<TELL "The string rapidly burns into nothingness." CR>)>
	 <REMOVE ,FUSE>>

<ROUTINE I-SAFE ()
	<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
	       <JIGS-UP
"The room trembles and 5000 tons of rock fall on you, turning you
into a pancake.">)
	      (<NOT ,DEAD>
	       <TELL
"You may recall that recent explosion. Probably as a result of it, you
hear an ominous rumbling, as if a nearby room had collapsed." CR>
	       <COND (<EQUAL? ,MUNGED-ROOM ,SAFE-ROOM>
		      <ENABLE <QUEUE I-LEDGE 8>>)>)>
	<MUNG-ROOM ,MUNGED-ROOM
		   "The way is blocked by debris from an explosion.">>

<ROUTINE I-LEDGE ("AUX" (RM ,LEDGE-2))
    <COND (<EQUAL? ,HERE ,LEDGE-2>
	   <COND (<IN? ,WINNER ,BALLOON>
		  <COND (,BTIE-FLAG
			 <SETG BLOC ,VOLCANO-BOTTOM>
			 <REMOVE ,BALLOON>
			 <MOVE ,DEAD-BALLOON ,VOLCANO-BOTTOM>
			 <SETG BTIE-FLAG <>>
			 <SETG BINF-FLAG <>>
			 <DISABLE <INT I-BALLOON>>
			 <DISABLE <INT I-BURNUP>>
			 <JIGS-UP
"The ledge collapses, probably as a result of the explosion, and plummets
to the ground far below. Sadly, you were still attached to the ledge.">)
			(T
			 <TELL
"The ledge collapses, leaving you with no place to land." CR>)>)
		 (T
		  <JIGS-UP
"The force of the recent explosion has caused the ledge to collapse.">)>)
	  (<NOT ,DEAD>
	   <TELL "The ledge collapses. (That was a narrow escape!)" CR>)>
    <MUNG-ROOM .RM "The ledge has collapsed and cannot be landed on.">>

<ROUTINE LEDGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"You are on a wide ledge high in the volcano. The rim of the volcano is
about 200 feet above and there is a precipitous drop to the bottom.">
	   <COND (<FSET? ,SAFE-ROOM ,RMUNGBIT>
		  <TELL " The way to the south is blocked by rubble." CR>)
		 (T <TELL " There is a small door to the south." CR>)>)>>

;<ROUTINE BLAST () ;"APPARENTLY UNUSED?"
    <COND (<EQUAL? ,HERE ,SAFE-ROOM>)
	  (T
	   <TELL "You must explain how to do that." CR>)>>

<ROUTINE I-GNOME ()
    <COND (<EQUAL? ,HERE ,LEDGE-1 ,LEDGE-2>
	   <TELL
"A volcano gnome seems to walk straight out of the wall and ">
	   <COND (<IN? ,WAND ,WINNER>
		  <TELL
"noticing the wand, straight back in." CR>)
		 (T
		  <TELL
"says
\"I have a busy appointment schedule and little time to waste on
trespassers, but for a small fee I'll show you the way out.\" You
notice the gnome nervously glancing at his watch." CR>
		  <MOVE ,GNOME ,HERE>)>)
	  (T
	   <ENABLE <QUEUE I-GNOME 1>>
	   <RFALSE>)>>

<GLOBAL GNOME-FLAG <>>

<ROUTINE GNOME-FCN ()
    <COND (<VERB? TELL>
	   <SETG P-CONT <>>
	   <SETG QUOTE-FLAG <>>
	   <COND (<NOT ,GNOME-FLAG>
		  <ENABLE <QUEUE I-NERVOUS 5>>)>
	   <SETG GNOME-FLAG T>
	   <TELL
"The gnome appears increasingly nervous." CR>)
	  (<AND <VERB? GIVE THROW> <EQUAL? ,PRSI ,GNOME>>
	   <COND (<GETPT ,PRSO ,P?VALUE>
		  <TELL
"\"Thank you very much for the " D ,PRSO ". I don't believe
I've ever seen one as beautiful. Follow me,\" he says, and a door
appears on the west end of the ledge. Through the door, you can see
a narrow chimney sloping steeply downward. The gnome moves quickly,
and disappears from sight." CR>
		  <REMOVE ,PRSO>
		  <REMOVE ,GNOME>
		  <SETG GNOME-DOOR-FLAG T>)
		 (<BOMB? ,PRSO>
		  <MOVE ,BRICK ,HERE>
		  <REMOVE ,GNOME>
		  <DISABLE <INT I-GNOME>>
		  <DISABLE <INT I-NERVOUS>>
		  <TELL
"\"That certainly wasn't what I had in mind,\" he says, and disappears." CR>)
		 (T
		  <REMOVE-CAREFULLY ,PRSO>
		  <TELL
"\"That wasn't quite what I had in mind,\" he says, crunching the
" D ,PRSO " in his rock-hard hands." CR>)>)
	  (T
	   <TELL
"The gnome appears increasingly nervous." CR>
	   <COND (<NOT ,GNOME-FLAG>
		  <ENABLE <QUEUE I-NERVOUS 5>>)>
	   <SETG GNOME-FLAG T>)>>

<ROUTINE I-NERVOUS ()
	 <COND (<IN? ,GNOME ,HERE>
		<TELL
"The gnome glances at his watch. \"Oops. I'm late for an
appointment!\" He disappears, leaving you alone on the ledge." CR>)>
	 <REMOVE ,GNOME>>

<ROUTINE PURPLE-BOOK-FCN ()
	 <COND (<AND <VERB? READ>
		     <IN? ,STAMP ,PURPLE-BOOK>
		     <NOT <FSET? ,PURPLE-BOOK ,OPENBIT>>>
		<TELL <GETP ,PURPLE-BOOK ,P?TEXT> CR>
		<PERFORM ,V?OPEN ,PURPLE-BOOK>
		<RTRUE>)
	       (T <RANDOM-BOOK>)>>

<ROUTINE RANDOM-BOOK ()
	 <COND (<VERB? TAKE MOVE PUT>
		<FSET ,WHITE-BOOK ,TOUCHBIT>
		<FSET ,PURPLE-BOOK ,TOUCHBIT>
		<FSET ,GREEN-BOOK ,TOUCHBIT>
		<FSET ,BLUE-BOOK ,TOUCHBIT>
		<RFALSE>)>>

; "SUBTITLE TOMB OF THE FLATHEADS"

<ROUTINE HEAD-FCN ()
  <COND (<VERB? HELLO>
	 <TELL "The Flatheads are dead; therefore they do not respond." CR>)
	(<VERB? KICK ATTACK RUB OPEN TAKE BURN>
	 <JIGS-UP
"Although the Flatheads are dead, they foresaw that some cretin
might tamper with their remains. Therefore, they took steps to
punish such actions.">)>>

<ROUTINE CRYPT-ANTEROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The anteroom is large and empty. Marble bas reliefs depict the stirring
times and afterlife of the Flatheads (the latter a bit optimistically).
The exit is to the west. A huge marble door stands to the south. ">
		<TELL "The door is ">
		<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
		       <TELL "open.">)
		      (T <TELL "closed.">)>
		<TELL
" Above the door is the cryptic inscription: \"Feel Free\"." CR>)>>

<ROUTINE CRYPT-ROOM-FCN (RARG "AUX" CLIT?)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<FCLEAR ,HERE ,ONBIT>
		<COND (<LIT? ,HERE>
		       <TELL
"The room contains the earthly remains of the mighty Flatheads, twelve
somewhat flat heads mounted securely on poles. While the room might be
expected to contain funerary urns or other evidence of the ritual
practices of the ancient Zorkers, it is empty of all such objects. There
is writing carved on the crypt. The only apparent exit is to the north
through the door to the anteroom. The door is ">
		       <COND (<FSET? ,CRYPT-DOOR ,OPENBIT>
			      <TELL "open.">)
			     (T <TELL "closed.">)>
		       <CRLF>
		       <COND (<NOT <FSET? ,DIM-DOOR ,INVISIBLE>>
			      <TELL
"Looking closely at the south wall, you can see the dim outline of
a secret door labelled with the letter \"F\"." CR>)>)
		      (T
		       <DIM-DOOR-APPEARS>)>
		<FSET ,HERE ,ONBIT>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-END>
		<SET CLIT? ,CRYPT-LIT?>
		<FCLEAR ,CRYPT-ROOM ,ONBIT>
		<SETG CRYPT-LIT? <LIT? ,CRYPT-ROOM>>
		<COND (<AND .CLIT?
			    <NOT ,CRYPT-LIT?>>
		       <DIM-DOOR-APPEARS>)>
		<FSET ,CRYPT-ROOM ,ONBIT>)>>

<GLOBAL CRYPT-LIT? T>

<ROUTINE DIM-DOOR-APPEARS ()
	 <TELL
"It is dark, but on the south wall is a faint outline of a rectangle, as
though light were shining around a doorway. You can also make out a faintly
glowing letter in the center of this area. It might be an \"F\"." CR>
	 <FCLEAR ,DIM-DOOR ,INVISIBLE>>

<ROUTINE CRYPT-OBJECT ()
	 <COND (<VERB? OPEN> <TELL "The crypt is sealed for all time." CR>)
	       (<VERB? RUB> <TELL "The marble is cool." CR>)>>

<ROUTINE CRYPT-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<OPEN-CLOSE ,PRSO
			    "The crypt door squeaks open."
			    "The crypt door squeaks closed.">)>>

<ROUTINE TOMB-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?EAST>
		T)>>

<GLOBAL DIM-DOOR-FLAG <>>

<ROUTINE DIM-DOOR-FCN ()
	 <COND (<VERB? KNOCK> <TELL "A hollow echo responds." CR>)
	       (<VERB? OPEN CLOSE>
		<COND (<VERB? OPEN> <SETG DIM-DOOR-FLAG T>)
		      (T <SETG DIM-DOOR-FLAG <>>)>
		<OPEN-CLOSE ,PRSO
			    "The secret door opens noiselessly."
			    "The secret door closes noiselessly.">)>>

<ROUTINE REPELLENT-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED? <TELL "The can seems empty." CR>)
		      (T <TELL "There is a sloshing sound from inside." CR>)>)
	       (<AND <VERB? SPRAY PUT> <EQUAL? ,PRSO ,REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL
"The repellent is all gone." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray stinks amazingly for a few moments, then drifts away." CR>)
		      (T
		       <COND (<EQUAL? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 8>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray smells like a mixture of old socks and burning rubber. If
I were a grue I'd sure stay clear!" CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL "That horrible smell is much less pungent now." CR>>

<ROUTINE ZORK3-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Beyond the door is a roughly hewn staircase leading down into darkness.
The landing on which you stand is covered with carefully drawn magical runes
like those sketched upon the workbench of the Wizard of Frobozz.
These have been overlaid with sweeping green lines of enormous power, which
undulate back and forth across the landing. ">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
"The wand begins to vibrate in harmony with the motion of the lines.
You feel yourself compelled downward, and you yield, stepping onto the
staircase. As you pass the green lines, they flare and disappear with a
burst of light, and you tumble down the staircase!|
|
At the bottom, a vast red-lit hall stretches off into the distance.
Sinister statues guard the entrance to a dimly visible room far ahead.
With courage and cunning you have conquered the Wizard of Frobozz and
become the master of his domain, but the final challenge awaits!|
|
(The ultimate adventure concludes in \"Zork III: The Dungeon Master\".)|
|
" CR>
		<SETG WON-FLAG T>
		<FINISH>)
		      (T
		       <JIGS-UP
"The green curves begin to vibrate toward you, as if searching for
something. One by one your possessions glow bright green. Finally, you
are attacked by these magical wardens, and destroyed!">)>)>>

\

;"SUBTITLE A DROP IN THE BUCKET"

<GLOBAL BUCKET-TOP-FLAG <>>

<GLOBAL EVAPORATED <>>

<ROUTINE I-BUCKET ()
	 <COND (<IN? ,WATER ,BUCKET>
		<SETG EVAPORATED T>
		<REMOVE ,WATER>)>
	 <RFALSE>>

<ROUTINE WATER-FCN ("AUX" AV W PI?)
	 #DECL ((AV) <OR OBJECT FALSE> (W) OBJECT (PI?) <OR ATOM FALSE>)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<EQUAL? ,PRSO ,GLOBAL-WATER ,WATER>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (,PRSI
		<SET W ,PRSI>
		<SET PI? T>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV <EQUAL? .AV ,PRSI>>
		       <PUDDLE .AV>)
		      (<AND .AV <NOT ,PRSI> <NOT <IN? .W .AV>>>
		       <PUDDLE .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,TEAPOT>>>
		       <TELL "The water leaks out of the " D ,PRSI
			     " and evaporates immediately." CR>
		       <REMOVE .W>)
		      (<IN? ,TEAPOT ,WINNER>
		       <COND (<NOT <FIRST? ,TEAPOT>>
			      <COND (<EQUAL? ,HERE ,POOL-ROOM>
				     <MOVE ,SALTY-WATER ,TEAPOT>)
				    (T 
				     <MOVE ,WATER ,TEAPOT>)>
			      <TELL "The teapot is now full of water." CR>)
			     (T
			      <TELL "The teapot isn't currently empty." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,TEAPOT>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <SETG PRSO ,TEAPOT>
		       <ITAKE>
		       <SETG PRSO .W>)
		      (T
		       <TELL "The water slips through your fingers." CR>)>)
	       (.PI? <TELL "Nice try." CR>)
	       (<VERB? DROP GIVE>
		<COND (<AND <EQUAL? ,PRSO ,WATER>
			    <NOT <HELD? ,WATER>>>
		       <TELL "You don't have any water." CR>
		       <RTRUE>)>
		<REMOVE ,WATER>
		<COND (.AV
		       <PUDDLE .AV>)
		      (T
		       <TELL
"The water spills to the floor and evaporates." CR>
		       <REMOVE ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"The water splashes on the walls and evaporates." CR>
		<REMOVE ,WATER>)>>

<ROUTINE PUDDLE (AV)
	<TELL "There is now a puddle in the bottom of the " D .AV "." CR>
	<MOVE ,PRSO .AV>>

<ROUTINE BUCKET-FCN ("OPTIONAL" (RARG ,M-BEG))
	<COND (<EQUAL? .RARG ,M-BEG>
	       <COND (<AND <VERB? BURN>
			   <EQUAL? ,PRSO ,BUCKET>>
		      <TELL
		       "The bucket is fireproof, and won't burn." CR>)
		     (<AND <VERB? DROP PUT>
			   <EQUAL? ,PRSO ,WATER>
			   <EQUAL? ,PRSI ,BUCKET>
			   <IN? ,BUCKET ,WELL-BOTTOM>
			   <NOT <IN? ,WINNER ,BUCKET>>>
		      <TELL "The bucket swiftly rises up, and is gone." CR>
		      <MOVE ,BUCKET ,WELL-TOP>
		      <MOVE ,WATER ,BUCKET>
		      <SETG BUCKET-TOP-FLAG T>
		      <ENABLE <QUEUE I-BUCKET 100>>
		      <RTRUE>)
		     (<VERB? KICK>
		      <JIGS-UP "If you insist.">)>)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<AND <IN? ,WATER ,BUCKET>
			   <NOT ,BUCKET-TOP-FLAG>>
		      <TELL "The bucket rises and comes to a stop." CR CR>
		      <SETG BUCKET-TOP-FLAG T>
		      <SETG EVAPORATED <>>
		      <PASS-THE-BUCKET ,WELL-TOP>
		      <ENABLE <QUEUE I-BUCKET 100>>
		      <RTRUE>)
		     (<AND ,BUCKET-TOP-FLAG
			   <NOT <IN? ,WATER ,BUCKET>>>
		      <COND (,EVAPORATED
			     <TELL
"The last of the water evaporates, and the bucket descends." CR CR>)
			    (T
			     <TELL
"The bucket descends and comes to a stop." CR CR>)>
		      <SETG BUCKET-TOP-FLAG <>>
		      <PASS-THE-BUCKET ,WELL-BOTTOM>)>)
	      (<VERB? CLIMB-ON>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)>>

<ROUTINE PASS-THE-BUCKET (R)
    #DECL ((R) OBJECT)
    <MOVE ,BUCKET .R>
    <COND (<IN? ,WINNER ,BUCKET>
	   <GOTO .R>)>>

\

;"SUBTITLE CHOMPERS IN WONDERLAND"

<ROUTINE POSTS-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE> <FSET? ,PRSO ,NONLANDBIT>>
		       <TELL
"The " D ,PRSO " is now much larger than you are. You have no hope of
taking it." CR>)>)>>

<ROUTINE EATME-FCN ("AUX" F N)
    <COND (<AND <VERB? EAT>
		<EQUAL? ,PRSO ,EAT-ME-CAKE>
		<EQUAL? ,HERE ,TEA-ROOM>>
	   <TELL
"Suddenly, the room appears to have become very large (although
everything you are carrying seems to be its normal size)." CR CR>
	   <REMOVE ,EAT-ME-CAKE>
	   <FSET ,ROBOT ,INVISIBLE>
	   <FSET ,ALICE-TABLE ,INVISIBLE>
	   <SET F <FIRST? ,HERE>>
	   <REPEAT ()
		   <COND (<NOT .F> <RETURN>)
			 (T
			  <SET N <NEXT? .F>>
			  <COND (<AND <NOT <EQUAL? .F ,ADVENTURER>>
				      <FSET? .F ,TAKEBIT>>
				 <FSET .F ,NONLANDBIT>
				 <FSET .F ,TRYTAKEBIT>
				 <MOVE .F ,POSTS-ROOM>)>)>
		   <SET F .N>>
	   <GOTO ,POSTS-ROOM>)
	  (T <CAKE-CRUMBLE>)>>

<ROUTINE CAKE-CRUMBLE ("AUX" CAKE)
	 <COND (<FSET? ,PRSO ,FOODBIT> <SET CAKE ,PRSO>)
	       (T <SET CAKE ,PRSI>)>
	 <COND (<OR <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>
		    <EQUAL? ,HERE ,MACHINE-ROOM ,MAGNET-ROOM ,CAGE-ROOM>
		    <EQUAL? ,HERE ,WELL-TOP ,IN-CAGE>>
	        <RFALSE>)
	       (T
	        <REMOVE .CAKE>
	        <TELL
"The " D .CAKE " has crumbled to dust." CR>)>>

<ROUTINE CAKE-FCN ("AUX" F N)
	<COND (<VERB? READ>
	       <COND (<FSET? ,PRSO ,NONLANDBIT>
		      <TELL
"The cake is much too tall now for you to read the lettering." CR>)
		     (,PRSI
		      <COND (<EQUAL? ,PRSI ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
			     <PERFORM ,V?LOOK-INSIDE ,PRSI>)
			    (<EQUAL? ,PRSI ,FLASK>
			     <TELL "The letters, now visible, say \"">
			     <COND (<EQUAL? ,PRSO ,RED-ICING>
				    <TELL "Evaporate">)
				   (<EQUAL? ,PRSO ,ORANGE-ICING>
				    <TELL "Explode">)
				   (T <TELL "Enlarge">)>
			     <TELL "\"." CR>)
			    (T <TELL "You can't see through that!" CR>)>)
		     (T
		      <TELL
"The first letter is a capital E. The rest is too small to read." CR>)>)
	      (<AND <VERB? EAT>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <COND (<EQUAL? ,PRSO ,ORANGE-ICING>
		      <REMOVE ,PRSO>
		      <ICEBOOM>)
		     (<EQUAL? ,PRSO ,RED-ICING>
		      <REMOVE ,PRSO>
		      <JIGS-UP
"That was delicious, but your dying memory is of feeling horribly dehydrated
and thirsty.">)
		     (<EQUAL? ,PRSO ,BLUE-ICING>
		      <REMOVE ,PRSO>
		      <TELL "The room around you seems to be getting smaller."
			    CR CR>
		      <COND (<EQUAL? ,HERE ,POSTS-ROOM>
			     <FCLEAR ,ROBOT ,INVISIBLE>
			     <FCLEAR ,ALICE-TABLE ,INVISIBLE>
			     <FSET ,POSTS ,INVISIBLE>
			     <SET F <FIRST? ,HERE>>
	   		     <REPEAT ()
				<COND (<NOT .F> <RETURN>)
				      (T
				       <SET N <NEXT? .F>>
				       <COND (<AND <NOT <EQUAL? .F ,ADVENTURER>>
						   <FSET? .F ,TAKEBIT>>
					      <FCLEAR .F ,NONLANDBIT>
					      <FCLEAR .F ,TRYTAKEBIT>
					      <MOVE .F ,TEA-ROOM>)>)>
				<SET F .N>>
			     <GOTO ,TEA-ROOM>)
			    (T <JIGS-UP
"The room seems to have become too small to hold you. The walls are not as
compressible as your body, which is demolished." >)>)>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,ORANGE-ICING>
		    <EQUAL? ,HERE ,TEA-ROOM ,POSTS-ROOM ,POOL-ROOM>>
	       <REMOVE ,PRSO>
	       <ICEBOOM>)
	      (<AND <VERB? THROW PUT>
		    <EQUAL? ,PRSO ,RED-ICING ,BLUE-ICING ,ORANGE-ICING>
		    <EQUAL? ,PRSI ,POOL>>
	       <COND (<EQUAL? ,PRSO ,BLUE-ICING ,ORANGE-ICING>
		      <TELL "The cake sinks majestically into the pool." CR>
		      <REMOVE ,PRSO>
		      <RTRUE>)>
	       <MOVE ,PRSO ,HERE>
	       <REMOVE ,PRSI>
	       <TELL
"Most of the pool evaporates, revealing a (slightly damp but
still valuable) package of rare candies. The red cake must be
pretty strong stuff, since it remains intact!" CR>
	       <FCLEAR ,CANDY ,INVISIBLE>)
	      (T <CAKE-CRUMBLE>)>>

<ROUTINE CANDY-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<FIXED-FONT-ON>
		<TELL
"       Frobozz Magic Candy Company|
         >>Special Assortment<<|
          Candied Grasshoppers|
             Chocolated Ants|
              Worms Glacee|
(By Appointment to His Majesty, Dimwit I)|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? EAT OPEN>
		<TELL
"Such rich food would probably not be good for you." CR>)>>

<ROUTINE TOP-ETCHINGS-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL
"       o  b  o|
   r             z|
f   M  A  G  I  C   z|
c    W  E   L  L    y|
   o             n|
       m  p  a|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE BOTTOM-ETCHINGS-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL
"       o  b  o|
|
       A  G  I|
        E   L|
|
       m  p  a|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE CUBE-F ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL	
"              Bank of Zork|
                   VAULT|
                 *722 GUE*|
        Frobozz Magic Vault Company|
">
	       <FIXED-FONT-OFF>
	       <RTRUE>)>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE POOL-FCN ()
	 <COND (<VERB? DRINK>
		<TELL
"The water is extremely salty." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"You'd probably have to enter the pool to see what's below the surface." CR>)
	       (<VERB? THROUGH>
		<JIGS-UP
"You enter the pool, thrash around for a good while, and then drown.
Sad, but true.">)>>

<ROUTINE FLASK-FCN ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"You notice that objects behind the flask appear to be magnified.
You might try looking at something through the flask." CR>)
	       (<AND <VERB? READ> <EQUAL? ,PRSI ,FLASK>>
		<TELL
"The flask distorts and magnifies the " D ,PRSO ", showing details
not noticed earlier." CR>
		<RFALSE>)
	       (<VERB? OPEN>
		<MUNG-ROOM ,HERE "Noxious vapors prevent your entry.">
		<JIGS-UP ,FATAL-VAPORS>)
	       (<VERB? MUNG THROW>
		<TELL "The flask breaks into pieces." CR>
		<REMOVE ,PRSO>
		<JIGS-UP ,FATAL-VAPORS>)>>

<GLOBAL FATAL-VAPORS
"As you pass out, you realize that the vapors from the
flask's contents are fatal.">

<ROUTINE PLEAK ()
    <COND (<VERB? TAKE>
	   <TELL <PICK-ONE ,YUKS> CR>)
	  (<VERB? PLUG>
	   <TELL "The leak is too high above you to reach." CR>)>>

<ROUTINE ICEBOOM ()
    <MUNG-ROOM ,HERE
"The entrance is blocked by sticky orange rubble. Probably some careless
adventurer was playing with blasting cakes.">
    <JIGS-UP
"You have been blasted to smithereens (wherever they are).">>

<ROUTINE MAGNET-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"You are in a circular room with a low ceiling. There are exits to
the east and southeast." CR>)
	      (<AND <EQUAL? .RARG ,M-ENTER>
		    ,CAROUSEL-FLIP-FLAG>
	       <COND (,CAROUSEL-ZOOM-FLAG
		      <JIGS-UP <COND (<EQUAL? ,ADVENTURER ,WINNER>
"According to Prof. TAA of GUE Tech, the rapidly changing magnetic
fields in the room are intense enough to electrocute you.
I really don't know, but in any event, something just killed you." )
				     (T
"According to Prof. TAA of GUE Tech, the magnetic fields in the room are
intense enough to fry the delicate innards of the robot. I really don't
know, but in any event, smoke pours from its ears and it has stopped moving.")>>)
		     (<EQUAL? ,WINNER ,ADVENTURER>
		      <TELL
"As you enter, your compass starts spinning wildly." CR>
		      <COND (<NOT ,COMPASS-KLUDGE>
			     <TELL
"What compass, you ask? The one which allows you to specify compass directions
for movement.">
			     <SETG COMPASS-KLUDGE T>)>
		      <CRLF>)>)>>

<GLOBAL COMPASS-KLUDGE <>>

<ROUTINE MAGNET-ROOM-EXIT ()
	<COND (<AND ,CAROUSEL-FLIP-FLAG <EQUAL? ,WINNER ,ADVENTURER>>
	       <TELL "You cannot get your bearings..." CR CR>
	       <COND (<PROB 50>
		      ,MACHINE-ROOM)
		     (T
		      ,TEA-ROOM)>)
	      (<EQUAL? ,PRSO ,P?EAST>
	       ,MACHINE-ROOM)
	      (<OR <EQUAL? ,PRSO ,P?SE>
		   <EQUAL? ,PRSO ,P?OUT>>
	       ,TEA-ROOM)
	      (T
	       <TELL "You can't go that way." CR>
	       <RFALSE>)>>

<GLOBAL CAROUSEL-ZOOM-FLAG <>>

<GLOBAL CAROUSEL-FLIP-FLAG <>>

<ROUTINE BUTTONS ()
	<COND (<VERB? PUSH>
	       <COND (<EQUAL? ,WINNER ,ADVENTURER>
		      <JIGS-UP
"There is a giant spark and you are fried to a crisp.">)
		     (<EQUAL? ,PRSO ,SQUARE-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <TELL "Nothing seems to happen." CR>)
			    (ELSE
			     <SETG CAROUSEL-ZOOM-FLAG T>
		      	     <TELL "The whirring increases in intensity." CR>)>)
		     (<EQUAL? ,PRSO ,ROUND-BUTTON>
		      <COND (,CAROUSEL-ZOOM-FLAG
			     <SETG CAROUSEL-ZOOM-FLAG <>>
		      	     <TELL "The whirring decreases in intensity." CR>)
			    (T
			     <TELL "Nothing seems to happen." CR>)>)
		     (<EQUAL? ,PRSO ,TRIANGULAR-BUTTON>
		      <SETG CAROUSEL-FLIP-FLAG <NOT ,CAROUSEL-FLIP-FLAG>>
		      <COND (<IN? ,IRON-BOX ,CAROUSEL-ROOM>
			     <TELL
"A dull thump is heard in the distance." CR>
			     <COND (<FSET? ,IRON-BOX ,INVISIBLE>
				    <FCLEAR ,IRON-BOX ,INVISIBLE>)
				   (T
				    <FSET ,IRON-BOX ,INVISIBLE>)>
			     <COND (<NOT <FSET? ,IRON-BOX ,INVISIBLE>>
				    <FCLEAR ,CAROUSEL-ROOM ,TOUCHBIT>)>
			     T)
			    (T <TELL "Click." CR>)>)>)>>

<GLOBAL CAGE-SOLVE-FLAG <>>

<ROUTINE SPHERE-FCN ("AUX" FL)
	#DECL ((FL) <OR ATOM FALSE>)
	<COND (<AND <NOT ,CAGE-SOLVE-FLAG> <VERB? TAKE MOVE PUT>>
	       <SET FL T>)
	      (T <SET FL <>>)>
	<COND (<AND .FL <EQUAL? ,ADVENTURER ,WINNER>>
	       <TELL
"As you reach for the sphere, a solid steel cage falls from the ceiling
to entrap you. To make matters worse, poisonous gas starts coming
into the room." CR CR>
	       <COND (<IN? ,ROBOT ,HERE>
		      <MOVE ,ROBOT ,IN-CAGE>
		      <FSET ,ROBOT ,NDESCBIT>)>
	       <GOTO ,IN-CAGE>
	       <MOVE ,CAGE ,HERE>
	       <FSET ,CAGE ,NDESCBIT>
	       <FCLEAR ,CAGE ,INVISIBLE>
	       <ENABLE <QUEUE I-SPHERE 6>>
	       T)
	      (.FL
	       <FSET ,PALANTIR-1 ,INVISIBLE>
	       <REMOVE ,ROBOT>
	       <FSET ,PRSO ,INVISIBLE>
	       <MOVE ,CAGE ,CAGE-ROOM>
	       <FCLEAR ,CAGE ,INVISIBLE>
	       <JIGS-UP
"As the robot reaches for the sphere, a solid steel cage falls from the
ceiling, trapping him. You can faintly hear his last words: \"Whirr,
buzz, click!\" A cloud of smoke rising from beneath the cage confirms
your fears about the fate of your brave mechanical friend.">
	       T)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <PALANTIR>)>>

<ROUTINE I-SPHERE ()
	 <COND (<EQUAL? ,HERE ,CAGE-ROOM ,IN-CAGE>
		<FSET ,PALANTIR-1 ,INVISIBLE>
		<MUNG-ROOM ,CAGE-ROOM
"You are stopped by a cloud of poisonous gas.">
		<JIGS-UP
"Time passes...and you die from some obscure poisoning.">)>>

<ROUTINE IN-CAGE-FCN (RARG)
    <COND (,CAGE-SOLVE-FLAG <SETG HERE ,CAGE-ROOM>)>>

<ROUTINE ROBOT-FCN ("OPTIONAL" (RARG ,M-OBJECT))
	<COND (<EQUAL? ,WINNER ,ROBOT>
	       <COND (<VERB? SGIVE> <RFALSE>)
		     (<VERB? FOLLOW>
		      <TELL
"\"My memory circuits are not that advanced. I can move as directed,
though.\"" CR>)
		     (<AND <VERB? RAISE TAKE MOVE> <EQUAL? ,PRSO ,CAGE>>
		      <TELL
"The cage shakes and is hurled across the room. It's hard to
say, but the robot appears to be smiling." CR CR>
		      <DISABLE <INT I-SPHERE>>
		      <SETG WINNER ,ADVENTURER>
		      <GOTO ,CAGE-ROOM>
		      <MOVE ,MANGLED-CAGE ,CAGE-ROOM>
		      <FCLEAR ,ROBOT ,NDESCBIT>
		      <FSET ,PALANTIR-1 ,TAKEBIT>
		      <MOVE ,ROBOT ,CAGE-ROOM>
		      <SETG CAGE-SOLVE-FLAG T>)
		     (<VERB? EAT DRINK>
		      <COND (<IN? ,ADVENTURER ,HERE>
			     <TELL
"\"I am sorry but that is difficult for a being with no mouth.\"" CR>)>
		      <RTRUE>)
		     (<AND <PROB 2>
			   <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
		      <TELL
"\"Buzz! Buzz! Buzz! My circuits are getting rusty. Try again.\"" CR>)
		     (<VERB? READ EXAMINE>
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"\"My vision is not sufficiently acute to do that.\"" CR>)>
		      <RTRUE>)
		     (<VERB? DROP PUT THROW>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<IN? ,PRSO ,ROBOT>
			     <TELL "\"Whirr, buzz, click!\"" CR>
			     <RFALSE>)
			    (T
			     <TELL
"\"Click! I don't have that. Buzz! Whirr!\"" CR>)>)
		     (<OR <VERB? WALK>
			  <AND <VERB? TAKE PUSH TURN>
			       <NOT <FSET? ,PRSO ,ACTORBIT>>>>
		      <COND (<NOT <EQUAL? <META-LOC ,ADVENTURER> ,HERE>>
			     <RFALSE>)
			    (<PROB 80>
			     <TELL "\"Whirr, buzz, click!\"" CR>)
			    (T
			     <TELL "\"Buzz, click, whirr!\"" CR>)>
		      <RFALSE>)
		     (T
		      <COND (<EQUAL? <META-LOC ,ADVENTURER> ,HERE>
			     <TELL
"\"My programming is insufficient to allow me to perform that task.\"" CR>)>
		      <RTRUE>)>)
	      (<VERB? OPEN LOOK-INSIDE CLOSE>
	       <TELL "There's no access panel or door on the robot." CR>)
	      (<AND <VERB? GIVE>
		    <EQUAL? ,PRSI ,ROBOT>>
	       <MOVE ,PRSO ,ROBOT>
	       <TELL "The robot gladly takes the "
		     D ,PRSO
		     " and nods his head-like appendage in thanks." CR>)
	      (<VERB? THROW MUNG>
	       <TELL
"The robot falls to the ground and (being of shoddy construction)
disintegrates before your eyes." CR>
	       <REMOVE <COND (<VERB? THROW> ,PRSI) (,PRSO)>>)>>

\

;"SUBTITLE BANK OF ZORK"

<GLOBAL BANK-SOLVE-FLAG <>>

<ROUTINE BILLS-OBJECT ()
	<SETG BANK-SOLVE-FLAG T>
	<COND (<VERB? BURN>
	       <TELL "Nothing like having money to burn!" CR>
	       <RFALSE>)
	      (<VERB? EAT>
	       <TELL "Talk about eating rich foods!" CR>)>>
	
<ROUTINE BKLEAVEE ("OPTIONAL" (RM ,TELLER-EAST))
    #DECL ((RM) OBJECT)
    <COND (<OR <HELD? ,BILLS> <HELD? ,PORTRAIT>>
	   <TELL
"An alarm rings briefly, and an invisible force bars your way." CR>
	   <RFALSE>)
	  (T .RM)>>

<ROUTINE BKLEAVEW ()
    <BKLEAVEE ,TELLER-WEST>>

<GLOBAL SCOL-ROOMS <LTABLE
       P?EAST
       VIEWING-EAST
       P?WEST
       VIEWING-WEST
       P?NORTH
       SMALL-ROOM
       P?SOUTH
       VAULT>>

<GLOBAL SCOL-WALLS <TABLE
       VIEWING-WEST
       SEWL
       VIEWING-WEST
       VIEWING-EAST
       SWWL
       VIEWING-EAST
       SMALL-ROOM
       SSWL
       VAULT
       VAULT
       SNWL
       SMALL-ROOM>>

<GLOBAL SCOL-ROOM VIEWING-WEST>

<ROUTINE DEPOSITORY-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-ENTER>
	       <SETG SCOL-ROOM <LKP ,PRSO ,SCOL-ROOMS>>)>>

<ROUTINE TELLER-ROOM (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"You are in a small room, which was used by a bank officer who retrieved
safety deposit boxes for the customer. On the north side of the room is a
sign which reads  \"Viewing Room\". On the ">
	   <COND (<EQUAL? ,HERE ,TELLER-WEST> <TELL "west">)
		 (T <TELL "east">)>
	   <TELL " side of the room, above an open door, is a sign reading:|
|
          BANK PERSONNEL ONLY|
" CR>)>>

<ROUTINE SCOL-OBJECT ("OPTIONAL" (OBJ <>))
    <COND (<VERB? PUSH MOVE TAKE RUB>
	   <TELL "As you try, your hand seems to go through it." CR>)
	  (<AND <VERB? ATTACK> ,PRSI>
	   <TELL "The " D ,PRSI " goes through it." CR>)
	  (<AND <VERB? THROW OVERBOARD> <EQUAL? ,PRSI ,CURTAIN .OBJ>>
	   <COND (<IN? ,PRSO ,WINNER>
		  <V-THROUGH ,PRSO>)
		 (T <TELL "You don't have that!" CR>)>)>>

<ROUTINE GET-WALL (RM "AUX" W)
    #DECL ((RM) OBJECT)
    <SET W ,SCOL-WALLS>
    <REPEAT ()
	<COND (<EQUAL? <GET .W 0> .RM>
	       <RETURN .W>)
	      (T <SET W <REST .W 6>>)>>>

<ROUTINE SCOLWALL ()
    <COND (<AND <VERB? THROW OVERBOARD PUT>
		<EQUAL? ,HERE ,SCOL-ACTIVE>
		<EQUAL? ,PRSI <GET <GET-WALL ,HERE> 1>>>
	   <SCOL-OBJECT ,PRSI>)>>

<ROUTINE SCOL-GO (OBJ)
	 #DECL ((OBJ) OBJECT)
	 <SETG SCOL-ACTIVE ,SCOL-ROOM>
	 <COND (.OBJ <SCOL-OBJ .OBJ 0 ,SCOL-ROOM>)
	       (T
	        <SCOL-THROUGH 12 ,SCOL-ROOM>)>>

<ROUTINE SCOL-OBJ (OBJ CINT RM)
    #DECL ((OBJ) OBJECT (CINT) FIX (RM) OBJECT)
    <ENABLE <QUEUE I-CURTAIN .CINT>>
    <MOVE .OBJ .RM>
    <COND (<EQUAL? .RM ,DEPOSITORY>
	   <TELL "The " D .OBJ " passes through the wall and vanishes." CR>)
	  (T
	   <TELL "The curtain dims slightly as the "
		 D .OBJ " passes through." CR>
	   <SETG SCOL-ROOM <>>
	   T)>>

<ROUTINE SCOL-THROUGH (CINT RM)
    #DECL ((CINT) FIX (RM) OBJECT)
    <ENABLE <QUEUE I-CURTAIN .CINT>>
    <TELL "You feel somewhat disoriented as you pass through..." CR CR>
    <GOTO .RM>>

<GLOBAL SCOL-ACTIVE <>>

<ROUTINE I-CURTAIN ()
    <SETG SCOL-ACTIVE <>>
    <COND (<EQUAL? ,HERE ,VAULT>
	   <JIGS-UP
"A metallic voice says \"Hello, Intruder! Your unauthorized presence
in the vault of the Bank of Zork has set off all sorts of nasty surprises,
most of which are fatal. This message brought to you by the Frobozz Magic
Vault Company.\"">)
	  (<EQUAL? ,HERE ,VIEWING-EAST ,VIEWING-WEST ,SMALL-ROOM>
	   <TELL "You hear a faint voice say \"Curtain Door Closed.\"" CR>
	   <COND (<EQUAL? ,HERE ,SMALL-ROOM>
	          <COND (,ZGNOME-FLAG <RTRUE>)
		        (T
		         <ENABLE <QUEUE I-ZGNOME 3>>
		         <SETG ZGNOME-FLAG T>)>)>)>>

<GLOBAL ZGNOME-FLAG <>>

<ROUTINE I-ZGNOME ()
         <COND (<EQUAL? ,HERE ,SMALL-ROOM>
		<ENABLE <QUEUE I-ZGNOME-OUT 12>>
		<TELL
"An epicene gnome of Zurich wearing a three-piece suit and carrying a
safety deposit box materializes in the room.">
		<COND (<IN? ,WAND ,WINNER>
		       <TELL
" He notices the wand and dematerializes speedily." CR>)
		      (T
		       <TELL " \"You seem to have
forgotten to deposit your valuables,\" he says, tapping the lid of the
box impatiently. \"We don't usually allow customers to use the boxes
here, but we can make this ONE exception, I suppose...\" He looks
askance at you over his wire-rimmed bifocals." CR>
		       <MOVE ,GNOME-OF-ZURICH ,HERE>)>)>>

<ROUTINE BOX-F ()
	 <TELL "The gnome clutches it possessively." CR>>

<ROUTINE ZGNOME-FCN ()
    <COND (<VERB? TELL>
	   <SETG P-CONT <>>
	   <SETG QUOTE-FLAG <>>
	   <TELL
"The gnome appears increasingly impatient." CR>)
	  (<AND <VERB? GIVE THROW> <EQUAL? ,PRSI ,GNOME-OF-ZURICH>>
	   <COND (<GETPT ,PRSO ,P?VALUE>
		  <TELL
"The gnome carefully places the " D ,PRSO  " in the
deposit box. \"Let me show you the way out,\" he says, making it clear
he will be pleased to see the last of you. Then, you are momentarily
disoriented, and when you recover you are back at the Bank Entrance." CR>
		  <REMOVE ,GNOME-OF-ZURICH>
		  <REMOVE ,PRSO>
		  <DISABLE <INT I-ZGNOME-OUT>>
		  <GOTO ,BANK-ENTRANCE>
		  <RTRUE>)
		 (<BOMB? ,PRSO>
		  <REMOVE ,GNOME-OF-ZURICH>
		  <MOVE ,PRSO ,HERE>
		  <DISABLE <INT I-ZGNOME>>
		  <DISABLE <INT I-ZGNOME-OUT>>
		  <TELL
"\"You are so very gracious. I really cannot accept.\" he says. He
disappears, a wry smile on his lips." CR>)
		 (T
		  <TELL
"\"I wouldn't put THAT in a safety deposit box,\" remarks the gnome with
disdain, tossing it over his shoulder, where it disappears with an
understated \"pop\"." CR>
		  <REMOVE-CAREFULLY ,PRSO>
		  <RTRUE>)>)
	  (<VERB? ATTACK>
	   <TELL
"The gnome says \"Well, I never...\" and disappears with a snap of his
fingers, leaving you alone." CR>
	   <REMOVE ,GNOME-OF-ZURICH>
	   <DISABLE <INT I-ZGNOME-OUT>>)
	  (T
	   <TELL
"The gnome appears increasingly impatient." CR>)>>

<ROUTINE I-ZGNOME-OUT ()
         <REMOVE ,GNOME-OF-ZURICH>
	 <COND (<EQUAL? ,HERE ,SMALL-ROOM>
		<TELL
"The gnome looks impatient: \"I may have another customer waiting;
you'll just have to fend for yourself, I'm afraid.\" He disappears,
leaving you alone." CR>)>>

<ROUTINE BOMB? (O)
	<COND (<AND <EQUAL? .O ,BRICK>
	            <IN? ,FUSE ,BRICK>
		    <NOT <0? <GET <INT I-FUSE> ,C-ENABLED?>>>>
	       <RTRUE>)
	      (T <RFALSE>)>>

\

"PALANTIRS, ETC."

<ROUTINE GO&LOOK (RM "AUX" OHERE OLIT (OSEEN <>))
	 #DECL ((RM) OBJECT)
	 <SET OHERE ,HERE>
	 <COND (<FSET? .OHERE ,TOUCHBIT>
		<SET OSEEN T>)>
	 <SET OLIT ,LIT>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? .RM>>
	 <PERFORM ,V?LOOK>
	 <COND (<NOT .OSEEN> <FCLEAR .OHERE ,TOUCHBIT>)>
	 <SETG HERE .OHERE>
	 <SETG LIT .OLIT>
	 T>

<ROUTINE TINY-ROOM-FCN (RARG)
    #DECL ((RARG) <OR FIX FALSE>)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"This is a tiny room carved out of the wall of the ravine. There is
an exit down a precarious climb. ">
	   <P-DOOR "north" ,LID-1 ,KEYHOLE-1>
	   <RTRUE>)
	  (<NOT <VERB? LOOK>> <PCHECK> <RFALSE>)>>

<ROUTINE DREARY-ROOM-FCN (RARG)
    #DECL ((RARG) <OR FIX FALSE>)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"This is a small and rather dreary room, eerily illuminated by a red glow
emanating from a crack in one wall. The light falls upon a dusty wooden table
in the center of the room. ">
	   <P-DOOR "south" ,LID-2 ,KEYHOLE-2>
	   <RTRUE>)>
          (T <PCHECK> <RFALSE>)>

<ROUTINE PCHECK ("AUX" (LID <PLID>))
	#DECL ((LID) OBJECT)
	<SETG PLOOK-FLAG <>>
	<COND (<OR <IN? ,KEY ,KEYHOLE-1>
		   <IN? ,KEY ,KEYHOLE-2>>
	       <FSET ,KEY ,NDESCBIT>)
	      (T
	       <FCLEAR ,KEY ,NDESCBIT>)>
	<COND (<HELD? ,PLACE-MAT>
	       <SETG MUD-FLAG <>>)> ;"HUH?"
	<COND (,MUD-FLAG
	       <MOVE ,PLACE-MAT ,HERE>
	       <FSET ,PLACE-MAT ,NDESCBIT>)
	      (T
	       <FCLEAR ,PLACE-MAT ,NDESCBIT>)>>

<ROUTINE P-DOOR (STR LID KEYHOLE "AUX" F)
	#DECL ((STR) STRING (LID KEYHOLE) OBJECT)
	<COND (,PLOOK-FLAG <SETG PLOOK-FLAG <>> <RFALSE>)>
	<TELL "On the "
	      .STR
	      " side of the room is a massive wooden door, which has a
small window barred with iron. A formidable bolt lock is set within the
door frame. A keyhole ">
	<COND (<NOT <FSET? .LID ,OPENBIT>>
	       <TELL "covered by a thin metal lid ">)>
	<TELL "lies within the lock.">
	<COND (<SET F <FIRST? .KEYHOLE>>
	       <TELL " A " D .F
		     " is in place within the keyhole.">)>
	<COND (,MUD-FLAG
	       <TELL " The edge of a place mat is visible under the door.">
	       <COND (,MATOBJ
		      <TELL " Lying on the place mat is a " D ,MATOBJ ".">)>)>
	<CRLF>>

<ROUTINE PLID ("OPTIONAL" (OBJ1 ,LID-1) (OBJ2 ,LID-2))
    #DECL ((OBJ1 OBJ2) OBJECT)
    <COND (<IN? .OBJ1 ,HERE>
	   .OBJ1)
	  (T .OBJ2)>>

<ROUTINE PKH (KEYHOLE "OPTIONAL" (THIS <>))
    #DECL ((KEYHOLE) OBJECT (THIS) <OR ATOM FALSE>)
    <COND (<AND <EQUAL? .KEYHOLE ,KEYHOLE-1> <NOT .THIS>>
	   ,KEYHOLE-2)
	  (<AND <NOT <EQUAL? .KEYHOLE ,KEYHOLE-1>> .THIS>
	   ,KEYHOLE-2)
	  (T ,KEYHOLE-1)>>

<ROUTINE PKH-FCN ("AUX" OBJ KH)
    #DECL ((OBJ) OBJECT)
    <COND (<VERB? LOOK-INSIDE>
	   <COND (<AND <FSET? ,LID-1 ,OPENBIT>
		       <FSET? ,LID-2 ,OPENBIT>
		       <NOT <FIRST? ,KEYHOLE-1>>
		       <NOT <FIRST? ,KEYHOLE-2>>
		       <LIT? <COND (<EQUAL? ,HERE ,DREARY-ROOM>
				    ,TINY-ROOM)
				   (T ,DREARY-ROOM)>>>
		  <TELL
"You can see a lighted room at the other end." CR>)
		 (T
		  <TELL
"No light can be seen through the keyhole." CR>)>)
	  (<VERB? PUT>
	   <COND (<FSET? <PLID> ,OPENBIT>
		  <COND (<FIRST? <PKH ,PRSI T>>
			 <TELL "The keyhole is blocked." CR>)
			(<EQUAL? ,PRSO ,LETTER-OPENER ,KEY>
			 <COND (<FIRST? <SET KH <PKH ,PRSI>>>
				<TELL
"There is a faint noise from behind the door and a small cloud of
dust rises from beneath it." CR>
				<SET OBJ <FIRST? .KH>>
				<REMOVE .OBJ>
				<COND (,MUD-FLAG
				       <SETG MATOBJ .OBJ>)>
				<RFALSE>)>)
			(T <TELL "The " D ,PRSO " doesn't fit." CR>)>)
		 (T <TELL "The lid is in the way." CR>)>)>>

<ROUTINE PLID-FCN ()
    <COND (<VERB? OPEN RAISE MOVE>
	   <COND (<FSET? ,PRSO ,OPENBIT>
		  <TELL <RANDOM-ELEMENT ,DUMMY> CR>)
		 (T <TELL "The lid is now open." CR>)>
	   <FSET ,PRSO ,OPENBIT>)
	  (<VERB? CLOSE LOWER>
	   <COND (<FIRST? <COND (<EQUAL? ,HERE ,DREARY-ROOM>
				 ,KEYHOLE-2)
				(T ,KEYHOLE-1)>>
		  <TELL "The keyhole is occupied." CR>)
		 (T
		  <TELL "The lid covers the keyhole." CR>
		  <FCLEAR ,PRSO ,OPENBIT>)>)
	  (<VERB? LOOK-BEHIND>
	   <TELL "There's a keyhole behind the lid." CR>)>>
	
<GLOBAL MUD-FLAG <>>

<GLOBAL MATOBJ <>>

<GLOBAL PUNLOCK-FLAG <>>

<GLOBAL PLOOK-FLAG <>>

<ROUTINE ROOM? (OBJ "AUX" NOBJ)
	 <REPEAT ()
		 <SET NOBJ <LOC .OBJ>>
		 <COND (<NOT .NOBJ> <RFALSE>)
		       (<EQUAL? .NOBJ ,WINNER> <RFALSE>)
		       (<EQUAL? .NOBJ ,ROOMS> <RETURN .OBJ>)>
		 <SET OBJ .NOBJ>>>

<ROUTINE PALANTIR ()
	 <COND (<VERB? LOOK-INSIDE>
		<PALANTIR-LOOK <COND (<EQUAL? ,PRSO ,PALANTIR-1>
				      ,PALANTIR-2)
				     (<EQUAL? ,PRSO ,PALANTIR-2>
				      ,PALANTIR-3)
				     (<EQUAL? ,PRSO ,PALANTIR-3>
				      ,PALANTIR-1)
				     (T ,PALANTIR-4)>>)
	       (<VERB? EXAMINE>
		<TELL
"There is something misty in the sphere. Perhaps if you were to look
into it..." CR>)
	       (<AND <VERB? TAKE> <==? ,PRSO ,PALANTIR-3>>
		<PUTP ,PRSO ,P?LDESC <>>
		<RFALSE>)>>

<ROUTINE DEAD-PALANTIR (RARG "AUX" P)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are inside a huge crystalline sphere filled with thin "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1>
		       <SET P ,PALANTIR-1>
		       "red")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2>
		       <SET P ,PALANTIR-2>
		       "blue")
		      (T <SET P ,PALANTIR-3> "white")>
" mist. The mist becomes "
		<COND (<EQUAL? ,HERE ,DEAD-PALANTIR-1> "blue")
		      (<EQUAL? ,HERE ,DEAD-PALANTIR-2> "white")
		      (T "black")>
" to the west." CR>
		<TELL "You strain to look out through the mist... " CR>
		<COND (<FSET? .P ,TOUCHBIT>
		       <PALANTIR-LOOK .P T>)
		      (<EQUAL? .P ,PALANTIR-1>
		       <TELL
"You see a small room with a sign on the wall, but it is too blurry to
read." CR>)
		      (<EQUAL? .P ,PALANTIR-2>
		       <TELL
"You look out into a large, dreary room with a great door and a huge table.
There is an odd glow to the mist." CR>)
		      (<EQUAL? .P ,PALANTIR-3>
		       <TELL
"A strange blurry room is barely visible.">
		       <COND (<AND <IN? ,SERPENT ,AQUARIUM> <PROB 25>>
			      <TELL
" An odd sinuous shadow crosses the mist as you look.">)>
		       <CRLF>)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <EQUAL? ,HERE ,DEAD-PALANTIR-4>>
		<TELL
"You follow a corridor of black mist into a black walled spherical
room.">
		<COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
" The room is empty. A huge face looks down on you from outside and
laughs sardonically. It doesn't look like you're getting out of this
predicament!" CR>
		       <FINISH>)>
		<TELL
" As you enter, a huge and horrible face materializes out of the
mist.|
|
\"What brings you here to trouble my imprisonment, wanderer?\"
it asks. Hearing no immediate answer, it studies you for a moment." CR>

		<COND (<NOT <L? ,DEATHS 3>>
		       <TELL
"\"Not you again! This is getting tedious. You'll obviously never
be much help to me. Better luck next time, oh wondrous
adventurer.\" The face disappears and everything goes black." CR>
		       <FINISH>)
		      (T
		       <TELL
"\"Perhaps you may be of some use to me in gaining my freedom from
this place. Return to your foolish quest! I shall not destroy you
this time. Mayhap you will repay this favor in kind someday.\" The
face vanishes and the mist begins to swirl. When it clears you are
returned to the world of life." CR>
		<SETG DEAD <>>
		<GOTO ,INSIDE-BARROW>
		;<GOTO ,INSIDE-BARROW <>>
		;<TELL CR "Inside the Barrow" CR>
		<RTRUE>)>)>>

<ROUTINE GLOBAL-PALANTIRS ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<DEAD-PALANTIR ,M-LOOK>)
	       (<VERB? MUNG> <TELL "The sphere is unbreakable." CR>)>>

<ROUTINE PALANTIR-LOOK (OBJ "OPTIONAL" (INSIDE? <>) "AUX" RM OHERE)
	 <COND (<EQUAL? .OBJ ,PALANTIR-4>
		<TELL
"As you peer into the sphere, a strange vision takes shape...a huge and
fearful face with yellow eyes. The face peers out at you expectantly." CR>
		<RTRUE>)>
	 <SET RM <ROOM? .OBJ>>
	 <COND (<OR <NOT .RM> <NOT <LIT? .RM>>>
		<TELL "You see only darkness." CR>)
	       (<OR <IN? .OBJ .RM> <SEE-INSIDE? <LOC .OBJ>>>
		<SET OHERE ,HERE>
		<COND (.INSIDE?
		       <TELL
"As you peer through the mist, a strangely colored vision of a
huge room takes shape..." CR CR>)
		      (T
		       <TELL
"As you peer into the sphere, a strange vision takes shape of
a distant room, which can be described clearly...." CR CR>)>
		<FSET .OBJ ,INVISIBLE>
		<GO&LOOK .RM>
		<COND (<EQUAL? .OHERE .RM>
		       <TELL
"An astonished adventurer is staring into a crystal sphere." CR>)>
		<FCLEAR .OBJ ,INVISIBLE>
		<COND (<NOT .INSIDE?>
		       <TELL
"The vision fades, revealing only an ordinary crystal sphere." CR>)>)
	       (T
		<TELL "You see only darkness." CR>)>
	 T>

<ROUTINE PWINDOW-FCN ()
    <COND (<VERB? LOOK-INSIDE>
	   <SETG PLOOK-FLAG T>
	   <COND (<FSET? ,PDOOR ,OPENBIT>
		  <TELL "The door is open, dummy." CR>)
		 (<EQUAL? ,HERE ,DREARY-ROOM>
		  <GO&LOOK ,TINY-ROOM>)
		 (T <GO&LOOK ,DREARY-ROOM>)>)
	  (<VERB? THROUGH>
	   <TELL "Perhaps if you were diced...." CR>)>>

<ROUTINE PDOOR-FCN ("AUX" K)
    <COND (<AND <VERB? LOOK-UNDER> ,MUD-FLAG>
	   <TELL "The place mat is under the door." CR>)
	  (<VERB? UNLOCK>
	   <COND (<EQUAL? ,PRSI ,KEY>
		  <COND (<AND <SET K <FIRST? <PLID ,KEYHOLE-1 ,KEYHOLE-2>>>
			      <NOT <EQUAL? .K ,KEY>>>
			 <TELL "The keyhole is blocked." CR>)
			(T
			 <TELL "The door is now unlocked." CR>
			 <SETG PUNLOCK-FLAG T>)>)
		 (<EQUAL? ,PRSI ,GOLD-KEY>
		  <TELL "It doesn't fit the lock." CR>)
		 (T <TELL "It can't be unlocked with that." CR>)>)
	  (<VERB? LOCK>
	   <COND (<EQUAL? ,PRSI ,KEY>
		  <TELL "The door is locked." CR>
		  <SETG PUNLOCK-FLAG <>>
		  T)
		 (<EQUAL? ,PRSI ,GOLD-KEY>
		  <TELL "It doesn't fit the lock." CR>)
		 (T <TELL "It can't be locked with that." CR>)>)
	  (<VERB? PUT-UNDER>
	   <COND (<EQUAL? ,PRSO ,ROBOT-LABEL>
		  <TELL
"The paper is very small and vanishes under the door." CR>
		  <MOVE ,PRSO <COND (<EQUAL? ,HERE ,TINY-ROOM> ,DREARY-ROOM)
				    (T ,TINY-ROOM)>>)
		 (<EQUAL? ,PRSO ,NEWSPAPER>
		  <TELL
"The newspaper crumples up and won't go under the door." CR>)>)
	  (<VERB? OPEN CLOSE>
	   <COND (,PUNLOCK-FLAG
		  <OPEN-CLOSE ,PRSO
		       "The door is now open."
		       "The door is now closed.">)
		 (T <TELL "The door is locked." CR>)>)>>
	
<ROUTINE PKEY-FCN ()
    <COND (<VERB? TURN>
	   <COND (,PUNLOCK-FLAG
		  <PERFORM ,V?LOCK ,PDOOR ,PRSO>)
		 (T
		  <PERFORM ,V?UNLOCK ,PDOOR ,PRSO>)>)>>
		
<ROUTINE PLACE-MAT-FCN ()
    <COND (<VERB? PUT-UNDER>
	   <COND (<EQUAL? ,PRSI ,PDOOR>
	          <TELL "The place mat fits easily under the door." CR>
	          <MOVE ,PRSO ,HERE>
	          <SETG MUD-FLAG T>)
		 (<EQUAL? ,PRSI ,WIZ-DOOR ,RIDDLE-DOOR ,CRYPT-DOOR>
	          <TELL "There's not enough room under this door." CR>)>)
	  (<AND <VERB? TAKE MOVE> ,MATOBJ>
 	   <MOVE ,MATOBJ ,HERE>
	   <TELL "As the place mat is moved, a "
		 D
		 ,MATOBJ
		 " falls from it and onto the floor." CR>
	   <SETG MATOBJ <>>
	   <SETG MUD-FLAG <>>
	   <RTRUE>)>>

<ROUTINE WISH-FCN ()
	 <COND (<VERB? MAKE>
	        <COND (<AND <EQUAL? ,HERE ,WELL-BOTTOM>
			    <IN? ,COIN ,HERE>>
		       <TELL
"A whispering voice replies: \"Water makes the bucket go.\"
Unfortunately, wishing makes the coin go...." CR>
		      <REMOVE ,COIN>)
		      (T
		       <TELL "No one is listening." CR>)>)>>

<ROUTINE WELL-FCN ()
    	<COND (<AND <FSET? ,PRSO ,TAKEBIT> <VERB? THROW PUT DROP>>
	       <TELL "The " D ,PRSO
		     " is now sitting at the bottom of the well." CR>
	       <MOVE ,PRSO ,WELL-BOTTOM>)
	      (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
	       <TELL "You can't climb the well." CR>)>>

<GLOBAL MATCH-COUNT 6>

<ROUTINE MATCH-FCN ( "AUX" CNT)
	 <COND (<AND <VERB? LAMP-ON BURN> <EQUAL? ,PRSO ,MATCH>>
		<COND (<G? ,MATCH-COUNT 0>
		       <SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
		<COND (<NOT <G? ,MATCH-COUNT 0>>
		       <TELL
			"I'm afraid you have run out of matches." CR>)
		      (T
		       <FSET ,MATCH ,FLAMEBIT>
		       <FSET ,MATCH ,ONBIT>
		       <ENABLE <QUEUE I-MATCH 2>>
		       <TELL "One of the matches starts to burn." CR>)>)
	       (<AND <VERB? LAMP-OFF> <FSET? ,MATCH ,FLAMEBIT>>
		<TELL "The match is out." CR>
		<FCLEAR ,MATCH ,FLAMEBIT>
		<FCLEAR ,MATCH ,ONBIT>
		<QUEUE I-MATCH 0>
		T)
	       (<VERB? COUNT>
		<TELL "You have ">
		<SET CNT <- ,MATCH-COUNT 1>>
		<TELL N .CNT " match">
		<COND (<NOT <1? .CNT>> <TELL "es.">) (T <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <TELL "A match is burning.">)
		      (T
		       <TELL "No match is burning.">)>
		<CRLF>)>>

<ROUTINE I-MATCH ()
	 <TELL "The match has gone out." CR>
	 <FCLEAR ,MATCH ,FLAMEBIT>
	 <FCLEAR ,MATCH ,ONBIT>>


<GLOBAL LAMP-TABLE
	<TABLE 300
	       "The lamp appears a bit dimmer."
	       100
	       "The lamp is definitely dimmer now."
	       50
	       "The lamp is nearly out."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<AND <VERB? THROW> <==? ,PRSO ,LAMP>>
		<TELL
"The lamp has smashed into the floor, and the light has gone out." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE ,LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "A burned-out lamp won't light." CR>)
		      (T
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "The lamp has already burned out." CR>)
		      (T
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "The lamp has burned out.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "The lamp is on.">)
		      (T
		       <TELL "The lamp is turned off.">)>
		<CRLF>)>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"You'd better have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
		(TICK) FIX)
	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
	 <COND (<0? .TICK>
		<FSET .OBJ ,RMUNGBIT>
		<FCLEAR .OBJ ,ONBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"I hope you have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>
	 <COND (<NOT <0? .TICK>>
		<SETG .TBLNAM <REST .TBL 4>>)>
	 <RTRUE>>

;"Riddles"

<ROUTINE RIDDLE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a room which is bare on all sides. There is an exit down in
the northwest corner of the room. To the east is a great ">
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL " door made of
stone. Above the stone, the following words are written: \"No man shall
pass this door without solving this riddle:|
|
  What is tall as a house,|
    round as a cup,|
      and all the king's horses|
        can't draw it up?\"|
">)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? ANSWER SAY>
		       <COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
			      <RFALSE>)
			     (<OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?WELL>
				  <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?WELL>>
			      <TELL
"There is a deafening clap of thunder and the stone door
quietly swings open to reveal a passageway beyond." CR>
			      <SCORE-UPD 5>
			      <FSET ,RIDDLE-DOOR ,OPENBIT>)
			     (T
			      <TELL
"A hollow laugh seems to come from the stone door." CR>)>
		      <SETG P-CONT <>>
		      <SETG QUOTE-FLAG <>>
		      <RTRUE>)>)>>

<ROUTINE RIDDLE-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "It is open!" CR>)
		      (T
		       <TELL
"The door can only be opened by answering the riddle." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>
		       <TELL "Not a chance. The door weighs many tons." CR>)
		      (T
		       <TELL "It is closed!" CR>)>)>>

<GLOBAL DUMMY
	<LTABLE "Look around."
	       "You think it isn't?"
	       "I think you've already done that.">>

<ROUTINE RIDDLE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "Use the \"Look\" command." CR>)>>

<ROUTINE MAGIC-ACTOR ("AUX" V)
	 <COND (,SPELL?
		<COND (<EQUAL? ,SPELL? ,S-FALL>
		       <COND (<OR <VERB? CLIMB-UP CLIMB-DOWN CROSS>
				  <AND <VERB? WALK>
				       <GETPT ,HERE ,P?DOWN>>>
			      <SET V <GETPT ,HERE ,P?GLOBAL>>
			      <COND (<ZMEMQB ,BRIDGE .V <PTSIZE .V>>
				     <JIGS-UP
"You find yourself drawn toward the edge of the bridge. You peer over
the side. Oops, that was clumsy of you! You tripped on something and
fell in. Too bad.">)
				    (<PROB 25>
				     <JIGS-UP
"For some odd reason you have tripped on your own feet, or perhaps an
invisible cord stretched across the path. The resulting fall seems to
have done you in.">)
				   (T
				    <TELL
"You just tripped on an invisible cord, or perhaps your own feet. But
this must be your lucky day, as you managed to regain your balance
before what could have been a fatal fall." CR>)>)
			     (<VERB? BOARD>
			      <TELL
"You get in the " D ,PRSO " but you fall out again, almost as though
an invisible hand had tipped it over." CR>)>)
		      (<EQUAL? ,SPELL? ,S-FLOAT>
		       <COND (<VERB? DIAGNOSE WAIT> <RFALSE>)
			     (<VERB? WALK>
<TELL "I suppose you plan to do that by flapping your arms?" CR>)
			     (<VERB? DROP>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"The " D ,PRSO " drops to the ground." CR>)
			     (<AND <VERB? TAKE> <IN? ,PRSO ,HERE>>
			      <TELL
"You can't reach that! It's on the ground." CR>)>)
		      (<EQUAL? ,SPELL? ,S-FREEZE>
		       <COND (<VERB? DIAGNOSE WAIT> <RFALSE>)
			     (T
			      <TELL
"You are frozen solid. You might as well wait it out, because you
can't do anything else in this state." CR>)>)
		      (<AND <EQUAL? ,SPELL? ,S-FENCE>
			    <VERB? WALK>>
		       <TELL
"An invisible fence of magical force bars your way." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,SPELL? ,S-FIERCE>
			    <SET V <INFESTED? ,HERE>>>
		       <COND (<VERB? ATTACK MUNG> <RFALSE>)
			     (T
			      <FORCE-FIGHT .V>
			      <RTRUE>)>)
		      (<AND <EQUAL? ,SPELL? ,S-FERMENT>
			    <VERB? WALK>
			    <IN? ,WINNER ,HERE>>
		       <TELL
"Oops, you seem a little unsteady... I'm not sure you got where
you intended going." CR CR>
		       <RANDOM-WALK>)
		      (<AND <EQUAL? ,SPELL? ,S-FEAR>
			    <SET V <INFESTED? ,HERE>>>
		       <TELL
"All at once, you are overcome by fear! There's is a " D .V " in here!
Maybe it's after you! ">
		       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
			      <TELL
"You huddle in the corner, terrified." CR>)
			     (T
			      <TELL
"You run from the room screaming in terror!" CR CR>
			      <RANDOM-WALK>)>)>)>>

<ROUTINE RANDOM-WALK ("AUX" P TX L S (D <>))
	 <SET P 0>
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<COND (.D
			       <SET S ,SPELL?>
			       <SETG SPELL? <>>
			       <SETG WINNER ,ADVENTURER>
			       <MOVE ,WINNER ,HERE>
			       <DO-WALK .D>
			       <SETG SPELL? .S>)>
			<RETURN>)
		       (T
			<SET TX <GETPT ,HERE .P>>
			<SET L <PTSIZE .TX>>
			<COND (<OR <EQUAL? .L ,UEXIT>
				   <AND <EQUAL? .L ,CEXIT>
					<VALUE <GETB .TX ,CEXITFLAG>>>
				   <AND <EQUAL? .L ,DEXIT>
					<FSET? <GETB .TX ,DEXITOBJ> ,OPENBIT>>>
			       <COND (<NOT .D> <SET D .P>)
				     (<PROB 50> <SET D .P>)>)>)>>>

<ROUTINE FORCE-FIGHT (V "AUX" W)
	 <COND (<NOT <SET W <FIND-IN ,ADVENTURER ,WEAPONBIT>>>
		<SET W ,HANDS>)>
	 <TELL
"You are maddened by an overwhelming ferocity, and attack the "
D .V " instead." CR>
	 <PERFORM ,V?ATTACK .V .W>>

\

"SUBTITLE DIAMOND MAZE"

<GLOBAL DIAMOND-SOLVE <>> ;"T if solved"

<GLOBAL DIAMOND-COUNT 0>  ;"count of current progress"
<GLOBAL DIAMOND-MOVES 0>  ;"count of moves since progressed"
<GLOBAL DIAMOND-BASE 0>	  ;"count of maximum progress ever"

<GLOBAL DWDESCS
	<TABLE "dark"
	       "flickering dimly"
	       "dimly glowing"
	       "glowing"
	       "glowing brightly">>

<ROUTINE DWINDOW-DESC ()
	 <TELL
"On the floor is a very small diamond shaped window which is ">
	 <COND (,DIAMOND-SOLVE <TELL "glowing serenely">)
	       (T <TELL <GET ,DWDESCS ,DIAMOND-COUNT>>)>
	 <TELL "." CR>>

<ROUTINE DWINDOW-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"The window is an integral part of the floor." CR>)
	       (<VERB? MUNG>
		<TELL
"The window is diamond-hard and cannot be broken." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<DWINDOW-DESC>)>>

<ROUTINE DIAMOND-MOTION (RARG "AUX" DC DIR RM)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a room with oddly angled walls and passages in all directions.
The walls are made of some glassy substance." CR>
		<COND (<EQUAL? ,HERE ,DIAMOND-5>
		       <TELL
"A marble stairway leads upward.">
		       <COND (,DIAMOND-SOLVE
			      <TELL
" The floor has swung down at the end of the stairway to reveal a secret
passage leading down into unrelieved darkness.">)>
		       <CRLF>)
		      (T <DWINDOW-DESC>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-FLASH> <DWINDOW-DESC> <RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     <NOT ,DIAMOND-SOLVE>>
		<COND (<OR <EQUAL? ,HERE ,DIAMOND-2 ,DIAMOND-4>
			   <EQUAL? ,HERE ,DIAMOND-6 ,DIAMOND-8>>
		       <SET DIR <GET ,DIDIRS <- ,DIAMOND-COUNT 1>>>
		       <COND (<EQUAL? ,PRSO .DIR>
			      <SETG DIAMOND-COUNT <+ ,DIAMOND-COUNT 1>>
			      <COND (<G? ,DIAMOND-COUNT ,DIAMOND-BASE>
				     <SETG DIAMOND-BASE ,DIAMOND-COUNT>
				     <SETG DIAMOND-MOVES 0>)>
			      <COND (<EQUAL? ,DIAMOND-COUNT 5>
				     <TELL
"You hear a strange rusty squeal echoing in the distance." CR>
				     <FCLEAR ,DIAMOND-5 ,TOUCHBIT>
				     <SCORE-UPD 5>
				     <SETG DIAMOND-SOLVE T>)>
			      <COND (<EQUAL? ,HERE ,DIAMOND-2>
				     <SET DIR ,DIAMOND-4>)
				    (<EQUAL? ,HERE ,DIAMOND-4>
				     <SET DIR ,DIAMOND-8>)
				    (<EQUAL? ,HERE ,DIAMOND-8>
				     <SET DIR ,DIAMOND-6>)
				    (<EQUAL? ,HERE ,DIAMOND-6>
				     <SET DIR ,DIAMOND-2>)>
			      <GOTO .DIR>)
			     (T
			      <DIAMOND-LOSS>)>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,DIAMOND-5>
			    <EQUAL? ,PRSO ,P?UP>>
		       <RFALSE>)
		      (T
		       <SETG DIAMOND-COUNT 0>
		       <COND (<PROB 33>
			      <TELL
"There is no way to go in that direction." CR>
			      <RTRUE>)
			     (<PROB 25>
			      <DIAMOND-LOSS>
			      <RTRUE>)
			     (T
			      <SETG DIAMOND-COUNT 1>
			      <COND (<G? ,DIAMOND-COUNT ,DIAMOND-BASE>
				     <SETG DIAMOND-BASE ,DIAMOND-COUNT>
				     <SETG DIAMOND-MOVES 0>)>
			      <SET RM <GET ,DIAMOND-ROOMS
					   <- <RANDOM 4> 1>>>
			      <COND (<FSET? ,BAT ,INVISIBLE>
				     <FCLEAR ,BAT ,INVISIBLE>
				     <MOVE ,BAT .RM>)>
			      <GOTO .RM>
			      <RTRUE>)>)>)>>

<ROUTINE DIAMOND-LOSS ()
	 <SETG DIAMOND-MOVES <+ ,DIAMOND-MOVES 1>>
	 <COND (<EQUAL? ,DIAMOND-MOVES 20>
		<TELL
"As you thrash about in the maze, the mirthful voice of the Wizard
taunts you: \"Fool! You'll never get past ">
		<TELL <GET ,BASES ,DIAMOND-BASE>>
		<TELL " base at this rate!\"" CR>)>
	 <GOTO <GET ,DIAMOND-ROOMS <+ 3 <RANDOM 5>>>>>

<GLOBAL BASES <TABLE "first" "first" "first" "second" "third" "home">>

<GLOBAL DIAMOND-ROOMS
	<TABLE DIAMOND-2 DIAMOND-4 DIAMOND-6 DIAMOND-8
	       DIAMOND-1 DIAMOND-3 DIAMOND-5 DIAMOND-7 DIAMOND-9>>

<GLOBAL DIDIRS <TABLE P?SE P?NE P?NW P?SW>>

\

"SUBTITLE CERBERUS"

<GLOBAL CERBERUS-LEASHED <>>

<ROUTINE CERBERUS-FCN ()
	 <COND (<AND <VERB? WAVE RUB RAISE> <EQUAL? ,PRSO ,WAND>>
		<TELL "The dog looks puzzled." CR>
		<RFALSE>)
	       (<AND ,WAND-ON <VERB? SAY INCANT>> <RFALSE>)
	       (<HELLO? ,CERBERUS>
		<COND (,CERBERUS-LEASHED <TELL "\"Arf! Arf! Arf!\"" CR>)
		      (T <TELL "\"Grrrr!\"" CR>)>)
	       (<VERB? ATTACK MUNG STAB>
		<COND (,CERBERUS-LEASHED
		       <REMOVE ,CERBERUS>
		       <TELL
"With a quiet bark of disappointment, the creature expires.
Its six eyes look at you reproachfully. As it dies, it collapses
into a small pile of dust which blows away into nothing." CR>)
		      (<PROB 50>
		       <JIGS-UP
"The dog-thing snaps at you viciously, and succeeds. Your head, it seems,
is only a small mouthful for the poor animal, who is just as hungry
afterward.">)
		      (T
		       <TELL
"The maddened dog-thing snaps viciously at you." CR>)>)
	       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,COLLAR>>
		<MOVE ,COLLAR ,CERBERUS>
		<FSET ,COLLAR ,NDESCBIT>
		<FSET ,COLLAR ,TRYTAKEBIT>
		<PUTP ,CERBERUS ,P?LDESC
"An insipidly grinning three-headed dog is wagging its tail here.
It is wearing a huge dog collar.">
		<SETG CERBERUS-LEASHED T>
		<TELL
"The creature whines happily, then the center head
licks your face (which is roughly like experiencing a sandpaper
washcloth). The other two heads look about, as though the
monster felt a sudden need to find a pair of slippers somewhere.
Its huge tail wags enthusiastically, knocking small rocks
around and almost blowing you over from the breeze it creates." CR>)
	       (<VERB? ENCHANT>
		<COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		       <SETG SPELL-HANDLED? T>
		       <TELL
"The huge dog rises about an inch off the ground, for a moment." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FIERCE>
		       <SETG SPELL-HANDLED? T>
		       <JIGS-UP
"Cerberus tears you limb from limb! What ferocity!">)
		      (<EQUAL? ,SPELL-USED ,W?FEEBLE>
		       <TELL
"What an effect! He now has the strength of just one elephant, rather
than ten!" CR>)>)
	       (<NOT ,CERBERUS-LEASHED>
		<TELL "The three-headed dog snaps at you viciously!" CR>)
	       (<AND ,CERBERUS-LEASHED <VERB? RUB>>
		<TELL
"The dog is now insanely happy, slobbering all over the place and
whining with uncontained doggish joy." CR>)>>

<ROUTINE COLLAR-FCN ()
	 <COND (<AND <VERB? TAKE> ,CERBERUS-LEASHED>
		<JIGS-UP
"That wasn't such a good idea. The creature was enjoying being your pet.
As you unfasten the collar, the disappointed monster hound begins to growl,
and then its three fang-crammed mouths rend you into little doggy biscuits.">)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<PERFORM ,V?ENCHANT ,CERBERUS>
		<RTRUE>)>>

\

"SUBTITLE DRAGON AND GLACIER"

<GLOBAL ICE-MELTED <>>

<ROUTINE GLACIER-FCN ()
	 <COND (<VERB? MELT>
		<TELL
"This is a big glacier; you'll need a lot of heat." CR>)>>

<ROUTINE GLACIER-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large hall of ancient lava, since worn smooth by the movement
of a glacier. A large passage exits to the east and an upward lava tube
is at the top of a jumble of fallen rocks." CR>
		<COND (,ICE-MELTED
		       <TELL
"A damp and scorched passage leads west. It is still partly full of
steam." CR>)>
		<RTRUE>)>>

<ROUTINE DRAGON-FCN ()
	 <ENABLE <QUEUE I-DRAGON -1>>
	 <COND (<HELLO? ,DRAGON>
		<TELL
"The dragon looks amused. He speaks in a voice so deep you feel it
rather than hear it, but the tongue is unknown to you. You find
yourself almost hypnotized." CR>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>)
	       (<VERB? EXAMINE>
		<TELL
"He turns and looks back at you, his cat's eyes yellow in the gloom.
You start to feel weak, and quickly turn away." CR>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 1>>)
	       (<VERB? ATTACK MUNG KICK LAMP-ON>
		<COND (<OR <VERB? LAMP-ON>
			   <AND <VERB? ATTACK> <NOT ,PRSI>>>
		       <TELL
"With your bare hands? I doubt the dragon even noticed." CR>)
		      (T
		<TELL <RANDOM-ELEMENT ,DRAGON-ATTACKS> CR>)>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 4>>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,DRAGON>>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 1>>
		<COND (<GETPT ,PRSO ,P?VALUE>
		       <MOVE ,PRSO ,CHEST>
		       <TELL
"The dragon is pleased by your gift, excuses himself for a moment,
and returns without it." CR>)
		      (<BOMB? ,PRSO>
		       <SETG DRAGON-ANGER <+ ,DRAGON-ANGER 2>>
		       <REMOVE ,BRICK>
		       <TELL
"The dragon snakes his long red tongue around the bomb and politely
swallows it. A few moments later he belches and smoke curls out of
his nostrils." CR>)
		      (T
		       <TELL "The dragon refuses your gift." CR>)>)
	       (<AND <VERB? WALK>
		     <EQUAL? ,HERE ,DRAGON-ROOM>
		     <EQUAL? ,PRSO ,P?NORTH>>
		<SETG DRAGON-ANGER <+ ,DRAGON-ANGER 3>>
		<TELL
"The dragon puts out a claw, grins (all of his sword-sharp teeth
glinting in the light), and blocks your way." CR>)>>

<GLOBAL DRAGON-ANGER 0>

<GLOBAL DRAGON-ATTACKS
        <LTABLE
"Dragon hide is tough as steel, but you have succeeded in annoying him
a bit. He looks at you as if deciding whether or not to eat you."
"That captured his interest. He stares at you balefully."
"The dragon is surprised and interested (for the moment)."
"You've made him rather angry. You had better be very careful now."
"That did no damage, but he turns his smoky yellow eyes in your direction
and sighs.">>

<ROUTINE HELLO? (WHO)
	 <COND (<OR <EQUAL? ,WINNER .WHO>
		    <VERB? TELL ANSWER REPLY SAY HELLO INCANT>>
		<COND (<VERB? TELL ANSWER SAY INCANT REPLY>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>)>
		<RTRUE>)>>

<ROUTINE FIND-TARGET (TARGET "AUX" P TX L ROOM)
	 <COND (<IN? .TARGET ,HERE> ,HERE)
	       (T
		<SET P 0>
		<REPEAT ()
			<COND (<0? <SET P <NEXTP ,HERE .P>>>
			       <RETURN <>>)
			      (<NOT <L? .P ,LOW-DIRECTION>>
			       <SET TX <GETPT ,HERE .P>>
			       <SET L <PTSIZE .TX>>
			       <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
				      <SET ROOM <GETB .TX 0>>
				      <COND (<IN? .TARGET .ROOM>
					     <RETURN .ROOM>)>)>)>>)>>

<GLOBAL OLD-HERE DRAGON-ROOM>

<ROUTINE I-DRAGON ("AUX" ROOM)
	 <COND (<G? ,DRAGON-ANGER 6>
		<TELL
"The dragon tires of this game. With an almost bored yawn, he opens his
mouth and ">
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <TELL
"blasts you with a great gout of fire, but it washes over you
harmlessly." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <JIGS-UP
"incinerates you in a blast of white-hot dragon fire.">)>)
	       (<AND <IN? ,WINNER ,DRAGON-ROOM>
		     <NOT <IN? ,DRAGON ,DRAGON-ROOM>>>
		<MOVE ,DRAGON ,DRAGON-ROOM>
		<TELL
"The dragon doubles back and charges into the room, maddened by your
attempt to sneak past him. His eyes glow with a white heat of anger." CR>
		<COND (<EQUAL? ,SPELL? ,S-FIREPROOF>
		       <JIGS-UP
"A huge ball of flame envelops you, but you don't even feel the heat.
The dragon is puzzled, but not too puzzled to crush you in his jaws.">)
		      (T
		       <JIGS-UP
"Worse for you, his mouth opens and a great gout of flame puffs out
and consumes you on the spot.">)>)
	       (<NOT <G? ,DRAGON-ANGER 0>>
		<COND (<AND <PROB 50>
			    <IN? ,DRAGON ,HERE>>
		       <TELL "The dragon looks bored." CR>)
		      (T
		       <DRAGON-LEAVES>
		       <COND (<EQUAL? ,HERE ,GLACIER-ROOM>
			      <TELL
"The dragon is no longer around. He must have become bored with you." CR>)
			     (<EQUAL? ,HERE ,OLD-HERE>
			      <TELL
"The dragon seems to have lost interest in you.">
			      <COND (<EQUAL? ,OLD-HERE ,DRAGON-ROOM> <CRLF>)
				    (T <TELL " He wanders off." CR>)>)>)>)
	       (T
		<SET ROOM <FIND-TARGET ,WINNER>>
		<COND (<NOT .ROOM>
		       <COND (<PROB 25> <DRAGON-LEAVES>)>)
		      (<OR <EQUAL? .ROOM ,CAROUSEL-ROOM ,TINY-ROOM>
			   <EQUAL? .ROOM ,RAVINE-LEDGE ,FRESCO-ROOM>>
		       <COND (<PROB 25> <DRAGON-LEAVES>)>
		       <TELL "The dragon will follow no further." CR>)
		      (<EQUAL? .ROOM ,GLACIER-ROOM>
		       <TELL CR
"As the dragon enters, he sees his reflection on the icy surface of the
glacier at its western end. He becomes enraged: There is another dragon here,
behind that glass, he thinks! Dragons are smart, but sometimes naive, and
this one has never seen ice before. He rears up to his full height to
challenge this intruder into his territory. He roars a challenge! The
intruder responds! The dragon takes a deep breath, and out of his mouth
pours a massive gout of flame. It washes over the ice, which melts rapidly,
sending out torrents of water and a huge cloud of steam! You manage to clamber
up to a small shelf, but the dragon is terrified! A huge splash goes down his
throat! There is a muffled explosion and the dragon, a puzzled expression on
his face, dies. He is carried away by the water.|
|
When the flood recedes you climb gingerly down. While no trace of
the dragon can be found, the melting of the ice has revealed a passage
leading west." CR>
		       <REMOVE ,DRAGON>
		       <REMOVE ,ICE>
		       <MOVE ,DEAD-DRAGON ,DEEP-FORD>
		       <DISABLE <INT I-DRAGON>>
		       <SCORE-UPD 5>
		       <SETG ICE-MELTED T>)
		      (T
		       <COND (<NOT <EQUAL? .ROOM ,OLD-HERE>>
			      <MOVE ,DRAGON .ROOM>
			      <TELL
"The dragon follows you, out of mingled curiosity and anger." CR>)
			     (T
			      <TELL
"The dragon continues to watch you carefully." CR>)>
		       <COND (<NOT <G? ,DRAGON-ANGER 0>>
			      <SETG DRAGON-ANGER 0>
			      <DISABLE <INT I-DRAGON>>)>)>)>
	 <SETG OLD-HERE <LOC ,DRAGON>>
	 <SETG DRAGON-ANGER <- ,DRAGON-ANGER 2>>
	 <COND (<L? ,DRAGON-ANGER 0> <SETG DRAGON-ANGER 0>)>
	 T>

<ROUTINE DRAGON-LEAVES ()
	 <COND (<NOT <LOC ,DEAD-DRAGON>>
		<MOVE ,DRAGON ,DRAGON-ROOM>
		<SETG DRAGON-ANGER 0>
		<DISABLE <INT I-DRAGON>>)>>

<ROUTINE I-GARDEN ()
	 <COND (<OR <EQUAL? ,HERE ,GARDEN-NORTH ,GAZEBO-ROOM>
		    <EQUAL? ,HERE ,TOPIARY-ROOM ,FORMAL-GARDEN>>
		<COND (<AND <IN? ,UNICORN ,GARDEN-NORTH>
			    <PROB 33>>
		       <REMOVE ,UNICORN>
		       <COND (<NOT <EQUAL? ,HERE ,TOPIARY-ROOM>>
			      <TELL "The unicorn bounds lightly away." CR>)>)
		      (<AND <IN? ,PRINCESS ,DRAGON-LAIR>
			    <NOT <IN? ,UNICORN ,GARDEN-NORTH>>
			    <PROB 25>
			    <NOT <EQUAL? ,HERE ,TOPIARY-ROOM>>>
		       <COND (,UNICORN-FRIGHTENED
			      <SETG UNICORN-FRIGHTENED <>>
			      <RFALSE>)>
		       <MOVE ,UNICORN ,GARDEN-NORTH>
		       <COND (<EQUAL? ,HERE ,GARDEN-NORTH>
			      <TELL <RANDOM-ELEMENT ,UNICORN-MSGS> CR>)
			     (T <TELL
"A unicorn is peacefully cropping grass at the north end of the garden.
There is something hanging around its neck." CR>)>)
		      (<EQUAL? ,HERE ,TOPIARY-ROOM>
		       <COND (<AND <NOT ,TOPIARY-MOVED> <PROB 12>>
			      <SETG TOPIARY-MOVED T>
			      <TELL
"You look around, and strangely, the topiary animals seem to have
changed position slightly." CR>)
			     (<AND ,TOPIARY-MOVED
				   <NOT ,TOPIARY-NEAR>
				   <PROB 8>>
			      <SETG TOPIARY-NEAR T>
			      <TELL
"The topiary animals seem to close in on you. You turn and they are
very close. They seem to be leering at you." CR>)
			     (<AND ,TOPIARY-NEAR <PROB 4>>
			      <SETG TOPIARY-MOVED <>>
			      <SETG TOPIARY-NEAR <>>
			      <JIGS-UP
"The topiary animals attack! You are crushed by their branches and
clawed by their thorns.">)>)>)
	       (T
		<REMOVE ,UNICORN>
		<DISABLE <INT I-GARDEN>>
		<RFALSE>)>>

<GLOBAL TOPIARY-MOVED <>>
<GLOBAL TOPIARY-NEAR <>>

<GLOBAL UNICORN-MSGS
	<LTABLE
	 "There is a large, white animal partly hidden behind some trees."
	 "You catch a glimpse of something white between two hedges."
	 "A unicorn is cropping grass on the other side of the room.
A gold key hangs from a ribbon around its neck."
	 "There is a beautiful unicorn eating roses here. Around his
neck is a red satin ribbon on which is strung a tiny key.">>

<ROUTINE GARDEN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-GARDEN -1>>)>>

<ROUTINE GLOBAL-UNICORN-FCN ()
	 <COND (<IN? ,UNICORN ,GARDEN-NORTH>
		<TELL
"The unicorn is way up at the north end of the garden." CR>)
	       (<VERB? FIND FOLLOW>
		<COND (<FSET? ,UNICORN ,TOUCHBIT>
		       <TELL "I don't know where it is now." CR>)
		      (T <TELL
"The unicorn is a mythical beast." CR>)>)
	       (T
		<TELL
"Unicorn? What unicorn?" CR>)>>

<ROUTINE UNICORN-FCN ()
	 <COND (<HELLO? ,UNICORN>
		<TELL
"The unicorn listens distractedly, then goes back to cropping grass." CR>)
	       (<VERB? FOLLOW>
		<TELL
"The unicorn shies away as you approach." CR>)
	       (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,UNICORN>>
		<TELL
"The unicorn shies away as you approach for a closer look, but you do
notice a tiny gold key hanging from a red satin ribbon looped around
the animal's neck." CR>)
	       (<VERB? EXAMINE>
		<TELL "The unicorn shies away as you approach." CR>)
	       (<VERB? TAKE PUT RUB MUNG ATTACK>
		<REMOVE ,UNICORN>
		<SETG UNICORN-FRIGHTENED T>
		<TELL
"The unicorn, unsurprised by this evidence that you are indeed the
uncouth sort of vagabond it suspected you were, melts into the hedges
and is gone." CR>)>>

<GLOBAL UNICORN-FRIGHTENED <>>

<ROUTINE GAZEBO-FCN ()
	 <COND (<AND <EQUAL? ,HERE ,GARDEN-NORTH> <VERB? THROUGH>>
		<DO-WALK ,P?IN> <RTRUE>)
	       (<AND <EQUAL? ,HERE ,GAZEBO-ROOM>
		     <VERB? THROUGH>>
		<TELL "You're already in it." CR>)
	       (<AND <EQUAL? ,HERE ,GAZEBO-ROOM> <VERB? LEAVE EXIT>>
		<DO-WALK ,P?OUT> <RTRUE>)>>

<ROUTINE CHEST-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<PROB 25>
		       <V-OPEN>
		       <COND (<AND <IN? ,PRINCESS ,HERE>
				   <NOT ,PRINCESS-AWAKE>>
			      <TELL
"The opening of the squeaky lid startles the young woman." CR>)>)
		      (T
		       <TELL
"The hinges are very rusty, but they seem to be starting to give.
You can probably open it if you try again. There is something
bumping around inside.">
		       <COND (<AND <IN? ,PRINCESS ,HERE>
				   <NOT ,PRINCESS-AWAKE>>
			      <TELL
" All this rummaging around has startled
the young woman.">)>
		       <CRLF>)>
		<PUTP ,CHEST ,P?ACTION 0>
		<COND (<AND <IN? ,PRINCESS ,HERE>
			    <NOT ,PRINCESS-AWAKE>>
		       <PERFORM ,V?ALARM ,PRINCESS>)>
		T)>>

<GLOBAL PRINCESS-AWAKE <>>

<ROUTINE PRINCESS-FCN ("AUX" (DEM <INT I-PRINCESS>))
	 <COND (<VERB? FOLLOW>
		<COND (<IN? ,PRINCESS ,HERE>
		       <TELL
"You can't follow her until she leaves..." CR>)
		      (,PRFOLLOW
		       <DO-WALK ,PRFOLLOW>)
		      (T
		       <TELL "I seem to have lost track of her." CR>)>
		<RTRUE>)
	       (<NOT <IN? ,PRINCESS ,HERE>>
		<TELL "There is no princess here." CR>)
	       (<VERB? ATTACK MUNG RAPE>
		<REMOVE ,PRINCESS>
		<TELL
"The princess screams as you approach. \"Won't someone deliver
me from this awful fate?\" she cries. ">
		<COND (<IN? ,WIZARD ,HERE>
		       <TELL
"Shocked, the Wizard of Frobozz turns toward you.">)
		      (ELSE
		       <TELL "Just in time, the Wizard of Frobozz
appears, seeming to unroll himself out of nothing like a window shade.">)>
		<TELL
" \"Fry!\" he intones, and a massive bolt of lightning reduces you to a pile
of smoking ashes. (Serves you right, too, if you ask me.)">
		<JIGS-UP>)
	       (<OR <HELLO? ,PRINCESS> <VERB? ALARM KISS EXAMINE RUB>>
		<COND (<AND <IN? ,PRINCESS ,DRAGON-LAIR>
			    <EQUAL? <GET .DEM ,C-ENABLED?> 0>>
		       <PUTP ,PRINCESS ,P?LDESC
"There is a dishevelled and slightly unkempt princess here.">
		       <ENABLE <QUEUE I-PRINCESS 2>>
		       <SETG PRINCESS-AWAKE T>
		       <TELL
"The princess (for she is obviously one) shakes herself awake, then
notices you for the first time. She smiles. \"Thank you for rescuing
me from that horrid worm,\" she says. \"I must depart. My parents will
be worried about me.\" With that, she arises, looking purposefully out
of the lair." CR>)
		      (T
		       <TELL
"The princess ignores you. She looks about the room, but her eyes
fix on the ">
		       <COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
			      <TELL "garden outside">)
			     (<EQUAL? ,HERE ,GARDEN-NORTH>
			      <TELL "gazebo">)
			     (<EQUAL? ,HERE ,RAVINE-LEDGE>
			      <TELL "ledge">)
			     (T
			      <TELL <GET ,PRDIRS <* ,PRCOUNT 4>>>)>
		       <TELL "." CR>)>)
	       (<NOT ,PRINCESS-AWAKE>
		<TELL "She's in a trance!" CR>)>>

<GLOBAL PRCOUNT 0>

<GLOBAL PRFOLLOW <>>

<GLOBAL PRDIRS
	<TABLE "south" DRAGON-ROOM "north" P?SOUTH
	       "east" LEDGE-TUNNEL "west" P?EAST
	       "east" RAVINE-LEDGE "west" P?EAST
	       "down" DEEP-FORD "up" P?DOWN
	       "south" MARBLE-HALL "north" P?SOUTH
	       "east" STREAM-PATH "west" P?EAST
	       "east" FORMAL-GARDEN "west" P?EAST
	       "north" GARDEN-NORTH "south" P?NORTH
	       "in" GAZEBO-ROOM "out" P?IN>>

<ROUTINE I-PRINCESS ("AUX" (DEM <INT I-PRINCESS>) (OLDP <LOC ,PRINCESS>)
		     (PC <* ,PRCOUNT 4>))
	 <MOVE ,PRINCESS <GET ,PRDIRS <+ .PC 1>>>
	 <SETG PRFOLLOW <>>
	 <COND (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,MARBLE-HALL>>
		<TELL
"The princess presses a loose piece of marble in the wall and a large
section of the wall slides away, revealing a passage to the east. She
enters it." CR>
		<COND (<IN? ,WINNER .OLDP>
		       <SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>)>
		<SETG SECRET-DOOR T>)
	       (<AND <IN? ,PRINCESS ,STREAM-PATH>
		     <IN? ,WINNER ,STREAM-PATH>>
		<SETG SECRET-DOOR T>
		<TELL
"The princess appears from behind some rocks, as though she had walked
through a wall." CR>)
	       (<IN? ,WINNER .OLDP>
		<SETG PRFOLLOW <GET ,PRDIRS <+ .PC 3>>>
	        <COND (<EQUAL? .OLDP ,GARDEN-NORTH>
		       <TELL "The princess enters the gazebo">
		       <COND (<FSET? ,GAZEBO-ROOM ,RMUNGBIT>
			      <TELL ", although you would never get past
the debris. She must be magically protected.">)>
		       <TELL "." CR>)
		      (<EQUAL? .OLDP ,RAVINE-LEDGE>
		       <TELL
"The princess climbs daintily down the rock face." CR>)
		      (T
		       <TELL "The princess walks ">
		       <TELL <GET ,PRDIRS .PC>>
		       <TELL ". She glances back at you as she goes." CR>)>)
	       (<IN? ,PRINCESS ,HERE>
		<COND (<EQUAL? ,HERE ,GAZEBO-ROOM>
		       <TELL "The princess joins you in the gazebo." CR>)
		      (<EQUAL? ,HERE ,DEEP-FORD>
		       <TELL "The princess climbs down the rock wall onto the beach." CR>)
		      (T
		       <TELL "The princess enters from the ">
		       <TELL <GET ,PRDIRS <+ 2 .PC>>>
		       <TELL ". She seems surprised to see you." CR>)>)>
	 <COND (<IN? ,PRINCESS ,GAZEBO-ROOM>
		<DISABLE .DEM>
		<ENABLE <QUEUE I-UNICORN 6>>)
	       (T
		<SETG PRCOUNT <+ ,PRCOUNT 1>>
		<ENABLE <QUEUE I-PRINCESS
			       <COND (<PROB 75> 1)(T 2)>>>)>
	 <RTRUE>>

<ROUTINE I-UNICORN ()
	 <COND (<EQUAL? ,HERE ,GAZEBO-ROOM ,GARDEN-NORTH>
		<MOVE ,ROSE ,WINNER>
		<FCLEAR ,GOLD-KEY ,NDESCBIT>
		<MOVE ,GOLD-KEY ,WINNER>
		<SCORE-OBJ ,GOLD-KEY>
		<PUTP ,GOLD-KEY ,P?ACTION 0>
		<TELL
"Shyly, a unicorn peeks out of the hedges. It notices the princess and
seems captivated. It approaches her and bows its head as though curtseying
to her. Around its neck is a red satin ribbon on which is strung a delicate
gold key. The princess takes the ribbon and uses it to tie up her hair. She
looks at you and then, smiling, hands you the key and a fresh rose which she
plucks from the arbor. \"You may have use of such a thing,\" she says. \"It
is the least I can do for one who rescued me from a fate I dare not
contemplate.\" With that, she mounts the unicorn (side-saddle, of course)
and rides off into the gloom." CR>
		<REMOVE ,PRINCESS>)
	       (T
		<REMOVE ,PRINCESS>
		<MOVE ,ROSE ,GAZEBO-ROOM>
		<RFALSE>)>>

\

"SUBTITLE WIZARD WORKSHOP AND ENVIRONS"

<ROUTINE MENHIR-ROOM-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-FLASH> ,MENHIR-POSITION>
		<DESCRIBE-MENHIR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large room which was evidently used once as a quarry. Many
large limestone chunks lie helter-skelter around the room. Some are
rough-hewn and unworked, others smooth and well-finished. One side of
the room appears to have been used to quarry building blocks, the other
to produce menhirs (standing stones). Obvious passages lead north and
south." CR>
		<COND (<IN? ,MENHIR ,LOCAL-GLOBALS>
		       <DESCRIBE-MENHIR>)>
		T)>>

<ROUTINE DESCRIBE-MENHIR ()
	 <COND (<EQUAL? ,HERE ,MENHIR-ROOM>
		<COND (<EQUAL? ,MENHIR-POSITION <>>
		       <TELL
"One particularly large menhir, at least twenty feet tall and eight feet
thick, is leaning against the wall blocking a dark opening leading
southwest. On this side of the menhir is carved an ornate letter \"F\"." CR>)
		      (<EQUAL? ,MENHIR-POSITION 1>
		       <TELL
"There is a huge menhir lying on the floor near a southwest passage." CR>)
		      (<EQUAL? ,MENHIR-POSITION 2>
		       <TELL
"A dark opening leads southwest." CR>)
		      (<EQUAL? ,MENHIR-POSITION 3>
		       <TELL "There is a huge menhir here." CR>)
		      (T
		       <TELL
"There is a huge menhir floating like a feather in midair here. A
passage to the southwest opens beneath it." CR>)>
		<COND (<EQUAL? ,HERE ,MUNGED-ROOM>
		       <TELL
"The explosion appears to have had no effect on the menhir." CR>)>
		<RTRUE>)
	       (T <TELL "A dark opening leads southwest." CR>)>>

<GLOBAL MENHIR-POSITION <>>

<ROUTINE MENHIR-FCN ()
	 <COND (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (,MENHIR-POSITION
		       <TELL
"Behind the menhir is some air and then a wall." CR>)
		      (T
		       <TELL
"The gap between the menhir and the wall is very narrow, but it is clear
that there is a sizeable room in there. Your light only reveals a part of
the far wall." CR>)>)
	       (<VERB? TAKE MOVE TURN>
		<TELL
"The menhir weighs many tons and is eight feet wide. You can't even get
a grip on it, much less move it." CR>)
	       (<VERB? READ> <TELL "\"F\"" CR>)
	       (<VERB? EXAMINE>
		<TELL
"It is nicely finished, and the letter \"F\" on it is particularly well
carved." CR>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<TELL
"The menhir floats majestically into the air, rising about ten feet.
The passage beneath it beckons invitingly." CR>
		<SETG MENHIR-POSITION 3>)
	       (<AND <VERB? DISENCHANT>
		     <EQUAL? ,SPELL-USED ,W?FLOAT>>
		<SETG MENHIR-POSITION <>>
		<COND (<EQUAL? ,HERE ,MENHIR-ROOM ,KENNEL>
		       <TELL
"The menhir sinks to the ground." CR>)>)>>

<GLOBAL GUARDIAN-FED <>>

<ROUTINE DOOR-KEEPER-FCN ()
	 <COND (<AND <VERB? ALARM> ,GUARDIAN-FED>
		<TELL "Try as you may, you can't wake it." CR>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,DOOR-KEEPER>>
		<COND (,GUARDIAN-FED
		       <TELL
"He is asleep, at least for the moment." CR>)
		      (<EQUAL? ,PRSO ,CANDY>
		       <SETG GUARDIAN-FED T>
		       <REMOVE ,CANDY>
		       <TELL
"The guardian greedily wolfs down the candy, including the package. (It
seemed to enjoy the grasshoppers particularly.) It then becomes
quiet and its eyes close. (Lizards are known to sleep a long time while
digesting their meals.)" CR>)
		      (<EQUAL? ,PRSO ,FLASK>
		       <TELL
"The lizard sniffs it experimentally, then looks at you angrily, hissing
and snapping." CR>)
		      (<BOMB? ,PRSO>
		       <REMOVE ,PRSO>
		       <TELL
"The guardian greedily wolfs it down. After a while, you hear a
very small pop and the guardian's eyes bulge out. It hisses nastily
at you." CR>)
		      (<EQUAL? ,PRSO ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
		       <TELL
"The guardian greedily gobbles the sphere, but finds it unchewable. He
then tries repeatedly to swallow it whole, with disappointing results.
Finally, he spits it on the ground." CR>
		       <MOVE ,PRSO ,HERE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"The lizard wolfs down the " D ,PRSO ", crunching greedily." CR>)>)
	       (<VERB? ATTACK MUNG>
		<TELL
"The guardian seems impervious to your attack. In fact, your blows
don't even seem to be landing." CR>)>>

<GLOBAL WIZ-DOOR-FLAG <>>

<ROUTINE WIZ-DOOR-FCN ()
	 <COND (<NOT ,GUARDIAN-FED>
		<COND (<VERB? OPEN>
		       <TELL
"The lizard comes to life and snaps at you as you reach for the
handle." CR>)
		      (<VERB? UNLOCK>
		       <TELL
"The lizard door keeper comes awake and bites at your hand. You
jerk away just in time.">
		       <COND (<AND <EQUAL? ,PRSI ,GOLD-KEY> <PROB 5>>
			      <REMOVE ,GOLD-KEY>
			      <TELL " The guardian does get the
key, though. It grins maniacally." CR>)
			     (<PROB 20>
			      <MOVE ,GOLD-KEY ,HERE>
			      <TELL " You drop the key, though." CR>)
			     (T <CRLF>)>)>)
	       (<VERB? UNLOCK>
		<COND (,WIZ-DOOR-FLAG
		       <TELL "It is already!" CR>)
		      (<EQUAL? ,PRSI ,GOLD-KEY>
		       <SETG WIZ-DOOR-FLAG T>
		       <TELL
"The key turns and the bolt clicks. The door is unlocked." CR>)
		      (T
		       <SETG WIZ-DOOR-FLAG <>>
		       <TELL "That won't unlock it." CR>)>)
	       (<VERB? LOCK>
		<COND (<NOT ,WIZ-DOOR-FLAG>
		       <TELL "It is locked already." CR>)
		      (<EQUAL? ,PRSI ,GOLD-KEY>
		       <TELL "The door is now locked." CR>
		       <SETG WIZ-DOOR-FLAG <>>
		       <RTRUE>)
		      (T <TELL "That won't lock it." CR>)>)
	       (<VERB? OPEN CLOSE>
		<COND (,WIZ-DOOR-FLAG
		       <OPEN-CLOSE ,PRSO
				   "The door creaks open."
				   "The door reluctantly closes.">)
		      (<VERB? OPEN>
		       <TELL "The door is locked!" CR>)>)>>

<ROUTINE GUARDIAN-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is cobwebby and musty, but tracks in the dust show that it has
seen visitors recently. At the south end of the room is a stained and
battered (but very strong-looking) door. To the north, a corridor exits." CR>
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL "The door is open." CR>)>
		<COND (<NOT ,GUARDIAN-FED>
		       <TELL
"Imbedded in the door is a nasty-looking lizard head, with sharp
teeth and beady eyes. ">
		       <COND (<IN? ,CANDY ,WINNER>
			      <TELL "The lizard is sniffing at you." CR>)
			     (T
			      <TELL
"The eyes move to watch you approach." CR>)>)
		      (T
		       <TELL
"A sleepy-looking lizard head is mounted on the door." CR>)>)>>

<ROUTINE WORKSHOP-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing in the entry hall of the Wizard's Workshop. Dark
corridors lead west and south from here. The corridor to the west
smells slightly of incense or candle smoke.">
		<COND (<FSET? ,WIZ-DOOR ,OPENBIT>
		       <TELL " The workshop door is open.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE ARCANA-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"The stuff on the bench appears to be so much junk, and you decide that
it would only get in your way if you took it." CR>)>>

<ROUTINE TROPHY-PSEUDO ()
	 <COND (<VERB? READ> <RFALSE>)
	       (<VERB? TAKE RUB>
		<TELL
"As your fingers near it, you get a nasty shock (but fortunately not a fatal
one)." CR>)>>

<ROUTINE STAND-FCN ()
	 <COND (<VERB? TAKE>
		<TELL "The " D ,PRSO " is firmly attached to the bench." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,PALANTIR-1 ,PALANTIR-2 ,PALANTIR-3>
		     <EQUAL? ,PRSI ,STAND-1 ,STAND-2 ,STAND-3>>
		<V-PUT>
		<COND (<AND <IN? ,PALANTIR-1 ,STAND-1>
			    <IN? ,PALANTIR-2 ,STAND-2>
			    <IN? ,PALANTIR-3 ,STAND-3>>
		       <REMOVE ,PALANTIR-1>
		       <REMOVE ,PALANTIR-2>
		       <REMOVE ,PALANTIR-3>
		       <MOVE ,STAND-4 ,WORKBENCH>
		       <TELL
"As you place the " D ,PRSO " in the " D ,PRSI ", a low humming noise
begins, and you can feel the hairs on the back of your neck begin to
stand up. The three spheres begin to vibrate, faster and faster, as
the noise becomes higher and higher pitched. Three puffs of smoke, one
red, one blue, one white, rise up from empty stands. The spheres are gone!
But in the center of the triangle formed by the stands is now a black stand
of obsidian in which rests a strange black sphere." CR>)>
		T)>>

<ROUTINE IN-AQUARIUM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"There is a sandy floor here, and your vision seems murky and blurred.
The wall you are looking at is nicely dressed stone." CR>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <COND (<PROB 25>
			      <TELL
"While you watch a shadow seems to pass overhead." CR>)
			     (<PROB 5>
			      <TELL
"The head of some horrible serpent pokes into view, its beady green eyes
almost seeming to see you." CR>)>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<IN? ,SERPENT ,AQUARIUM>
		       <JIGS-UP
"You drop into the aquarium with a splash (which attracts the serpent).
He greedily eats you. He's just a baby, after all, and needs all the
food he can get.">)
		      (T <JIGS-UP
"Oh dear, you have cut yourself severely on the broken glass. I'm afraid
you've bled to death.">)>)>>

<ROUTINE AQUARIUM-FCN ("AUX" OBJ)
	 <COND (<VERB? BOARD THROUGH> <DO-WALK ,P?IN> <RTRUE>)
	       (<AND <VERB? LOOK-INSIDE>
		     <IN? ,SERPENT ,AQUARIUM>>
		<TELL
"In the aquarium is a baby sea-serpent who eyes you suspiciously. His
scaly body writhes about in the huge tank." CR>)
	       (<OR <AND <VERB? MUNG ATTACK> <EQUAL? ,PRSO ,AQUARIUM>>
		    <AND <VERB? THROW> <EQUAL? ,PRSI ,AQUARIUM>>>
		<COND (<EQUAL? ,PRSO ,AQUARIUM>
		       <COND (<NOT ,PRSI> <RFALSE>)
			     (T <SET OBJ ,PRSI>)>)
		      (T <SET OBJ ,PRSO>)>
		<MOVE .OBJ ,HERE>
		<COND (<IN? ,DEAD-SERPENT ,HERE>
		       <TELL
"The aquarium is already broken!" CR>
		       <RTRUE>)
		      (<EQUAL? .OBJ ,FLASK>
		       <JIGS-UP
"The flask shatters, and poison gas fills the room!">
		       <RTRUE>)
		      (<BOMB? .OBJ>
		       <DISABLE <INT I-FUSE>>)
		      (<OR <FSET? .OBJ ,WEAPONBIT>
			   <G? <GETP .OBJ ,P?SIZE> 10>>
		<REMOVE ,SERPENT>
		<MOVE ,PALANTIR-3 ,AQUARIUM>
		<FCLEAR ,PALANTIR-3 ,NDESCBIT>
		<PUTP ,AQUARIUM ,P?LDESC
"A shattered aquarium fills the northern half of the room.">
		<MOVE ,DEAD-SERPENT ,HERE>
		<TELL
"The " D .OBJ " shatters the glass wall of the aquarium, spilling out
an impressive amount of salt water and wet sand. It also spills out an
extremely annoyed sea serpent who bites angrily at the " D .OBJ ", and
then at you. He is having difficulty breathing, and he seems to hold you
responsible for his current problem.">
		<COND (<VERB? MUNG>
		       <TELL
" He manages to rend you limb from limb before he drowns in the
air." CR>
		       <JIGS-UP "I guess you were too careless.">)
		      (T
		       <TELL
" He tries to slither across the stone floor towards you. Fortunately,
he expires mere inches away from biting off your foot. A clear crystal
sphere sits amid the sand and broken glass on the bottom of the
aquarium." CR>)>)
		      (T
		       <TELL
"The " D .OBJ " bounces harmlessly off the glass." CR>)>)>>

<ROUTINE SERPENT-FCN ()
	 <COND (<EQUAL? ,SERPENT ,WINNER>
		<TELL
"The serpent only stares hungrily at you." CR>)
	       (<VERB? ATTACK MUNG>
		<TELL
"He swims towards you with a powerful stroke of his flippers, dagger-like
teeth dripping. Fortunately, he doesn't want to crash into the aquarium
wall, and contents himself with splashing you with water." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSO ,SERPENT>>
		<TELL "Impossible for many reasons." CR>)
	       (<VERB? TAKE GIVE>
		<JIGS-UP
"He takes you instead. *Uurrp!*">)>>

<ROUTINE DEAD-SERPENT-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"This may only be a baby sea serpent, but it's as big as a small whale." CR>)>>

<ROUTINE GENIE-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" V HOARD)
	<COND (<VERB? HELLO>
	       <TELL
"The genie grins demonically, but says nothing." CR>)
	      (<EQUAL? ,WINNER ,GENIE>
	       <COND (<NOT ,GENIE-READY?>
		      <TELL
"\"My fee is not paid! I perform no tasks for free! We demons have a
strong union these days.\"" CR>
		      <RFATAL>)
		     (<VERB? SGIVE> <RFALSE>)
		     (<OR <G? <GET ,P-PRSO 0> 1>
			  <G? <GET ,P-PRSI 0> 1>>
		      <TELL
"\"I will do one thing only, oh gracious master!\"" CR>
		      <RFATAL>)
		     (<AND <VERB? MOVE> <EQUAL? ,PRSO ,GLOBAL-MENHIR>>
		      <SETG MENHIR-POSITION 1>
		      <TELL
"The demon is gone for a moment. \"A trifle... My little finger alone
was enough.\"" CR>
		      <GENIE-LEAVES>)
		     (<VERB? TAKE>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-MENHIR>
			     <REMOVE ,MENHIR>
			     <SETG MENHIR-POSITION 2>
			     <TELL
"The demon flashes away for a second. \"I have little use for such a
thing, but perhaps as a doorstop...\"" CR>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,WAND>
			     <TELL
"\"This I do gladly, oh fool!\" cackles the demon gleefully. He stretches
out an enormous hand towards the wand and taking it like a toothpick (this
is a large demon), points it at himself. \"Free!\" he commands, and the
demon and his wand vanish forever." CR>
			     <GENIE-LEAVES <>>
			     <REMOVE ,WAND>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <GENIE-LEAVES <>>
			     <REMOVE ,PRSO>
			     <TELL
"The demon snaps his fingers, the " D ,PRSO " spins wildly in the air in
front of him, then he and it depart." CR>)
			    (T
			     <TELL
"\"I fear that I cannot take such a thing.\"" CR>)>)
		     (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ME>>
		      <COND (<EQUAL? ,PRSO ,WAND>
			     <TELL
"\"I hear and obey!\" says the demon. He stretches out an enormous hand
towards the wand. The Wizard is unsure what to do, pointing it threateningly
at the demon, then at you. \"Fudge!\" he cries, but aside from a strong
odor of chocolate in the air, there is no effect. The demon plucks the
wand out of his hand (it's about toothpick-size to him) and gingerly lays
it before you. He fades into the smoke, which disperses.
The wizard runs from the room in terror." CR>
			     <REMOVE ,WIZARD>
			     <GENIE-LEAVES <>>
			     <FCLEAR ,WAND ,NDESCBIT>
			     <MOVE ,WAND ,HERE>)
			    (<EQUAL? ,PRSO ,GLOBAL-MENHIR>
			     <MOVE ,MENHIR ,PENTAGRAM-ROOM>
			     <FCLEAR ,MENHIR ,NDESCBIT>
			     <FCLEAR ,MENHIR ,TAKEBIT>
			     <SETG MENHIR-POSITION 3>
			     <TELL
"He waves his hands, and the menhir drops softly at your feet." CR>
			     <GENIE-LEAVES>)
			    (<FSET? ,PRSO ,TAKEBIT>
			     <MOVE ,PRSO ,PENTAGRAM-ROOM>
			     <TELL
"The " D ,PRSO " appears before you and settles to the ground." CR>
			     <GENIE-LEAVES>)
			    (T
			     <TELL
"\"Were it possible, this would be my fondest wish, but alas...\"" CR>)>)
		     (<VERB? ATTACK>
		      <COND (<EQUAL? ,PRSO ,GLOBAL-CERBERUS>
			     <TELL
"\"This may prove taxing, but we'll see. Perhaps I'll tame him for a
pup instead.\" The demon disappears for an instant, then reappears. He
looks rather gnawed and scratched. He winces. \"Too much for me. Puppy
dog, indeed. You're welcome to him. Never did like dogs anyway... Any
other orders, oh beneficent one?\"" CR>)
			    (<EQUAL? ,PRSO ,WIZARD>
			     <TELL
"The demon grins hideously. \"This has been my desire e'er since this
charlatan bent me to his service. I perform this deed with pleasure!\"
The demon forms himself back into a cloud of greasy smoke. The cloud
envelops the Wizard, who waves his wand fruitlessly, mumbling various
phrases which begin with \"F\". A horrible scream is heard, and the smoke
begins to clear. Nothing remains of the Wizard but his wand." CR>
			     <REMOVE ,WIZARD>
			     <FCLEAR ,WAND ,NDESCBIT>
			     <MOVE ,WAND ,HERE>
			     <GENIE-LEAVES>)
			    (<EQUAL? ,PRSO ,ME>
			     <GENIE-LEAVES <>>
			     <SETG WINNER ,ADVENTURER>
			     <JIGS-UP
"\"Foolish mortal, if you insist...\" The demon crushes you with one
blow of his enormous hand.">)
			    (T
			     <TELL 
"\"I know no way to kill a " D ,PRSO ".\"" CR>)>)
		     (<VERB? FIND EXAMINE>
		      <TELL
"\"I am not permitted to ">
		      <COND (<VERB? FIND>
			     <TELL "answer questions">)
			    (T <TELL "perform such menial tasks">)>
		      <TELL ". The terms of my contract
are explicit on this matter, learned one. Surely you would not wish to
violate my contract?\" He licks his lips with a forked tongue like a
snake's. \"The penalty clauses are ... hmm ... devilish.\"" CR>)
		     (T
		      <TELL
"\"Apologies, oh master, but even for such a one as I this is not possible.\"
He seems somewhat chagrined to have to admit this." CR>
		      <RTRUE>)>)
	      (<VERB? EXORCISE ATTACK MUNG>
	       <TELL
"The demon laughs uproariously." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,GENIE>>
	       <COND (<AND <EQUAL? ,PRSO ,IRON-BOX>
			   <IN? ,VIOLIN ,PRSO>>
		      <TELL
"The genie frowns briefly, then ">
		      <COND (<FSET? ,PRSO ,OPENBIT> <TELL "looks inside">)
			    (ELSE <TELL "opens">)>
		      <TELL " the box. He smiles horribly." CR>
		      <REMOVE-CAREFULLY ,IRON-BOX>
		      <SETG PRSO ,VIOLIN>)>
	       <COND (<AND <GETPT ,PRSO ,P?VALUE>
			   <NOT <EQUAL? ,PRSO ,SWORD>>>
		      <REMOVE-CAREFULLY ,PRSO>
		      <SETG GENIE-HOARD <+ ,GENIE-HOARD 1>>
		      <SCORE-UPD 2>
		      <SET HOARD <+ ,GENIE-HOARD <CASE-WORTH>>>
		      <COND (<NOT <L? .HOARD ,TREASURES-MAX>>
			     <SETG GENIE-READY? T>
			     <PUTP ,WIZARD ,P?LDESC
"A dejected and fearful Wizard watches from the corner.">
			     <TELL
"\"This will do for my fee. 'Tis a paltry hoard, but as you have done
me a small service by loosing me from this wizard, it will suffice.\"" CR>)
			    (T
			     <TELL
"\"" <GET ,GENIE-THANKS .HOARD> "\"" CR>
			     <COND (<EQUAL? .HOARD 8>
				    <TELL
"The Wizard looks at you as if you are a madman. He tears his beard and
stares at you fearfully." CR>)>
			     <RTRUE>)>)
		     (<BOMB? ,PRSO>
		      <GENIE-LEAVES <>>
		      <TELL
"\"I fear that this violates my contract, oh foolish one. Thus, I am
free to depart.\"" CR>)
		     (T
		      <REMOVE-CAREFULLY ,PRSO>
		      <TELL
"The demon gladly takes the " D ,PRSO " and smiles balefully,
revealing enormous fangs." CR>)>)>>

<ROUTINE GENIE-LEAVES ("OPTIONAL" (NOISY? T))
	 <FSET ,GENIE ,INVISIBLE>
	 <COND (.NOISY?
		<TELL "The genie departs, his agreement fulfilled." CR>)>
	 <SETG P-CONT <>>
	 <RFATAL>>

<GLOBAL GENIE-READY? <>>
<GLOBAL GENIE-HOARD 0>
<CONSTANT TREASURES-MAX 10>	;"all treasures but palantirs(4),
				  candy, collar, wand."

<GLOBAL GENIE-THANKS <LTABLE
"Most fine, master! But 'tis not enough. I will do a great service,
and are not great services bought at great price?"
"Very nice, but not enough!"
"Ah, truly magnificent! Keep them coming."
"Almost halfway there, oh worthy one!"
"Oh, such beauty! Your generosity almost overwhelms me!"
"Truly I shall do thee a wonderful service when thou hast finished!"
"Truly you are most generous! But still, this is yet not enough."
"A fine gift, mighty one, you have almost reached my fee."
"Wondrous fine, master! But one treasure is yet to be given!">>

<ROUTINE CASE-WORTH ("AUX" F (W 0))
	 <SET F <FIRST? ,WIZARD-CASE>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .W>)>
		 <COND (<GETPT .F ,P?VALUE>
			<SET W <+ .W 1>>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE PENTAGRAM-FCN ("OPTIONAL" (RARG ,M-BEG))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? THROUGH BOARD>
		       <TELL
"You try to enter the pentagram, but are forced back by an invisible
power." CR>)
	              (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,PALANTIR-4>>
		       <REMOVE ,PALANTIR-4>
		       <FCLEAR ,GENIE ,INVISIBLE>
		       <MOVE ,GENIE ,PENTAGRAM-ROOM>
		       <TELL
"A cold wind blows outward from the sphere. The candles flicker, and a
low moan, almost inaudible, is heard. It rises in volume and pitch
until it becomes a high-pitched keening. A dim shape becomes visible in
the air above the sphere. The shape resolves into a large and somewhat
formidable looking demon. He looks around, tests the walls of the
pentagram experimentally, then sees you! \"Hmm, a new master...\" he
says under his breath. \"Greetings, oh master! Wouldst desire a
service, as our contract stateth? For some pittance of wealth, some
trifle, I will gratify thy desires to the utmost limit of my powers, and
they are not inconsiderable.\" He makes a pass with his massive arms and
the walls begin to shake a little. Another pass and the shaking stops.
\"A nice effect... I find it makes for a better relationship to give
such a demonstration early on.\" He grins vilely." CR>)>)>>

<ROUTINE WIZARD-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" OLIT)
	 <COND (<EQUAL? ,WINNER ,WIZARD>
		<COND (<VERB? GIVE> <TELL
"The Wizard replies \"Foolishment!\"" CR>)
		      (T
		       <TELL
"The Wizard considers your statement carefully. His expression indicates
he regards it as fanciful." CR>)>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,WIZARD>>
		<SET OLIT ,LIT>
		<REMOVE-CAREFULLY ,PRSO>
		<COND (<BOMB? ,PRSO>
		       <COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"The wizard accepts this final folly resignedly." CR>)
			     (T
			      <REMOVE ,WIZARD>
			      <TELL
"\"Hmm...\" The Wizard mutters something, then waves his wand over the
bomb. It transforms into a bouquet of flowers. Both Wizard and
flowers disappear." CR>)>)
		      (<AND .OLIT <NOT ,LIT>>
		       <TELL
"\"Thank you.\" As the Wizard places the " D ,PRSO " under his robe, the
room becomes dark." CR>)
		      (T
		       <TELL "\"Thank you.\"" CR>)>)
	       (<HELLO? ,WIZARD>
		<TELL
"The Wizard seems surprised, much as you might be if a dog talked." CR>)
	       (<VERB? ATTACK MUNG>
		<REMOVE ,WIZARD>
		<COND (<IN? ,WAND ,WIZARD>
		       <TELL
"The Wizard retreats, waving his wand and chanting. He says \"Fear!\"
">)
		      (T
		       <TELL
"The Wizard tries to cast the \"Fear!\" spell, but without his wand!
">)>
		<COND (<NOT <FSET? ,GENIE ,INVISIBLE>>
		       <TELL
"Nothing happens! With a terrified glance at the demon, the wizard
runs past you and out of the room." CR>)
		      (T
		       <TELL
"You are suddenly terrified. The Wizard seems huge and terrible,
looming over you. You flee, terrified. He chuckles, snaps his fingers, and
disappears." CR CR>
		       <SETG SPELL? ,S-FEAR>
		       <PUTP ,ADVENTURER ,P?ACTION MAGIC-ACTOR>
		       <ENABLE <QUEUE I-WIZARD 10>>
		       <RANDOM-WALK>)>)>>

<ROUTINE I-WIZARD ("AUX" CAST-PROB (PCNT 0) F (WLOC <LOC ,WINNER>))
	 <ENABLE <QUEUE I-WIZARD 4>>
	 <COND (,DEAD <RFALSE>)
	       (,SPELL?
		<COND (<EQUAL? ,SPELL? ,S-FLOAT>
		       <COND (<EQUAL? ,HERE ,WELL-TOP>
			      <JIGS-UP
"You plunge to the bottom of the shaft as the spell wears off.">
			      <RTRUE>)
			     (<AND <FSET? ,HERE ,NONLANDBIT>
				   <NOT <EQUAL? ,HERE ,WELL-BOTTOM
						,VOLCANO-BOTTOM>>>
			      <JIGS-UP
"As the spell wears off, you find yourself making a half-gainer
towards the bottom of the volcano.">
			      <RTRUE>)>)
		      (<EQUAL? ,SPELL? ,S-FEEBLE>
		       <SETG LOAD-ALLOWED ,LOAD-MAX>)
		      (<EQUAL? ,SPELL? ,S-FIERCE>
		       <SETG SWORD-GLOW 0>)
		      (<EQUAL? ,SPELL? ,S-FUMBLE>
		       <SETG FUMBLE-NUMBER 7>
		       <SETG FUMBLE-PROB 8>)>
		<COND (<GET ,SPELL-STOPS ,SPELL?>
		       <TELL <GET ,SPELL-STOPS ,SPELL?> CR>)>
		<PUTP ,ADVENTURER ,P?ACTION 0>
		<SETG SPELL? <>>
		<RTRUE>)>
	 <COND (<IN? ,GENIE ,PENTAGRAM-ROOM>
		<DISABLE <INT I-WIZARD>> 
		<COND (<NOT <IN? ,WIZARD ,PENTAGRAM-ROOM>>
		       <MOVE ,WIZARD ,PENTAGRAM-ROOM>
		       <COND (<IN? ,WINNER ,PENTAGRAM-ROOM>
			      <TELL

"Suddenly the Wizard materializes in the room. He is astonished by what
he sees: his servant in deep conversation with a common adventurer! He
draws forth his wand, waves it frantically, and incants \"Frobizz!
Frobozzle! Frobnoid!\" The demon laughs heartily. \"You no longer
control the Black Crystal, hedge-wizard! Your wand is powerless! Your
doom is sealed!\" The demon turns to you, expectantly." CR>)>)>
		<RTRUE>)>
	 <COND (<AND <NOT ,LIT>
		     <FSET? ,LAMP ,RMUNGBIT>
		     <G? ,SCORE 200>>
		<SETG ALWAYS-LIT T>
		<SETG LIT T>
		<TELL
"In the darkness you hear the voice of the Wizard. \"Dear me, you seem
to have gotten into quite a pickle.\" He chuckles. \"Fluoresce!\" he
incants. It is no longer dark." CR>
		<RTRUE>)>
	 <COND (<AND <LOC ,WIZARD> <PROB 80>>
		<COND (<AND ,LIT <IN? ,WIZARD ,HERE>>
		       <TELL "The Wizard vanishes." CR>)>
		<REMOVE ,WIZARD>
		<RTRUE>)>
	 <COND (<PROB 10>
		<COND (<NOT ,LIT>
		       <TELL
"You feel a slight outrush of air as something moves nearby." CR>)
		      (<EQUAL? ,HERE ,POSTS-ROOM ,POOL-ROOM>
		       <TELL
"A huge and terrible wizard appears before you, as large as the largest
tree! He looks down on you as you would look upon a gnat!" CR>)
		      (<FSET? ,HERE ,NONLANDBIT>
		       <TELL
"The Wizard appears, floating nonchalantly in the air beside you. He
grins sideways at you." CR>)
		      (T
		       <TELL
"A strange little man in a long cloak appears suddenly in the room.
He is wearing a high pointed hat embroidered with astrological signs.
He has a long, stringy, and unkempt beard." CR>)>
		<COND (<IN? ,PALANTIR-4 ,ADVENTURER>
		       <COND (,LIT
			      <TELL
"The Wizard notices that you carry the Black Crystal, and with an
unseemly haste, he disappears." CR>)
			     (ELSE
			      <TELL
"You feel a sudden inrush of air as though something disappeared." CR>)>
		       <REMOVE ,WIZARD>
		       <RTRUE>)
		      (<PROB 20>
		       <COND (,LIT
			      <TELL
"He mutters something (muffled by his beard) and disappears as suddenly
as he came." CR>)
			     (ELSE
			      <TELL
"You hear low, confused muttering." CR>)>
		       <REMOVE ,WIZARD>
		       <RTRUE>)>
		<COND (<IN? ,PALANTIR-1 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<COND (<IN? ,PALANTIR-2 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<COND (<IN? ,PALANTIR-3 ,ADVENTURER>
		       <SET PCNT <+ .PCNT 1>>)>
		<SET CAST-PROB <- 80 <* .PCNT 20>>>
		<COND (,LIT
		       <TELL
"The Wizard draws forth his wand and waves it in your direction. It
begins to glow with a faint blue glow." CR>)
		      (ELSE
		       <TELL
"Suddenly, illuminated by the faint blue glow of a magic wand pointed
in your direction, you see the Wizard!" CR>)>
		<COND (<PROB .CAST-PROB>
		       <MOVE ,WIZARD ,HERE>
		       <SETG SPELL? <RANDOM ,SPELLS>>
		       <PUTP ,ADVENTURER ,P?ACTION MAGIC-ACTOR>
		       <ENABLE <QUEUE I-WIZARD 
				      <+ 5
					 <RANDOM <- 30 <* 5 .PCNT>>>>>>
		       <COND (<PROB 75>
			      <TELL
"The Wizard, in a deep and resonant voice, speaks the word \""
<GET ,SPELL-NAMES ,SPELL?> "!\" He then vanishes, cackling gleefully." CR>)
			     (T
			      <TELL
"The Wizard, almost inaudibly, whispers a word beginning with \"F,\"
and then disappears, chuckling nastily." CR>)>
		       <REMOVE ,WIZARD>
		       <COND (<GET ,SPELL-HINTS ,SPELL?>
			      <TELL <GET ,SPELL-HINTS ,SPELL?> CR>)>
		       <COND (<EQUAL? ,SPELL? ,S-FALL>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"You suddenly fall headlong out of the " D .WLOC " as though
someone had flipped it over." CR>
				     <COND (<EQUAL? ,HERE ,WELL-TOP>
					    <JIGS-UP
"You plummet to the bottom of the shaft.">)
					   (<AND <FSET? ,HERE ,NONLANDBIT>
						 <NOT <EQUAL? ,HERE
							      ,VOLCANO-BOTTOM
							      ,WELL-BOTTOM>>>
					    <JIGS-UP
"You make a rather messy swan dive to the bottom of the volcano.">)
					   (ELSE <MOVE ,WINNER ,HERE>)>)>)
			     (<EQUAL? ,SPELL? ,S-FLOAT>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
" You rise majestically out of the " D .WLOC ", coming to a stop about five
feet above it and to one side." CR>
				     <MOVE ,WINNER ,HERE>)
				    (T
				     <TELL
"Slowly, you and all your belongings rise into the air, stopping after
about five feet." CR>)>)
			     (<EQUAL? ,SPELL? ,S-FEEBLE>
			      <SETG LOAD-ALLOWED 50>
			      <COND (<SET F <FIRST? ,WINNER>>
				     <TELL
"In fact, you feel so weak that you drop the " D .F "." CR>
				     <MOVE .F .WLOC>)>)
			     (<EQUAL? ,SPELL? ,S-FEAR>
			      <COND (<FSET? .WLOC ,VEHBIT>
				     <TELL
"You cower in the corner of the " D .WLOC ", hoping the wizard
won't see you." CR>)
				    (T
				     <CRLF>
				     <RANDOM-WALK>)>)
			     (<EQUAL? ,SPELL? ,S-FUMBLE>
			      <SETG FUMBLE-NUMBER 3>
			      <SETG FUMBLE-PROB 25>
			      <COND (<SET F <FIRST? ,ADVENTURER>>
				     <TELL
"Ooops! You dropped the " D .F "." CR>
				     <MOVE .F .WLOC>)>)
			     (<EQUAL? ,SPELL? ,S-FILCH>
			      <COND (<ROB ,WINNER ,WIZARD-CASE>
				     <TELL
"Something you are carrying has disappeared!" CR>)>)
			     (<EQUAL? ,SPELL? ,S-FIERCE>
			      <TELL
"The Wizard mumbles something under his breath, and just before you
reach him, he vanishes." CR>)>
		       <RTRUE>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"There is a loud crackling noise. Blue smoke rises from out of the
Wizard's sleeve. He sighs and disappears." CR>)
		      (<PROB 50>
		       <REMOVE ,WIZARD>
		       <TELL
"The Wizard incants \"" <RANDOM-ELEMENT ,SPELL-NAMES> "!\" but nothing
happens. He shakes the wand. Nothing happens. With a slightly
embarrassed glance in your direction, he vanishes." CR>)
		      (T
		       <MOVE ,WIZARD ,HERE>
		       <TELL
"The Wizard seems about to say something, but thinks better of it,
and peers at you from under his bushy eyebrows." CR>)>)>>

<GLOBAL SPELL? <>>

<CONSTANT SPELLS 12>
<CONSTANT S-FEEBLE 1>
<CONSTANT S-FUMBLE 2>
<CONSTANT S-FEAR 3>
<CONSTANT S-FILCH 4>
<CONSTANT S-FREEZE 5>
<CONSTANT S-FALL 6>
<CONSTANT S-FERMENT 7>
<CONSTANT S-FIERCE 8>
<CONSTANT S-FLOAT 9>
<CONSTANT S-FIREPROOF 10>
<CONSTANT S-FENCE 11>
<CONSTANT S-FANTASIZE 12>

<GLOBAL SPELL-NAMES
	<LTABLE "Feeble" "Fumble" "Fear" "Filch" "Freeze"
		"Fall" "Ferment" "Fierce" "Float" "Fireproof"
		"Fence" "Fantasize">>

<GLOBAL SPELL-HINTS
	<LTABLE
"All at once you feel very tired."
<>
"You look at the Wizard in terror. You scramble away,
trying to get as far as possible from him."
<>
"Your limbs suddenly feel like they have turned to stone. You can't
move a muscle."
<>
"You begin to feel lightheaded."
"You rush at the Wizard, intending to tear him limb from limb."
<>
<>
<>
<>>>

<GLOBAL SPELL-STOPS
	<LTABLE
"You feel more energetic now."
<>
"You suddenly decide that the Wizard isn't that terrifying..."
<>
"Your little finger begins to twitch, and then your whole body is free
again."
<>
"Your head is clearer now."
"You feel cooler and less angry now."
"You sink quietly down again."
<>
<>
<>>>

<ROUTINE ROB (WHO WHERE "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<RIPOFF .X .WHERE> <SET ROBBED? T>)>
		 <SET X .N>>>

<ROUTINE RIPOFF (X WHERE)
	 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
		     <GETPT .X ,P?VALUE>
		     <NOT <EQUAL? .X ,PALANTIR-1>>
		     <NOT <EQUAL? .X ,PALANTIR-2>>
		     <NOT <EQUAL? .X ,PALANTIR-3>>
		     <NOT <EQUAL? .X ,GOLD-KEY>>
		     <NOT <EQUAL? .X ,CANDY>>>
		<MOVE .X .WHERE>
		<FSET .X ,TOUCHBIT>
		<RTRUE>)>>

<ROUTINE WIZARD-CASE-FCN ()
	 <COND (<EQUAL? ,WINNER ,GENIE>
		<COND (<VERB? MUNG OPEN>
		       <REMOVE ,WIZARD-CASE>
		       <MOVE ,BROKEN-CASE ,TROPHY-ROOM>
		       <TELL
"The demon smashes the case into smithereens. Everything in it smashes
as well." CR>)>)
	       (<AND <VERB? ENCHANT> <EQUAL? ,SPELL-USED ,W?FILCH>>
		<ROB ,WIZARD-CASE ,HERE>
		<SETG SPELL-HANDLED? T>
		<TELL
"The contents of the case are arrayed at your feet." CR>)
	       (<VERB? OPEN MUNG CLOSE TAKE>
		<TELL
"The case is protected by a fearful spell. You cannot touch it in any
way." CR>)>>

<GLOBAL SPELL-HANDLED? <>>	;"T if handled before I-SPELL runs"
<GLOBAL WAND-ON <>>
<GLOBAL SPELL-USED <>>
<GLOBAL SPELL-VICTIM <>>

<ROUTINE WAND-FCN ()
	 <COND (<AND <VERB? TAKE PUT GIVE> <IN? ,WAND ,WIZARD>>
		<COND (<EQUAL? ,WINNER ,ADVENTURER>
		       <TELL "The Wizard snatches it away." CR>)
		      (<EQUAL? ,WINNER ,ROBOT>
		       <JIGS-UP
"The Wizard snatches the wand away, muttering the word \"Float\" at the
robot. Unfortunately he has no floating-point processor and dies in a
vain attempt to divide 4.85 by 3.62.">)>)
	       (<AND <VERB? WAVE>
		     <EQUAL? ,PRSI ,GRUE>>
	        <TELL
"There is no grue in sight, but a hissing sound issues forth from the
darkness." CR>)
	       (<VERB? WAVE RUB RAISE>
		<COND (<AND <EQUAL? ,PRSO ,WAND>
			    <NOT <IN? ,WAND ,WINNER>>>
		       <TELL "You don't have the wand!" CR>
		       <RTRUE>)
		      (<OR ,WAND-ON ,SPELL-USED ,SPELL-VICTIM>
		       <COND (<PROB 5>
			      <JIGS-UP
"The wand was still recharging from its last use. It discharges magic all
over everything. You turn into a toad, the room fills with a fetid smell,
and all sorts of other grubby things happen. Then the wand explodes!">)
			     (T
			      <TELL
"A lot you know about magic! A magic wand takes a while to recharge
after use! You might cause it to short-circuit!" CR>)>
		       <RTRUE>)
		      (<VERB? WAVE>
		       <COND (<AND <EQUAL? ,PRSO ,WAND> ,PRSI>
			      <SETG WAND-ON ,PRSI>
			      <SETG WAND-ON-LOC ,HERE>)
			     (T <TELL "At what?" CR> <RTRUE>)>)
		      (<VERB? RUB>
		       <COND (<AND <EQUAL? ,PRSI ,WAND> ,PRSO>
			      <SETG WAND-ON ,PRSO>)
			     (T <TELL "Touch what?" CR> <RTRUE>)>)
		      (<VERB? RAISE>
		       <TELL "The wand grows warm and seems to vibrate." CR>
		       <RTRUE>)>
		<COND (,WAND-ON
		       <SETG SPELL-USED <>>
		       <SETG SPELL-VICTIM <>>
		       <COND (<EQUAL? ,WAND-ON ,ME ,WAND>
			      <SETG WAND-ON <>>
			      <TELL
"Fortunately a safety interlock prevents the fatal feedback loop that
this would cause." CR>)
			     (T
			      <TELL
"The wand grows warm, the " D ,WAND-ON " seems to glow dimly with
magical essences, and you feel suffused with power." CR>)>
		       <ENABLE <QUEUE I-WAND 2>>)>
		T)>>

<GLOBAL WAND-ON-LOC <>>

<ROUTINE I-WAND ()
	 <COND (<AND ,WAND-ON
		     <OR <EQUAL? ,WAND-ON-LOC ,HERE>
			 <IN? ,WAND-ON ,WINNER>>>
		<TELL
"The " D ,WAND-ON " stops glowing and the power within you weakens." CR>
		<SETG WAND-ON <>>
		<RTRUE>)
	       (T
		<SETG WAND-ON <>>
		<RFALSE>)>>

<ROUTINE WIZARD-QUARTERS-FCN (RARG "AUX" PICK L)
	 <COND (<EQUAL? .RARG ,M-LOOK ,M-FLASH>
		<TELL
"This is where the Wizard of Frobozz lives. The room is ">
		<SET L <GET ,WIZQDESCS 0>>
		<SET PICK <RANDOM .L>>
		<COND (<EQUAL? .PICK ,WIZQLAST>
		       <COND (<EQUAL? .PICK .L>
			      <SET PICK <- .PICK 1>>)
			     (T
			      <SET PICK <+ .PICK 1>>)>)>
		<SETG WIZQLAST .PICK>
		<TELL <GET ,WIZQDESCS .PICK> CR>)>>

<GLOBAL WIZQLAST 0>

<GLOBAL WIZQDESCS
	<LTABLE
"sparsely furnished and almost monkish in its austerity."
"an opulently furnished seraglio out of an Arabian folktale."
"decorated in the Louis XIV style."
"overhung with palm-trees and lianas. The only furniture is a hammock."
"constructed of delicate and wispy cloud-stuffs."
"furnished in plastic and metal and looks like the control deck of a
spaceship."
"a suburban bedroom out of the 1950's, complete with bunk beds."
"a dank and dimly lighted cave, its floor piled with furs and old bones.">>

<ROUTINE BRIDGE-FCN ()
	 <COND (<VERB? CROSS>
		<DO-WALK ,P?CROSS>)
	       (<VERB? LEAP>
		<JIGS-UP
"You execute a perfect swan-dive into the depths below.">)>>

;"misc. routines"

<ROUTINE STREAM-FCN ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "You can't swim in the stream." CR>)
	       (<VERB? CROSS>
		<TELL "You'll have to find a ford or a bridge." CR>)>>

<ROUTINE CHASM-FCN ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"For a change, you look before leaping. You realize you would
never survive." CR>)
	       (<VERB? CROSS>
		<TELL "You'll have to find a bridge." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"The " D ,PRSO " drops out of sight into the chasm." CR>
		<REMOVE ,PRSO>)>>

<ROUTINE TUNNEL-OBJECT ()
	 <COND (<AND <VERB? THROUGH> <GETPT ,HERE ,P?IN>>
		<DO-WALK ,P?IN> <RTRUE>)
	       (T <PATH-OBJECT>)>>

<ROUTINE STALA-PSEUDO ()
	 <COND (<VERB? TAKE MUNG>
		<TELL
"The only ones you can reach are too large to successfully break off." CR>)>>

<ROUTINE MOSS-FCN ()
	 <COND (<VERB? TAKE RUB>
		<TELL
"Some of the moss rubs off on you, but it stops glowing very quickly
once plucked from its environment." CR>)>>

<ROUTINE ROSE-BUSH-FCN ()
	 <COND (<VERB? TAKE>
		<TELL
"You prick your finger trying to take a rose, and jump back annoyed.
The rose almost seemed to move its thorns into your path." CR>)>>

<ROUTINE I-SPELL ()
	 <COND (<AND <NOT ,SPELL-HANDLED?> ,SPELL-VICTIM>
		<PERFORM ,V?DISENCHANT ,SPELL-VICTIM>)>
	 <SETG SPELL-HANDLED? <>>
	 <SETG WAND-ON <>>
	 <SETG SPELL-USED <>>
	 <SETG SPELL-VICTIM <>>>

<GLOBAL FANTASIES
	<LTABLE "pile of jewels" "gold ingot" "basilisk"
		"bulging chest" "yellow sphere" "grue"
		"convention of wizards" "copy of ZORK I">>

^/L

;"special-cased routines"

<ROUTINE V-DIAGNOSE ()
	 <COND (,DEAD <TELL "You are dead.">)
	       (<EQUAL? ,SPELL? ,S-FERMENT>
		<TELL "You are drunk.">)
	       (<EQUAL? ,SPELL? ,S-FEEBLE>
		<TELL "You seem unusually weak right now.">)
	       (<EQUAL? ,SPELL? ,S-FLOAT>
		<TELL "You seem somewhat light.">)
	       (<EQUAL? ,SPELL? ,S-FREEZE>
		<TELL "You are frozen stiff.">)
	       (ELSE <TELL "You are in perfect health.">)>
	 <CRLF>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "You have been killed ">
		<COND (<1? ,DEATHS> <TELL "once.">)
		      (<EQUAL? ,DEATHS 2> <TELL "twice.">)
		      (T <TELL "an awful lot.">)>
		<CRLF>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score ">
	 <COND (.ASK? <TELL "would be ">) (ELSE <TELL "is ">)>
	 <TELL N ,SCORE>
	 <TELL " (total of 400 points), in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 <TELL "This score gives you the rank of ">
	 <COND (<EQUAL? ,SCORE 400> <TELL "Master Adventurer">
		<COND (<NOT ,WON-FLAG>
		       <TELL ", but somehow you don't feel done">)>)
	       (<G? ,SCORE 360> <TELL "Wizard">)
	       (<G? ,SCORE 320> <TELL "Master">)
	       (<G? ,SCORE 240> <TELL "Adventurer">)
	       (<G? ,SCORE 160> <TELL "Junior Adventurer">)
	       (<G? ,SCORE 80> <TELL "Novice Adventurer">)
	       (<G? ,SCORE 40> <TELL "Amateur Adventurer">)
	       (T <TELL "Beginner">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (PLAYER? <>))
 	 #DECL ((PLAYER?) <OR ATOM FALSE>)
 	 <COND (.DESC <TELL .DESC CR>)>
	 <COND (<NOT <EQUAL? ,ADVENTURER ,WINNER>>
		<TELL "
|    ****  The " D ,WINNER " has died  ****
|
|">
		<REMOVE ,WINNER>
		<SETG WINNER ,ADVENTURER>
		<SETG HERE <LOC ,WINNER>>
		<RFATAL>)>
	 <PROG ()
	       <SCORE-UPD -10>
	       <TELL "
|    ****  You have died  ****
|
|">
	       <SETG DEAD T>
		 <SETG SPELL? <>>
		 <PUTP ,ADVENTURER ,P?ACTION 0>
		 <SETG DEATHS <+ ,DEATHS 1>>
		 <MOVE ,WINNER ,HERE>
		 <TELL
"Now, let's take a look here...
Well, you probably deserve another chance. I can't quite fix you
up completely, but you can't have everything." CR CR>
		 <FCLEAR ,DEAD-PALANTIR-1 ,TOUCHBIT>
		 <FCLEAR ,DEAD-PALANTIR-2 ,TOUCHBIT>
		 <FCLEAR ,DEAD-PALANTIR-3 ,TOUCHBIT>
		 <RANDOMIZE-OBJECTS>
		 <GOTO ,DEAD-PALANTIR-1>
		 <SETG P-CONT <>>
		 <KILL-INTERRUPTS>
		 <RFATAL>>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,INSIDE-BARROW>)>
	 <SET N <FIRST? ,WINNER>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<AND <EQUAL? .F ,BILLS ,PORTRAIT>
			     <OR <EQUAL? ,HERE ,VAULT ,DEPOSITORY ,OFFICE>
				 <EQUAL? ,HERE ,SMALL-ROOM>>>
			<MOVE .F ,HERE>)
		       (<OR <EQUAL? .F ,GOLD-KEY>
			    <EQUAL? .F ,CANDY>
			    <EQUAL? .F ,PALANTIR-1>
			    <EQUAL? .F ,PALANTIR-2>
			    <EQUAL? .F ,PALANTIR-3>>
			<MOVE .F ,CAROUSEL-ROOM>)
		       (<FSET? .F ,STAGGERED>
			<MOVE .F ,WIZARD-CASE>)
		       (ELSE
			<MOVE .F ,GAZEBO-ROOM>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-GNOME>>
	 <DISABLE <INT I-LEDGE>>
	 <DISABLE <INT I-NERVOUS>>
	 <DISABLE <INT I-ZGNOME-OUT>>
	 <DISABLE <INT I-ZGNOME>>
	 <DRAGON-LEAVES>
	 <DISABLE <INT I-MATCH>>
	 <RTRUE>>

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .W ,SWORD>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

<ROUTINE BUCKET-CONT ()
	 <COND (<AND <VERB? TAKE> <NOT <IN? ,WINNER ,BUCKET>>>
	        <TELL "You'll need to get in the bucket to reach it." CR>)>>