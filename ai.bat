@echo off
setlocal enabledelayedexpansion

:: Tạo biến để lưu trữ câu hỏi và phản hồi từ responses.txt
set responses_file=responses.txt
set not_found_msg="Sorry, I don't understand. How should I respond to this?"

:main
cls
echo Welcome to AI Chat!
:conversation_loop
set /p user_input="You: "

:: Kiểm tra xem user_input có trống không
if "%user_input%"=="" goto conversation_loop

:: Đọc các phản hồi từ responses.txt và tìm kiếm từ khóa
set found=0
for /f "tokens=1,* delims=:" %%A in (%responses_file%) do (
    echo !user_input! | findstr /i /c:"%%A" >nul
    if !errorlevel! equ 0 (
        set ai_response=%%B
        set found=1
        goto respond
    )
)

:: Nếu không tìm thấy phản hồi, hỏi người dùng cách trả lời
if !found! equ 0 (
    echo %not_found_msg%
    set /p new_response="Your Response: "
    echo !user_input!:!new_response! >> %responses_file%
    set ai_response=!new_response!
)

:respond
:: Hiển thị phản hồi của AI
echo AI: !ai_response!

:: Sử dụng speak.vbs để nói phản hồi
cscript //nologo speak.vbs "!ai_response!"

:: Quay lại để tiếp tục cuộc trò chuyện
goto conversation_loop