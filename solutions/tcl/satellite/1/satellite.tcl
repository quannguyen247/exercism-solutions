proc treeFromTraversals {preorder inorder} {
    if {[llength $preorder] != [llength $inorder]} {
        error "traversals must have the same length"
    }
    if {[llength [lsort -unique $preorder]] != [llength $preorder]} {
        error "traversals must contain unique elements"
    }
    if {[lsort $preorder] ne [lsort $inorder]} {
        error "traversals must contain the same elements"
    }

    # Không còn phần tử thì đây là cây rỗng
    if {$preorder eq {}} {
        return {}
    }

    # Phần tử đầu preorder luôn là node gốc
    set root [lindex $preorder 0]
    set split [lsearch -exact $inorder $root]
    set leftInorder [lrange $inorder 0 [expr {$split - 1}]]
    set rightInorder [lrange $inorder [expr {$split + 1}] end]
    set leftSize [llength $leftInorder]

    # Tách preorder theo số node của cây con trái
    set left [treeFromTraversals [lrange $preorder 1 $leftSize] $leftInorder]
    set right [treeFromTraversals [lrange $preorder [expr {$leftSize + 1}] end] $rightInorder]

    return [dict create v $root l $left r $right]
}
