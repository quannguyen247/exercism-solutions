proc nucleotideCounts {strand} {
    # Kiểm tra hợp lệ 
    if {[regexp {[^ACGT]} $strand]} {
        error "Invalid nucleotide in strand"
    }

    # Khởi tạo dict
    set counts [dict create A 0 C 0 G 0 T 0]
    
    # Duyệt và đếm
    foreach char [split $strand ""] {
        dict incr counts $char
    }
    
    return $counts
}