package require Tcl 9.0

package require Tcl 9.0
proc truncate {input} {
    # Cắt và trả về chuỗi từ vị trí số 0 đến số 4
    return [string range $input 0 4]
}
