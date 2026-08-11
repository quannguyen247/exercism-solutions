proc custom_error_message {message} {
    error $message
}

proc handle_error {script} {
    set code [catch {uplevel 1 $script} msg]
    
    # Nếu lệnh chạy thành công không có lỗi
    if {$code == 0} {
        return "success"
    }
    
    # Chuẩn hóa thông báo cho từng loại lỗi theo đề bài
    if {[string match "*zero*" $msg] || [string match "*divide*" $msg]} {
        return "division by zero"
    }
    if {[string match "*open*" $msg] || [string match "*file*" $msg]} {
        return "file does not exist"
    }
    if {[string match "*invalid command name*" $msg]} {
        return "proc does not exist"
    }
    
    return $msg
}