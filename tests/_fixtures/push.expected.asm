// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push this 20
@THIS
D=M
@20
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push that 42
@THAT
D=M
@42
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 3
@push.3
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@push.1
D=M
@SP
A=M
M=D
@SP
M=M+1
// push temp 8
@13
D=M
@SP
A=M
M=D
@SP
M=M+1
// push pointer 1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// push pointer 0
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
