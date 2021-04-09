#### `Addressigng modes`
- Basic addressing modes are:<br>
(i) Register<br>
(ii) Immediate<br>
(iii) Memory<br>

#### `Addresses and values`
- To access memory, we use the [] notation.
- When accessing memory, in many cases operand size is clear.e.g.<br>
<t>mov  rax, [ebx]<br> //moves from word to double word
- Where size is ambiguos for an instruction .e.g. inc [rbx]; we must specify the operand size: .e.g.<br>
<t>inc byte[al]<br>
<t>dec word[ax]<br>
<t>inc byte[rax]<br>

#### `Register mode addressing`
- Refers to an operand that is a CPU register.e.g. al,ax,eax,rax<br>
<t>mov  eax, ebx<br>

#### `Immediate mode addressing`
- Refers to the operand being an immediate value .e.g. 2, 2342, 0xEA<br>
<t>mov  rax, 2342<br>

#### `Memory mode addressing`
- Refers that operand is a location in a memory accessed via an address(indirection/referecing)
- example:<br>
<t>mov  eax, word[wNum1]<br>
- For an array:<br>
<t>lst  dd 102, 345, 234, 134, 335
<t>mov  eax, dword [lst]
- To access,:<br>
(i) first value in array:<br>
<t>mov eax, dword [lst]  ;or alternatively do as below<br>
- Are several ways to access array element. One is to use a base address then add a displacement.i.e.<br>
<t>mov rbx, lst<br>
<t>mov rsi, 8<br>
- Then finally access the third element as follows:<br>
<t>mov eax, dword [lst+8] ;or<br>
<t>mov eax, dword [rbx+8] ;or<br>
<t>mov eax, dword [rbx+rsi] <br>
- Example programs are:<br>
- [Summation](./sum.asm)
