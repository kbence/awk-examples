#!/usr/bin/env awk -f

function make_worksafe(word,    result, i) {
    result = substr(word, 1, 1);

    for (i = 2; i < length(word); i++) {
        result = result "*"
    }

    return result substr(word, length(word), 1);
}

BEGIN {
    FS=OFS=",";
}

$2 == "word" {
    $3 = make_worksafe($3);
}

# Print line if it's true (it is)
1
