# Windows 平台 VsCode + CodeLLDB 调试 Rust 无法查看复杂类型

1. 查看 toolchain

```powershell
rustup toolchain list
```

2.设置 stable-gnu 做为默认（没有安装 GNU 工具链也可以通过这条指令来安装）

```powershell
rustup default stable-gnu
```
