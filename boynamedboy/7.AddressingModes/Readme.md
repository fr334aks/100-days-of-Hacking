#### `Addressigng modes`
- Basic addressing modes are:<br>
(i) Register<br>
(ii) Immediate<br>
(iii) Memory<br>

#### `Addresses and values`
- To access memory, we use the [] notation.
- When accessing memory, in many cases operand size is clear.e.g.<br>
```
mov  rax, [ebx]<br> ;moves from word to double word
```
- Where size is ambiguos for an instruction .e.g. inc [rbx]; we must specify the operand size: .e.g.<br>
```
inc byte[al]
dec word[ax]
inc byte[rax]
```

#### `Register mode addressing`
- Refers to an operand that is a CPU register.e.g. al,ax,eax,rax<br>
```
mov  eax, ebx
```

#### `Immediate mode addressing`
- Refers to the operand being an immediate value .e.g. 2, 2342, 0xEA<br>
```
mov  rax, 2342
```

#### `Memory mode addressing`
- Refers that operand is a location in a memory accessed via an address(indirection/referecing)
- example:<br>
```
mov  eax, word[wNum1]
```
- For an array:<br>
```
lst  dd 102, 345, 234, 134, 335
mov  eax, dword [lst]
```
- To access,:<br>
(i) first value in array:<br>
```
mov eax, dword [lst]  ;or alternatively do as below
```
- Are several ways to access array element. One is to use a base address then add a displacement.i.e.<br>
```
mov rbx, lst
mov rsi, 8
```
- Then finally access the third element as follows:<br>
```
mov eax, dword [lst+8] ;or
mov eax, dword [rbx+8] ;or
mov eax, dword [rbx+rsi]
```
- Example programs are:<br>
- [Summation](./sum.asm)
