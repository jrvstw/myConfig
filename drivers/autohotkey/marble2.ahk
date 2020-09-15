;; Configuration

;#NoTrayIcon

;; Higher numbers mean less sensitivity
Threshold = 30

;; This key/Button activates scrolling
TriggerKey = XButton1

;---------------- End of configuration ----------------

#Persistent

CoordMode, Mouse, Screen
Hotkey, %TriggerKey%, TriggerKeyDown
;HotKey, %TriggerKey% Up, TriggerKeyUp
SetTimer, CheckForScrollEventAndExecute, 10
scroll_mode = 0
return

TriggerKeyDown:
if (scroll_mode = 0) {
    scroll_mode = 1
    Moved = 0
    MouseGetPos, OrigX, OrigY
    DistanceX = 0
    DistanceY = 0
;   return
} else {
;TriggerKeyUp:
    scroll_mode = 0
    if Moved = 0
        MouseClick, Middle
}
return

CheckForScrollEventAndExecute:
    if scroll_mode = 0
        return

    MouseGetPos, NewX, NewY
    DistanceX += NewX - OrigX
    DistanceY += NewY - OrigY
    MouseMove,OrigX,OrigY,0

    if DistanceY or DistanceX
        Moved = 1

    TicksX := DistanceX // Threshold
    DistanceX -= TicksX * Threshold
    WheelDirectionX := (TicksX > 0)? "WheelLeft": "WheelRight"
    Loop, % abs(TicksX)
        MouseClick, %WHeelDirectionX%

    TicksY := DistanceY // Threshold
    DistanceY -= TicksY * Threshold
    WheelDirectionY := (TicksY > 0)? "WheelUp": "WheelDown"
    Loop, % abs(TicksY)
        MouseClick, %WheelDirectionY%

    return
