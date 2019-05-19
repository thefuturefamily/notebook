#  **notebook**
`notebook` 是为撰写数学书籍而设计的 LaTeX 模版类. 它支持英文、中文，并且同时支持 `pdfLaTeX` 与 `XeLaTeX`引擎.

## **主要功能**
- 它继承自 `extbook` 模版类，因而可以使用 `extbook` 支持的参数，包括字号、打印方式等.
  - 支持的字号包括 `8pt`、`9pt`、`10pt`、`11pt`、`12pt`、`14pt`、`17pt`、`20pt`，其中 `9pt` ~ `12pt` 是建议的大小.
  - 使用 `oneside`、`twoside` 来调整是单面文档或双面文档.
  - 使用 `gray` 来生成灰度文档.

- 具有漂亮的目录和标题 

- 你可以生成漂亮的定理样式  
<img src="https://github.com/thefuturefamily/manuscript/raw/master/images/theorems.png" width=66% alt="theorem"/>
  - 如果希望使用传统的定理样式，可以添加 `classical` 选项.

- 页边注  
<img src="https://github.com/thefuturefamily/manuscript/raw/master/images/marginpar.png" width=66% alt="marginpar"/>

- 模块  
<img src="https://github.com/thefuturefamily/manuscript/raw/master/images/module.png" width=66% alt="module"/>

**▶️ 更具体的说明可以参见示例与说明文档.**

## **关于更新**
- [master](https://github.com/thefuturefamily/notebook/tree/master) 分支于每月19日进行更新，稳定性较好.
- [devlop](https://github.com/thefuturefamily/notebook/tree/develop) 分支更新较为频繁，通常会包含一些即时性的错误修复以及新的功能. 如果你在编译时遇到了问题，建议尝试这一分支.
