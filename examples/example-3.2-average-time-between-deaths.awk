#!/usr/bin/env awk -f

BEGIN {
    FS=","
    OFS="\t"
}

$2 == "death" {
    death_elapsed[$1] += $4 - last_death[$1]
    death_count[$1]++
    last_death[$1] = $4
}

END {
    for (movie in death_count) {
        print sprintf("%-20s", movie), death_count[movie], death_elapsed[movie] / death_count[movie]
    }
}
