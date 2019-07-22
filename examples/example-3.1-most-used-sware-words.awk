#!/usr/bin/awk -f

BEGIN {
    FS=","
}

NR > 1 && $2 == "word" {
    words[$3]++
}

END {
    for (word in words) {
        print word, words[word]
    }
}
