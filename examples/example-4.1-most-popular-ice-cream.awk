#!/usr/bin/env awk -f

BEGIN {
    FS="\t"
}

{
    split($2, icecream_index, ",");
    for (idx in icecream_index) {
        icecreams[$(2+icecream_index[idx])]++
    }
}

END {
    for (ic in icecreams) {
        print icecreams[ic], ic
    }
}
