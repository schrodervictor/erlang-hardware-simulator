// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// eq
@SP
AM=M-1
D=M
A=A-1
D=M-D
@comparison.2.PUSH.TRUE
D;JEQ
// (comparison.2.PUSH.FALSE)
    D=0
    @comparison.2.PUSH.END
    0;JMP
(comparison.2.PUSH.TRUE)
    D=-1
(comparison.2.PUSH.END)
    @SP
    A=M-1
    M=D
// push constant 20
@20
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 30
@30
D=A
@SP
A=M
M=D
@SP
M=M+1
// lt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@comparison.5.PUSH.TRUE
D;JLT
// (comparison.5.PUSH.FALSE)
    D=0
    @comparison.5.PUSH.END
    0;JMP
(comparison.5.PUSH.TRUE)
    D=-1
(comparison.5.PUSH.END)
    @SP
    A=M-1
    M=D
// push constant 30
@30
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 20
@20
D=A
@SP
A=M
M=D
@SP
M=M+1
// gt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@comparison.8.PUSH.TRUE
D;JGT
// (comparison.8.PUSH.FALSE)
    D=0
    @comparison.8.PUSH.END
    0;JMP
(comparison.8.PUSH.TRUE)
    D=-1
(comparison.8.PUSH.END)
    @SP
    A=M-1
    M=D
