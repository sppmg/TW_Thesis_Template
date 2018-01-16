# 國立清華大學 LaTeX 論文樣板(patch)
為了維護方便，清大版的僅附上與中央版有差異的檔案。請透過內附的 build 工具建立完整樣板。

## 使用方法
見本專案的 [Wiki](https://github.com/sppmg/TW_Thesis_Template/wiki) 。

或是你想從[無腦手冊](https://github.com/sppmg/TW_Thesis_Template/wiki/%E7%84%A1%E8%85%A6%E6%89%8B%E5%86%8A)開始。

## 論文相關說明

圖書館比教務處多了一些規定，請參考：[圖書館說明](http://www.lib.nthu.edu.tw/ETD/doc3.htm)

封面樣式參考[註冊組](http://registra.web.nthu.edu.tw/files/13-1086-5155.php)

### 匯出摘要

直接單獨編譯 `abstract_*.tex` 即可。（注意編輯器可能會自動改編譯主文件）

如包含浮水印，在摘頁頁面加上 `\startWatermark` 即可。

### 加密
清大規定加密，本人不贊成，所以不提供。

**請支持學術自由，和校方說：我是文章作者，擁有著作權，我不想加密！**

詳細資訊請參考教學或專案wiki。

### 浮水印

樣板已附上。圖書館說明指出：使用 100% 不透明度，但其實我比較建議用 50% ，比較不容易和文字混淆。想改的人可以在 `config.tex` 修改（`\def\wmOpacity{0.5}`） 。

不過因為使用的是 `eso-pic` 套件，第一頁浮水印的透明設置會失效。（如果是從封面開始的話就當 logo 吧！不透明也沒關係。）

### 書脊
我相信學校附近的影印店比我專業的多 :D 

如果仍然希望自製書脊者，請參考台大版(NTU_patch)的製作方式。

## 其餘資訊
### 其他網友樣板
見[同好連結](https://github.com/sppmg/TW_Thesis_Template/wiki/%E5%90%8C%E5%A5%BD%E9%80%A3%E7%B5%90)
