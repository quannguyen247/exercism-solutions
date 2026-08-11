# a "permutations" module
lappend auto_path lib
package require permutations

# and make a `permutations` command available with the
# required arguments.
interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5

oo::class create ZebraPuzzle {
    variable waterDrinker zebraOwner

    constructor {args} {
        # Lấy tất cả 120 hoán vị vị trí từ module permutations có sẵn
        set perms [permutations]

        # 1. Thử các hoán vị Màu sắc
        foreach color_perm $perms {
            lassign $color_perm red green ivory yellow blue
            if {$green != $ivory + 1 || $blue != 2} continue

            # 2. Thử các hoán vị Quốc tịch
            foreach nat_perm $perms {
                lassign $nat_perm englishman spaniard ukrainian norwegian japanese
                if {$norwegian != 1 || $englishman != $red} continue

                # 3. Thử các hoán vị Đồ uống
                foreach drink_perm $perms {
                    lassign $drink_perm coffee tea milk orangeJuice water
                    if {$milk != 3 || $coffee != $green || $ukrainian != $tea} continue

                    # 4. Thử các hoán vị Sở thích
                    foreach hobby_perm $perms {
                        lassign $hobby_perm dancing painter football chess reading
                        if {$painter != $yellow || $football != $orangeJuice || $japanese != $chess} continue

                        # 5. Thử các hoán vị Thú nuôi
                        foreach pet_perm $perms {
                            lassign $pet_perm dog snails fox horse zebra
                            if {$spaniard != $dog || $snails != $dancing} continue
                            if {abs($reading - $fox) != 1} continue
                            if {abs($painter - $horse) != 1} continue

                            # Tra cứu tên quốc tịch bằng Dictionary
                            set natMap [list $norwegian Norwegian $japanese Japanese $englishman Englishman $spaniard Spaniard $ukrainian Ukrainian]
                            set waterDrinker [dict get $natMap $water]
                            set zebraOwner [dict get $natMap $zebra]
                            return
                        }
                    }
                }
            }
        }
    }

    method drinksWater {} {
        return $waterDrinker
    }

    method ownsZebra {} {
        return $zebraOwner
    }
}