#### `Macros`
- Is a defined set of instructions thath can be easily inserted wherever needed
- Once defined, a macro can be used as many times as necessary
- Assembler contains powerful macro which supports conditional assembly, multi-level file inclusion, and two forms of Macros
(single line and multiline) and a 'context stack' mechanism for extra macro power
- Are two types:<br>
(i) Single line Macros<br>
(ii) Multi line Macros<br>

#### `Single Line Macros`
- Defined using the **%define** directive e.g
```
%define mulbyt4(x) shl x, 2
```
- we can then use the macro as:
```
mulbyt  (rax)
```

#### `Multi line macros`
- Can include a varying number of lines
#### Defining multiline Macros
- General format is:
```
%macro <name> <number of arguments>
  ; [body of macro]
%endmacro
```
- Arguments can then be referenced within macro by **%<number>** with **%1** being first argument and so on
- To use labels within macros, preceed with:**%%**
- An example macro below:
```
%macro abs 1
  cmp   %1, 0
  jge   %%done ;jump to done label if value in %1 is greater than or equal 0
  neg   %1

%%done:

%endmacro
```
#### Invoking the macro
- To invoke, place it in the code segment referred by its names and appropriate number of arguments
- Given a data declaration as follows:
```
qVar    dq  4
```
- To invoke abs macro above in a code segment, use:
```
mov   eax, -3
abs   eax

abs   qword [qVar]

```
- Macros use more memory but do not require overhead transfer of control(like in functions)
- An example of macros:<br>
[Macros](./macros.asm)

#### `Debugging macros`
- Code for macros will not be displayed in debugger source code window
- However, when debugging macros, code must be visible and to see it, display the machine code windown in View then Machine Code View in the tool bar menu of ddd Debugger
- To execute macro instructions, **stepi** and **nexti** commands must be used.
<!--
- In our code here [Macros](./macros.asm), we can try debugging as follows:
<img src="debug1.png" alt="break and run">
-->
