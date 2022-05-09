# 國立陽明大學 LaTeX 論文樣板(patch)

為了維護方便，陽明版的僅附上與中央版有差異的檔案。請透過內附的 [build](https://github.com/sppmg/TW_Thesis_Template/wiki/%E7%84%A1%E8%85%A6%E6%89%8B%E5%86%8A#patch-%E7%89%88%E5%BB%BA%E7%AB%8B%E6%96%B9%E6%B3%95) 工具建立完整樣板。

## 使用方法
見本專案的 [Wiki](https://github.com/sppmg/TW_Thesis_Template/wiki) 。

或是你想從[無腦手冊](https://github.com/sppmg/TW_Thesis_Template/wiki/%E7%84%A1%E8%85%A6%E6%89%8B%E5%86%8A)開始。

## 論文相關說明

### 書脊
我相信學校附近的影印店比我專業的多 :D ，而且我不知道你做了書脊他們會如何使用。

如果仍然希望自製書脊者，請參考台大版(NTU_patch)的製作方式。


### 書名頁

教務處沒規定要書名頁，但圖書館在添加浮水印的章節寫到：

> 論文 PDF 檔自書名頁閞始至最後一頁,每一頁都需加入浮水印。

我目前決定不加書名頁（封面即書名頁）。若需要分離者，請於 `main.tex` 中的 `\startWatermark` 下一行再貼一次 `\input{titlepage}`


### 浮水印

已附上浮水印。此浮水印是由校方檔案以 GIMP 匯出而成，主要是為了修改錯誤的 exif 資訊。
原始的 exif 會導致 LaTeX 判斷大小錯誤。


[碩博士論文格式製作說明事項](http://reg.web.ym.edu.tw/files/13-1192-3062.php)
[圖書館上傳論文步驟](http://lib.web.ym.edu.tw/files/11-1143-43.php)

