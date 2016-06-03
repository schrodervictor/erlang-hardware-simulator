// This file contains bad formatted code on purpose.
// I'm really sorry for all this uglyness :)

@3 // Initial address
D=A

(BEGIN) // This code actually doesn't make sense, it's just a compilation test
    @4
    M=D+1
    @counter
    M=D
    @MAIN_LOOP
    0;JMP                                        // Lots of space here

(MAIN_LOOP)
    @counter
				M	=	M	+	1	//	What	about	a	bunch	of	tabs??
    @10
    D=A
    // Let's put some blank lines around, just for fun...

    

	

    // That's enough...
    @BEGIN
    D;JGT

(END)
    @counter
    M=0
    @END
    0;JMP



