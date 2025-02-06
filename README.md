📌 主要功能：

✅ 遍历当前目录，自动发现所有 .dart 文件（排除 index.dart 本身）

✅ 生成 index.dart，使用 export 语句导出所有文件。


安装:(需要 flutter环境)

```
dart pub global activate -sgit https://github.com/Dxc123/flutter_gen_index.git
```

移除：

```
dart pub global deactivate flutter_gen_index
```
使用：

```
flutter_gen_index gen_index 
```
