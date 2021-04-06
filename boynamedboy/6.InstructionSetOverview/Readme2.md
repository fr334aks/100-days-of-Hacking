#### `Logical Operations`
- Summarized as follows:<br>
<p><t><t>and <dst> <src><br></p>
<p><t><t>or  <dst> <src><br></p
<p><t><t>xor <dst> <src><br></p>
<p><t><t>not <op><br></p>


#### `Shift Operations`
#### logical Shift
- Is a bitwise operation that shifts all bits of source register by the specified number of bits and places the result into the destination register
- Every bit in source operand is moved the specified number of bits positions and the newly vacant bit positions are filled with zeros
- General form of the instructions are:<br>
<p><t><t>shl <dest>, <imm><br></p>
<p><t><t>shl <dest>, cl<br></p>
<p><t><t>shr <dest>, <imm><br></p>
<p><t><t>shr <dest>, cl<br></p>
- <imm> and cl must be a number between 1 and 64
#### arithmetic shifts
- **left shift** works same way as a logical shift in terms of shifting bits; plus the leading sign bit is not preserved
- if resulting value does not fit, an overflow occurs.
- **right shift** works same way as a logical shift in terms of shifting bits; plus it treats operand as signed .i.e will extend one on most significant bit if the operand was negative.
- General form of the instructions is summarized as follows:<br>
<p><t><t>sal <dest>, <imm><br></p>
<p><t><t>sal <dest>, cl<br></p>
<p><t><t>sar <dest>, <imm><br></p>
<p><t><t>sar <dest>, cl<br></p>
- <imm> and cl must be a number between 1 and 64

#### `Rotate Operations`
- Rotate operation shifts bits within an operand, either left or right, with the bit shifted outside the operand rotated around and placed on the other end.<br>e.g.
100011 rotated 2 places to the<br>
(i)left would be would be: 001110<br>
(ii) right would be: 111000<br>
- General form of the instructions is summarized as follows:<br>
<p><t><t>rol <dest>, <imm><br></p>
<p><t><t>rol <dest>, cl<br></p>
<p><t><t>ror <dest>, <imm><br></p>
<p><t><t>ror <dest>, cl<br></p>
- <imm> and cl must be a number between 1 and 64

#### `Control instructions`
- include: if statements, if-else statements, etc.
- refer to conditional or unconditional jumping.
#### labels
- refers to target, or location to jump to, for control statements
- e.g. start of a loop may be marked as loopStart and code may be re-executed by jumping to that label
- terminatd by a semicolon(:) and defined only once.
- in yasm, labels are case sensitive
- examples of labels include:<br>
<t>loopStart:<br>
<t>last:<br>
#### Unconditional control instructions
- provide an unconditional jump to a specific location in program denoted by a label
- must be defined exactly once, accessible, and within scope from originating jump instruction.
- General format is a below:<br>
<p><t>jmp <label></p><br>and  example as follows:
<p><t>jmp loopStart</p><br>
<p><t>jmp last</p><br>
#### Conditional control instructions
- provides a conditional jump based on comparison, provides basic if statement functionality
- involves 2 steps, compare instruction and conditional jump instruction:
- General form of the instruction is:<br>
<p><t>cmp <op1> <op2></p><br>
where <op1> and <op2> are not changed and must be of the same size<br>
- <op1> cannot be an immediate but <op1> can be an intermediate value
- Conditional instructions include:<br>
(i) je -> jump equal<br>
(ii) jne -> jump not equal<br>
- Signed conditional control instructions include:<br>
(i) jl -> jump less than<br>
(ii) jle -> jump less than or equal to<br>
(iii) jg -> jump greater than<br>
(iv) jge -> jump greater than or equal to<br>
- Unsigned conditional control instruction include:<br>
(i) jb -> jump below than<br>
(ii) jbe -> jump below or equal to<br>
(iii) ja -> jump above than<br>
(iv) jae -> jump above or equal to<br>
- An examples is as shown here: [Comparisons](./comparisons.asm)
#### jump out of range
- Target label referred to as a short jump,.i.e. target label must be within ±128 bytes from conditional jump instructions
- Used this example from this resource: [Jump out of range](./jump.png)

#### `Iteration`
- A special instruction called **loop** provides loop support
- general format is as follows:<br>
<p><t>loop <label></p>
- example:<br>
<t>mov  rcx, qword [max]<br>
<t>mov  rax, 1<br>
<t>sumLoop:<br>
<t><t>add   qword [sum], rax<br>
<t><t>add   rax, 2<br>
<t><t>loop  sumLoop<br>
