# 交通大學論文樣板
為了維護方便，交大版的僅附上與中央版有差異的檔案。請透過內附的 build 工具建立完整樣板。

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


## 其餘資訊
交大沒有規定要附上書脊，所以我這裡也不放。我相信學校附近的影印店比我專業的多 :D ，而且我不知道你做了書脊他們是如何使用。

如果仍然希望自製書脊者，請參考台大版(NTU_patch)的製作方式。

<!-- （書脊寬度和你的紙本厚度有關） -->

<!-- todo

更動列表:

- config.tex
- cover.tex
- titlepage.tex
memoir
NCU_thesis.cls

cover.tex titlepage.tex 均已完成-->
