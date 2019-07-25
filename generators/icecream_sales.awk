#!/usr/bin/env awk -f

function random_variation(array, record, at_least_one,      selected) {
    split("", selected, "") # GNU awk compatibility

    for (k in array) {
        if (int(rand()*10) > 6) {
            selected[k] = 1
        }
    }

    if (at_least_one) {
        if (length(selected) == 0) {
            selected[int(rand()*length(array)+1)] = 1
        }
    }

    idx = length(record)
    for (k in selected) {
        record[idx++] = array[k]
    }
}

BEGIN {
    OFS="\t"
    split("pistachio,vanilla,tutti frutti,caramel,rum & walnuts,coffee", flavours, ",")
    split("whipped cream,sweet cone,chocolate flakes,skittles", extras, ",")
}

{
    split("",icecream_sold,"")
    random_variation(extras,icecream_sold)
    extras_length = length(icecream_sold)
    random_variation(flavours,icecream_sold,1)

    $1 = NR
    $2 = ""
    for (col = extras_length; col < length(icecream_sold); col++) {
        $2 = $2 "," (col+1)
    }
    $2 = substr($2, 2)

    for (col = 0; col < length(icecream_sold); col++) {
        $(col+3) = icecream_sold[col]
    }

    print $0
}
