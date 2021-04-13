# 使用nasm编译的一些汇编demo
## 01、对于展示数字的实验情况

### 使用loop作循环

> 汇编原文件：01_showOffset.asm

* dos实验异常：没有显示字母，如图，原因未知

![image-20210414010823790](img\readme\image-20210414010823790.png)

* vbox实验异常：多一个d，如图，原因未知

![image-20210414010255356](img\readme\image-20210414010255356.png)

* bochs实验：异常，多了一个d，如图1，同时在debug一行行的情况下正常,图2，原因未知

![image-20210414010433831](img\readme\image-20210414010433831.png)

![image-20210414010631527](img\readme\image-20210414010631527.png)

### 使用jns作循环

> 汇编原文件：01_showOffset_other.asm

* dos实验异常：没有显示字母字符，原因未知

![image-20210414005704888](img\readme\image-20210414005704888.png)

* vbox实验情况异常：出现多一个d，原因未知

![image-20210414005141679](img\readme\image-20210414005141679.png)

* bochs实验正常
*![image-20210414005358408](img\readme\image-20210414005358408.png)