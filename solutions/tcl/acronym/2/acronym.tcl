proc abbreviate {phrase} {
    set phrase_cleaned [regsub -all {[^a-zA-Z']} $phrase " "]
    set acronym ""
    
    # Duyệt qua từng từ đã được làm sạch
    foreach word $phrase_cleaned {
        # Lấy chữ cái đầu tiên và viết hoa
        append acronym [string toupper [string index $word 0]]
    }
    return $acronym
}