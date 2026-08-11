proc findAnagrams {subject candidates} {
    # Chuyển từ gốc về chữ thường và sắp xếp các chữ cái
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]

    # Tạo danh sách rỗng chứa kết quả
    set result {}
    
    # Duyệt qua từng từ candidates
    foreach cand $candidates {
        set cand_lower [string tolower $cand]
        
        # Candidates không được trùng từ gốc và không phân biệt hoa/thường
        if {$cand_lower ne $sub_lower} {
            # Sắp xếp các chữ cái của candidates
            set cand_sorted [lsort [split $cand_lower ""]]
            
            # Các chữ cái sau khi sắp xếp phải giống hệt từ gốc
            if {$cand_sorted eq $sub_sorted} {
                lappend result $cand
            }
        }
    }
    
    return $result
}