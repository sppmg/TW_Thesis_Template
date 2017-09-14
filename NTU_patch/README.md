# 國立臺灣大學 LaTeX 論文樣板(patch)
為了維護方便，臺大版的僅附上與中央版有差異的檔案。請透過內附的 build 工具建立完整樣板。

**使用本樣板之論文已於 2017-02-10 審核通過，請安心使用。**

## 使用方法
見本專案的 [Wiki](https://github.com/sppmg/TW_Thesis_Template/wiki) 。

或是你想從[無腦手冊](https://github.com/sppmg/TW_Thesis_Template/wiki/%E7%84%A1%E8%85%A6%E6%89%8B%E5%86%8A)開始。

## 論文相關說明

### 系所名稱
(2017-02-09更新) 圖書館要求加上中英文學院名。目前暫不增加新變數，請直接設定於 config.tex 的 \def\deptZh 與 \def\deptEn （範例已更新）

### 書脊與封面
(2017-02-10更新) 圖書館表示電子檔不可附書脊，送印才要（實際上影印店應該也不用你做。實際詢問某影印店，若要自製書脊請製作分離之PDF檔，即 bookspine.tex ），所以 main.tex 中註解掉 \addBookSpineThisPage 與。有需求者請自行解註。

封面不含浮水印與DOI，舊版(v1.7以前)使用者請參考 main.tex 的更動。

(舊資訊：)由於臺大規定電子檔須附書脊，因此我除了論文文件外，另外做了一個獨立的文件 bookspine 。要用的請另外編譯 bookspine.tex（是否編譯與論文本體電子檔的書脊無關）。

### 加密
臺大規定加密，本人不贊成，所以不提供。

**請支持學術自由，和校方說：我是文章作者，擁有著作權，我不想加密！**

詳細資訊請參考教學或專案wiki。

## 其餘資訊
### 其他網友樣板

[tzhuan](https://github.com/tzhuan/ntu-thesis)

使用 XeLaTeX + BibTeX ，提供 Makefile，可用 Gnu make 方便的編譯處理。
Makefile 內使用 pdftk 進行加密，須要加密者請參考此檔(其[wiki](https://github.com/tzhuan/ntu-thesis/wiki) 亦包含參數說明。 )。

其餘見[同好連結](https://github.com/sppmg/TW_Thesis_Template/wiki/%E5%90%8C%E5%A5%BD%E9%80%A3%E7%B5%90)

### 校方論文服務（含格式範本、浮水印、上傳手冊等）
(http://etds.lib.ntu.edu.tw/etdsystem/submit/submitLogin)

### 格式規範含範本
臺大社會學系網站，但和校方為同一份文件
(http://sociology.ntu.edu.tw/images_upload/6-3-2_file1.pdf)

### 系所名稱的寫法
(http://writingsos.blogspot.tw/2007/06/blog-post.html)
和以往最大的差別應該在系所名稱的寫法，根據校方負責人的email說明，如果是系所合一的系所，英文名稱應該要用Department of，只有獨立研究所才用Graduate Institute of ；所以我們的英文名稱應該用Department of Library and Information Science。
