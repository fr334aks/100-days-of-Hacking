<h3>Linking Code</h3>
Dll imports certain functionality they are linked when assembly code is transformed to binary from assembly
<P>
static: directly copies code from the library into the executable
<br>
Runtime: Imports from libraries only when that library is needed malware often uses this technique
<br>
Dynamic: os looks for librarys when executable is loaded.This is most common
</P>

<P>
debuggers run in two modes (1) Kernel mode (2) user mode
<br>
kernel mode is more difficult to execute
</P>
debugers allow the  with the cpu through stepping 
br
<p><h3>Types of stepping through a program</h3>
Single stepping - Execute a single instruction then return control to the debuger
<br>
stepping over -execute a single instruction but jumps over any function call
<br>
Stepping into - executes a single instruction but will trace into a function
<br>
conditional break point - Break once you reach a certian point in your code.

