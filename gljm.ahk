GroupAdd OneNoteGroup, ahk_exe onenote.exe
GroupAdd DragGroup, AllWindows

;;Drag
  #LButton::
    ;; 坐标系是活动的窗口, 而不是屏幕
    CoordMode, Mouse, Relative
    MouseGetPos, cur_win_x, cur_win_y, window_id
    WinGet, window_minmax, MinMax, ahk_id %window_id%

    ; Return if the window is maximized or minimized
    if window_minmax <> 0
    {
      return
    }

    CoordMode, Mouse, Screen
    SetWinDelay, 0

    loop
    {
      ; move the window based on cursor position
      MouseGetPos, cur_x, cur_y
      WinMove, ahk_id %window_id%, , (cur_x - cur_win_x), (cur_y - cur_win_y)
    } Until !GetKeyState("LButton", "P")

    return

  #RButton::
    ;; 坐标系是整个屏幕
    CoordMode, Mouse, Screen
    ;; 获取当前鼠标的位置和对应的窗口
    MouseGetPos, cur_win_x, cur_win_y, window_id

    ;; 获取当前窗口的宽高
    WinGetPos, ,, cur_win_width, cur_win_height, ahk_id %window_id%
    SetWinDelay, 0

    loop
    {
      ;; 根据鼠标移动的位置差值, 调整窗口大小
      MouseGetPos, cur_x, cur_y
      WinMove, ahk_id %window_id%, , , , cur_win_width + (cur_x - cur_win_x), cur_win_height + (cur_y - cur_win_y)
    } Until !GetKeyState("RButton", "P")

    return



;;Esc
  $^[::
  Send {Escape}
  return

;;回车
  $^j::
  Send {Enter}
  return

;;等号
  $^;::
  Send {=}
  return

;;移动光标
  ;;光标左移
  $^b::
  Send {Left}
  return

  ;;光标右移
  $^f::
  Send {Right}
  return

  ;;光标上移
  ;;OneNote中无法直接映射上下,改成^Up
  $^p::
  if WinActive("ahk_group OneNoteGroup") {
       Send ^{Up}
    }
    else {
       Send,{Up}
  }
  Send,{Up}
  return

  ;;光标下移
  ;;OneNote中无法直接映射上下,改成^D
  $^n::
  if WinActive("ahk_group OneNoteGroup") {
       Send ^{Down}
    }
    else {
       Send,{Down}
  }
  Send,{Down}
  return

  ;;光标移动到下个单词
  ;;$^#f::
  ;;Send ^{Right}
  ;;return

  ;;光标移动到上个单词
  $^#b::
  Send ^{Left}
  return

  ;;光标移动到行首
  $^a::
  Send {Home}
  return

  ;;光标移动到行末
  $^e::
  Send {End}
  return

;;删除
  ;;向左删除
  $^h::
  Send {Backspace}
  return

  ;;向右删除
  $^d::
  Send {Del}
  return

  ;;向左删除单词
  $^#h::
  Send ^{Backspace}
  return

  ;;向右删除单词
  $^#d::
  Send ^{Del}
  return

  ;;删除当前位置到行尾
  $^k::
  Send +{End}
  Send {Del}
  return

  ;;删除当前位置到行首
  $^u::
  Send +{Home}
  Send {Backspace}
  return



;;重新利用被占用热键
  ;;win+shift+f代替C-S-f（全局查找）
  $#+f::
  Send ^+{f}
  return

  ;;win+f代替C-f（查找）
  $#f::
  Send ^{f}
  return

  ;;win+n代替C-n（新建）
  $#n::
  Send ^{n}
  return

  ;;win+a代替C-a（全选）
  $#a::
  Send ^{a}
  return

  ;;win+h代替C-h（chrome查看历史记录）
  $#h::
  Send ^{h}
  return

  ;;win+e 代替C-e（flying logic）
  $#e::
  Send ^{e}
  return
