proc to-rna {dna} {
    # Dùng string map để dịch mã toàn bộ chuỗi DNA
    return [string map {G C C G T A A U} $dna]
}