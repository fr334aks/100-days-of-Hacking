#### `Data Representation`
- Refers to how data is stored in a computer

#### `Integer Representation`
- Refers to how a computer stores numbers in memory.
- Represents numbers in 1's and zeros and has limited space that can be used for each numbers
- To determine if a value can be represented, you need to know size of storage element(word,double word etc)
- Unsigned Integers are represented in standard binary
- Signed Integers are represented in two's complement for negative range and standard binary for positive range

#### `Unsigned and Signed Addition`
<p>(i) Unsigned Addition<br>
241+7<br>
241-    11110001<br>
..7-    00000111<br>
Total-  11111000<br>
248 = F8</p>
<p>(ii) Signed Addition<br>
()-15)+(+7)<br>
-15   -  11110001<br>
+7    -  00000111<br>
-8    -  11111000<br>
-8  = F8
- Note how overlaps occur.

#### `Characters and strings`
- Memory is designed to store and retrive numbers, thus symbols such as Characters are consequently assigned numeric values.
#### Ascii
- In ascii, each character and control character is assigned a numeric value.
- References can be found on <a  href="https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html">ASCII table</a>
- TYpically stored in a byte(8 bits) since memory is byte addressable.
#### Unicode
- Offers support for different languages.
- References can be found on <a href="https://www.ssec.wisc.edu/~tomw/java/unicode.html">Unicode</a>
- Has different schemes utf-8,utf-16,utf-32, etc

#### `strings Representation`
- A string is a  series of ascii Characters, typically terminated with a null to mark end of string since null is unprintable in ASCII.
- e.g. <br>
| H   | E   | L   | O   | O  | NULL | </br>
| 72  | 101 | 108 | 108 |111 | 0    | </br>
|0x48 |0x65 |0x6c |0x6c |0x6f| 0x00 | </br>

- The string "19653" would use 6 bytes for representation in unicode(utf-8) since each character reprents a single byte whereas the integer 19653 can be stored in a single word(2bytes).
