#### `Program Development`
- Steps involved are:<br>
(i) Understand the problem<br>
(ii) Create the algorithm<br>
(iii) Implement the Program
(iv) Test/Debug the Program<br>

#### `Understand the program`
- Helps reduce errors, time and effort

#### `Create the algorithm`
- Are steps to be followed to solve the problem
- Once selected, we can now implement the Program
- Steps can be shown in comments for convenience

#### `Implement the program`
- Algorithm is expanded and coded added as steps outlined in algorithm.
- An example program below:
<t>[Integer-to-Ascii-String](int2ascii.asm)

#### `Test/Debug the program`
- compile the program to debug .e.g debug with ddd<br>
 [Compile,Debug](./debug.png)
- In this case, we can run the program using debugger and stop execution near end of program by breaking at label last<br>
```
break last
run
```
<br>[DDD](./ddd.png)
- the resulting stringNum can be viewed by executing:<br>
```
(gdb) x/s &strNum
```
<br>[gdb](./gdb.png)
- if string is not displayed properly, it might be worth checking each character of the 5bit array as:<br>
```
(gdb) x/5cb &strNum
```
<br>[5bytes](./5bytes.png)

#### `Error Terminilogy`
#### Assembler error
- Generated when program is assembled. assembler doesn't understand one or more instructions
#### Runtime error
- Something that causes the program to crash
#### Logic error
- is when program executes but doesn't bring out correct results
