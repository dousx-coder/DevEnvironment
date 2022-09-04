# Ubuntu使用root用户登录桌面

> Ubuntu默认不允许以root登录桌面坏境

1. `sudo vim /etc/pam.d/gdm-password`
   - 注释掉`auth required pam_succeed_if.so user != root quiet_success`
2. `sudo vim /etc/pam.d/gdm-autologin`
   - 注释掉`auth required pam_succeed_if.so user != root quiet_success`

3. `sudo shutdown -r now`