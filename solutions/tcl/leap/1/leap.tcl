#!/usr/bin/env tclsh

proc isLeapYear {year} {
    # 1. Exceptional Case: Century years divisible by 400 are leap years.
    if {$year % 400 == 0} {
        return 1
    }
    
    # 2. Exclusion Case: Remaining century years (divisible by 100) are NOT leap years.
    if {$year % 100 == 0} {
        return 0
    }
    
    # 3. Normal Case: Other years divisible by 4 are leap years.
    if {$year % 4 == 0} {
        return 1
    }
    
    # 4. Default Fallback: All other years are not leap years.
    return 0
}