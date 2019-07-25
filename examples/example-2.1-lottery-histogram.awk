#!/usr/bin/awk -f

function max(array,    inited, max_value) {
    for (i in array) {
        if (!inited || max_value < array[i]) {
            max_value = array[i]
            inited = 1
        }
    }

    return max_value
}

function repeat(string, num,    i, result) {
    for (i = 0; i < num; i++) {
        result = result string
    }

    return result
}

BEGIN {
    FS=";"
}

{
    for (i=4; i>=0; i--) {
        draws[int($(NF-i))]++
    }
}

END {
    max_draws = max(draws)

    for (n in draws) {
        printf("% 3d % 3d %s\n", n, draws[n], repeat("#", (80*draws[n])/max_draws))
    }
}
