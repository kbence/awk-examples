%title: Effective AWK - the Swiss Army Knife of stream editing
%author: Bnc
%date: 2018-04-18

-> # Introduction <-

\                      .d8b.  db   d8b   db db   dD
\                     d8' \`8b 88   I8I   88 88 ,8P'
\                     88ooo88 88   I8I   88 88,8P
\                     88~~~88 Y8   I8I   88 88\`8b
\                     88   88 \`8b d8'8b d8' 88 \`88.
\                     YP   YP  \`8b8' \`8d8'  YP   YD

-> ## AWK in text file processing <-

\     +-------------------+--------------------------------------+
\     |                   |                                      |
\    sed                 `awk`                                    perl

---

-> # Pattern matching <-

Match everything:
```
{
    print $1
}
```

Match a regular expression:
```
/Waldo/ {
    print "Here he is: " $0
}
```

---

-> # Pattern matching <-

Match other kind of expression:
```
"Waldo" {
    print "Here he is: " $0
}
```

Just filter:
```
/(Dead)?[Pp]ool(verine)?/
```

equivalent to
```
/(Dead)?[Pp]ool(verine)?/ {print}
```

Filters can be complex expressions:
```
$2 == "Kryptonite" && ($3 ~ /Lex/ || $3 ~ /Luthor/)
```

---

-> # Field references <-

\             88
\         .d88888b.
\        d88P 88"88b
\        Y88b.88
\         "Y88888b.      The field reference operator
\             88"88b
\        Y88b 88.88P
\         "Y88888P"
\             88

Field can be addressed by various ways:
```
+------------------------------------------------+
|                        $0                      |
+--------------------+----+--+--+-------+---+----+
|         $1         | $2 |$3|$4|  $5   |$6 | $7 |
|                    |    |  |  |       |   | $NF|
 2018-04-18T15:24:13Z This is an example log line
```

These references are also valid:
```
$(NF-1) > 5

$($2) == "apple"
```

---

-> # Changing fields <-

You can change the fields of the current line:
```
{
    $5 = "new value"
}
```

Appending to a line is easy:
```
{
    $(NF+1) = "new field!"
    $(NF+1) = "another new field!"
}
```

---

-> # Everything that has a BEGINning has an END <-

```
BEGIN {
    # Initialize global settings here
    FS = "\t"
    OFS = " "
}
```

```
END {
    # Here be finishing scripts
    print "Drogon, Rhaegal, Viserion"
}
```

---

-> # AWK language <-

-> ## Variables <-

No need for declaration:
```
server_name = $3
source_ip = $4
incoming_requests = $5
servers[server_name][source_ip] = incoming_requests
```

Creating an empty array:
```
split("", array_variable, "")
```

---

-> # AWK language <-

-> ## Built-in variables <-

Modifying behavior:
FS         - field separator
OFS        - output field separator
RS         - record separator
ORS        - output record separator
IGNORECASE - ignore case in regexps

Information (about row, session):
ARGC, ARGV - arguments
ENVIRON    - environment variables
NR         - record number (starting from 0)
NF         - number of fields

---

-> # AWK language <-

-> ## String operations <-

Print & concatenation
```
print                 # prints the current $0
print $1 "-" $2, $3   # prints "$1-$2 $3"
```

Substrings:
```
substr("funeral", 1, 3)    # returns "fun"
substr("apple juice", 7)   # returns "juice"
```

Splitting strings:
```
split("string to split", target_var, " ")
# assigns ["string", "to", "split"] to target_var
# indexing is 1 based!
```

---

-> # AWK language <-

-> ## Math operations <-

Operators:
```
# + - * / % ^
$1 = $2 + $3 ^ ($4 % $5)

step += 3
exp *= 2
```

Functions: int, sin, cos, atan2, exp, log, sqrt, rand, srand

Implicit conversion to int/float!

---

-> # AWK language <-

-> ## Control statements <-

```
{
    # if
    if ($1 == $2) {
        print $3
    }
    # range loop
    for (i = 0; i < 100; i++)
        print i
    # foreach loop
    for (key in array) {
        print key, array[key]
    }
    # conditional loop
    while (NF < 500) {
        $(NF+1) = NF
    }
}
```

---

-> # AWK language <-

-> ## Control statements <-

While:
```
{
    while ((c = getopt(argc, argv, "v:f:F:W:")) != -1) {
        # ...
    }
}
```

Switch:
```
{
    switch ($1) {
        case 1:   print "one"; break;
        case "2": print "two"; break;
        case /3/: print "three"; break;
        default:  print "something else"
    }
}
```

---

-> # AWK language

-> ## Functions <-

```
function reverse_list(string,    len, idx, array, result) {
    split(string, array, ",")
    len = length(array)
    for (idx = len; idx > 0; idx--) {
        result = result "," array[idx]
    }
    return substr(result, 2)
}
```

---

-> Let's try it! <-





 \_\_\_\_\_\_\_           \_\_\_\_\_\_\_  \_\_\_\_\_\_\_  \_\_\_\_\_\_\_  \_        \_\_\_\_\_\_\_  \_\_\_\_\_\_\_  
(  \_\_\_\_ \\|\\     /|(  \_\_\_  )(       )(  \_\_\_\_ )( \\      (  \_\_\_\_ \\(  \_\_\_\_ \\
| (    \\/( \\   / )| (   ) || () () || (    )|| (      | (    \\/| (    \\/
| (\_\_     \\ (\_) / | (\_\_\_) || || || || (\_\_\_\_)|| |      | (\_\_    | (\_\_\_\_\_
|  \_\_)     ) \_ (  |  \_\_\_  || |(\_)| ||  \_\_\_\_\_)| |      |  \_\_)   (\_\_\_\_\_  )
| (       / ( ) \\ | (   ) || |   | || (      | |      | (            ) |
| (\_\_\_\_/\\( /   \\ )| )   ( || )   ( || )      | (\_\_\_\_/\\| (\_\_\_\_/\\/\\\_\_\_\_) |
(\_\_\_\_\_\_\_/|/     \\||/     \\||/     \\||/       (\_\_\_\_\_\_\_/(\_\_\_\_\_\_\_/\\_\_\_\_\_\_\_)
