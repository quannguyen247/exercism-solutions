source "tree.tcl"

oo::class create Zipper {
    variable focus parent side

    constructor {aTree {aParent ""} {aSide ""}} {
        set focus $aTree
        set parent $aParent
        set side $aSide
    }

    # Lấy toàn bộ cây từ gốc
    method tree {} {
        if {$parent eq ""} {
            return $focus
        }
        return [$parent tree]
    }

    # Lấy giá trị tại vị trí hiện tại
    method value {} {
        return [$focus value]
    }

    # Đi sang node con bên trái
    method left {} {
        set child [$focus left]
        if {$child eq ""} {
            return ""
        }
        return [Zipper new $child [self] left]
    }

    # Đi sang node con bên phải
    method right {} {
        set child [$focus right]
        if {$child eq ""} {
            return ""
        }
        return [Zipper new $child [self] right]
    }

    # Quay lại node cha
    method up {} {
        return $parent
    }

    # Đổi giá trị node hiện tại
    method setValue {value} {
        $focus setValue $value
        return [self]
    }

    # Đổi cây con bên trái
    method setLeft {tree} {
        $focus setLeft $tree
        return [self]
    }

    # Đổi cây con bên phải
    method setRight {tree} {
        $focus setRight $tree
        return [self]
    }

    # Lấy đường đi từ gốc đến focus
    method path {} {
        if {$parent eq ""} {
            return {}
        }
        return [concat [$parent path] $side]
    }

    # So sánh cả cây và vị trí focus
    method equals {other} {
        return [expr {
            [my path] eq [$other path]
            && [[my tree] toDict] eq [[$other tree] toDict]
        }]
    }
}