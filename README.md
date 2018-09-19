# 创建日期
20180911

# 说明
结合主动学习与在线字典学习技术的图像分类方法。

# 项目说明

## 文件结构
- data: 存放数据集相关文件夹.
- result: 存放结果文件夹,以日期(年月日)为划分,结果文件前缀表示数据集,下划线后为文件创建时间(时分).e.g., `result/20180912/LFW_2103.txt`表示2018年09月12日21时03分时LFW数据集的实验结果。
- tools: 存放一些相关的工具函数
- utils: 存放与模型训练最相关的函数
- main.m: 实验入口文件

## 代码风格
项目目前虽然运行正确,但是一直没有一个统一的编码风格.
- 变量名: 驼峰标准,小写开头,不要下划线`_`
- 函数名: 驼峰标准,大写开头,不要下划线`_`

# 实验说明
## parameter settings
- $lambda$ is the constraint of discriminative coding coefficient term, it shouldn't be set too large in the case of model bias.

## dataset
- [LFW face data set](http://vis-www.cs.umass.edu/lfw/)
