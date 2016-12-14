# 台大論文樣板（patch）
為了維護方便，台大版的僅附上與中央版有差異的檔案。請透過內附的 build 工具建立完整樣板。

## 使用方法

### 自動建立樣板
Linux 使用者請執行 bash build.sh

Windows 使用者請執行 build.bat

執行後輸入 zh(中文樣板) 或 en(英文樣板) ，程式會自動新建一個 NTU 目錄。

### 手動建立樣板
避免自動化工具失效，這裡附上手動處理流程。

請將 NTU_patch 的內容複製並覆蓋至 NCU 目錄。中英皆可（事實上中英設定在 config.tex 的 \lang 中，複製到任一目錄皆可）。
config.tex 目前設定值為中文版本，英文論文使用者請將語系設為英文：
```
\def\lang{en}
```
英文字體大小與行高，個人建議使用 12pt 以及 1.3x：
```
\def\baseFontSize{12pt}
\def\baseLineStretch{1.3}
```

目錄中已有相容性的 NCU_thesis 可以載入 NTU_thesis ，所以各子檔檔頭的 class=NCU_thesis 不改沒關係。

## 論文相關說明

### 書脊
由於台大規定電子檔須附書脊，因此我除了論文文件外，另外做了一個獨立的文件 bookspine 。要用的請另外編譯 bookspine.tex（是否編譯與論文本體電子檔的書脊無關）。

### 加密
台大規定加密，本人不贊成，所以不提供。

** 請支持學術自由，和校方說：我是文章作者，擁有著作權，我不想加密！ **

詳細資訊請參考教學或專案wiki。

## 其餘資訊
### 校方論文服務（含格式範本、浮水印、上傳手冊等）
(http://etds.lib.ntu.edu.tw/etdsystem/submit/submitLogin)

### 格式規範含範本
台大社會學系網站，但和校方為同一份文件
(http://sociology.ntu.edu.tw/images_upload/6-3-2_file1.pdf)

### 系所名稱的寫法
(http://writingsos.blogspot.tw/2007/06/blog-post.html)
和以往最大的差別應該在系所名稱的寫法，根據校方負責人的email說明，如果是系所合一的系所，英文名稱應該要用Department of，只有獨立研究所才用Graduate Institute of ；所以我們的英文名稱應該用Department of Library and Information Science。
