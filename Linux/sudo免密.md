# sudo免密

1. 编辑配置文件
    ```sh
    sudo vi /etc/sudoers
    ```
2. 注释`%sudo  ALL=(ALL:ALL) ALL`

3. 添加`%sudo ALL=NOPASSWD:ALL`

4. 用 `wq!` 来保存修改
