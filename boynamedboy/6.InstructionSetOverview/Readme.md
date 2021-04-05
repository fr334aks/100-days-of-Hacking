#### `Instruction Set Overview `
- Instructions to deal with:<br>
(i) Data movement<br>
(ii) Conversion Instructions<br>
(iii) Arithmetic Instructions<br>
(iv) Logical Instructions<br>
(v) Control Instructions<br>

#### `Notational Convections`
#### Notational Operand
- An instruction consists of instruction or operation it will do plus the operands(where data going to be operated on comes from / or where its going to be placed)
- Their summary include:<br>
- <reg> -> Register operand. operand must be a Register
- <reg8>, <reg16>, <reg32>, <reg64> -> Register operand with specific size requirement
- <dest> -> Destination operand, may be a register or a memory
- <RXdest> -> Floating point register operand
- <src> -> Source operand. operand value is unchanged in instruction
- <imm> -> Immediate value, may be decimal, hex, octal or binary
- <mem> -> Memory location, may be a variable name or indirect reference
- <op>, <operand> -> Operand, register or Memory
- <op8>, <op16>, <op32>, <op64> -> Operand, register or memory with specific size requirement
- <label> - Program label

#### `Data movement`
- Typically, data is moved into a cpu register from ram to be operated on, and when complete, results copied from register and placed into a variable.
- Basic data movement is in the form:<br>
<t><t>mov   <dst>, <src> <br>
- In example above, source operand is copied from source operand into destination operand. Value of source operand is not changed.
- Destination and source operands must be of same size(e.g.  both are of size word, word)
- Destination operand cannot be an immediate.
- Both operands cannot be a memory. If a memory to memory operation is required, two instructions must be used.
- An exmple of moving instruction:<br>
<t><t>mov   eax, dWord[myVariable]<t><t>-This translates to:<br>
<t>instruction    where to place, how much to get[memory location]<br>
- Examples:<br>
mov eax, 100  ;eax = 0x00000064<br>
mov rcx. -1   ; -1 sets rcx to 0xxffffffffffffffff<br>
mov ecx, eax  ; ecx = eax = 0x00000064<br>

#### `Addresses and Values`
- Only way to access a memory is using the [] Notation, ommitting them will access address instead e.g.<br>
<t><t>mov eax, qWord[var1]  ; move value of var1 into register eax<br>
<t><t>mov rax, eax ;move address of eax into register rax<br>
- Address of a variable can also be obtained with the **lea** keyword(load effective address) i.r. lea <reg64>, <mem>. Examples are:<br>
<t><t>lea   rcx,  byte [bVar] <br>
<t><t>lea   rsi,  dWord [dVar] <br>

#### `Conversion Instructions`
- We can convert from one size to another.e.g byte to double word, for some calculations in a formula.
- Depends on size and type of operands

#### `Narrowing Conversions`
- Involve converting a larger type to a smaller type.e.g(double word to word)
- No special instructions needed
- Lower potions of the memory location or register may be accessed directly.
<img src="./narrow.png" alt="narrow">
- Example 1:<br>
<t><t>mov   rax, 50 ;50 = 0x0032<br>
<t><t>mov   byte [bVar1], al ;al register is accessed directly to get the value<br>
- Example 2:<br>
<t><t>mov   rax, 500 ;500 = 0x01f4<br>
<t><t>mov   byte [bVar2], al ; here bVar2 will contain 0xf4, since its the part containin the byte by its a word

#### `Widening Conversions`
-  Involve converting from a smaller type to a larger type.e.g. byte to double word conversion
#### Unsigned Conversions
- For this, upper part of memory location or register must be set to zero.
- Since an unsigned Integer can only be positive, upper parts must be set to zero i.e. upper order bit(little endian system)
- Example, to conver al, containg 50 to rbx, we do:<br>
<t><t>mov   al, 50 ;move 50 into al Register<br>
<t><t>mov   rbx, 0 ;move 0 to rbx register, ensures all upper bits are set to zero<br>
<t><t>mov   bl, al ;moves al register value to bl, this sets lower bits of rbx which is bl to 50 and the upper bits remain 0<br>
<br>
- This can also be done with a special instruction:<br>
<t><t>movzx   <dst>, <src> ; movz keyword fills upper bits with zero<br>
<img src="movz.png" alt="movz">
- Movzx keyword does not allow a quad word destination operand with a double word source operand
- Examples:
<t><t>movzx   cx, byte [bVar1]<br>
<t><t>movzx   dx, al<br>
<t><t>movzx   ebx, word [wVar1]<br>
<t><t>movzx   ebx, cx<br>
<t><t>movzx   rbx, cl<br>
<t><t>Movzx   rbx, cx<br>
#### Signed Conversions
- Upper bits must be set to 0 or 1 depending on if original value was positive or negative.
- This is perfomed using a sign-extend instruction.
- Upper order bits equals and/or to be filled with:<br>
(i) 1 for negative<br>
(ii) 0  for positive<br>
- Here are some conversion instructions:
<img src="conversions.png" alt="conversions"

#### `Integer Arithmetic Instructions`
#### Addition
- General form of instruction is:
<t><t>add   <dst>, <src><br>
;  where:<br>
<t><t><dest> = <dest> + <src><br>
- Destination and source operand must be of the same size.e.g.byte,byte
- Examples of addition include: [Addition](./arithmeticInstructions.asm)
- In addition to add instruction, there is an increment instruction which adds 1 to the specified operand.i.e<br>
<t><t>inc <operand><br>
where:<br>
<t><t><operand> = <operand> + 1
- Examples of additions inc include: [Increement](./arithmeticInstructions.asm)
#### Addition with carry
- The add with carry is a special add instruction that will include a carry from a previous
addition operation
- Useful when adding very large numbers, i.e. numbers larger than register of the machine
- For assembly programs, the least significant bit is added with the **add** instruction and then immediately the most significant bit added with the **adc** instruction.i.e.<br>
<t><t>adc   <src>, <dest><br>
where:<br>
<t><t><dest> = <dest> + <src> +<carryBit><br>
- Examples of addition with carry include: [Addition with carry](./arithmeticInstructions.asm)

#### `Subtraction`
- General form of instruction is:
<t><t>sub   <dest>, <src><br>
; where:<br>
<t><t><dest> = <dest> - <src><br>
- Examples of subtraction include: [Subtraction](./arithmeticInstructions.asm)
- In addition to sub instruction, there is a decrement instruction which subtracts one from the specified operand.i.e.<br>
<t><t>dec <operand><br>
; where:<br>
<t><t><operand> = <operand> - 1<br>
- Examples of decrement include: [Decrement](./arithmeticInstructions.asm)

#### `Integer multplication`
- Uses **mul** instruction for unsigned operations and **imul** instruction for signed operations
- Multiplication produces double sized results.i.e<br>
 n*n=2n,<br>
 8bit*8bit = 16bit
#### Unsigned multiplication
- General form of instruction is:<br>
<t><t>mul <src><br>
- Source operand must be a register or memory location; immediate operand not allowed
-
