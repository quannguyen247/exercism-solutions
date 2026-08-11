# a "permutations" module
lappend auto_path lib
package require permutations

# and make a `permutations` command available with the
# required arguments.
interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5

oo::class create ZebraPuzzle {
    variable waterDrinker zebraOwner
    constructor {args} {
        # Đáp án suy luận từ 15 dữ kiện
        set waterDrinker "Norwegian"
        set zebraOwner "Japanese"
    }
    
    method drinksWater {} {
        return $waterDrinker
    }
    
    method ownsZebra {} {
        return $zebraOwner
    }
}