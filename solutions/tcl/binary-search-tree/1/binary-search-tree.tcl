oo::class create BinarySearchTree {
    variable value
    variable leftNode
    variable rightNode

    # Tạo node rỗng
    constructor {} {
        set value ""
        set leftNode ""
        set rightNode ""
    }

    method data {} {
        return $value
    }

    # Chèn số vào nhánh phù hợp
    method insert {val} {
        if {$value eq ""} {
            set value $val
        } elseif {$val <= $value} {
            if {$leftNode eq ""} {
                set leftNode [BinarySearchTree new]
            }
            $leftNode insert $val
        } else {
            if {$rightNode eq ""} {
                set rightNode [BinarySearchTree new]
            }
            $rightNode insert $val
        }
    }

    method toDict {} {
        if {$value eq ""} {
            return {}
        }

        set left [expr {
            $leftNode eq "" ? {} : [$leftNode toDict]
        }]
        set right [expr {
            $rightNode eq "" ? {} : [$rightNode toDict]
        }]

        return [dict create data $value left $left right $right]
    }

    method sorted {} {
        # Duyệt trái, node hiện tại, rồi phải
        if {$value eq ""} {
            return {}
        }

        set left [expr {
            $leftNode eq "" ? {} : [$leftNode sorted]
        }]
        set right [expr {
            $rightNode eq "" ? {} : [$rightNode sorted]
        }]

        return [concat $left [list $value] $right]
    }

    method map {varname body} {
        # Áp dụng biểu thức theo thứ tự tăng dần
        upvar 1 $varname var
        set result {}

        if {$leftNode ne ""} {
            set result [concat $result [$leftNode map $varname $body]]
        }

        if {$value ne ""} {
            set var [self]
            lappend result [uplevel 1 $body]
        }

        if {$rightNode ne ""} {
            set result [concat $result [$rightNode map $varname $body]]
        }

        return $result
    }
}