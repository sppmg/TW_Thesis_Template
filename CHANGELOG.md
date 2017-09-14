# Change Log | 版本紀錄
不同於首頁（README.md）的遷移資訊僅說明版本間的轉移，這裡提供各發佈版的更動。（此檔於 2016-12-30 補上。舊版僅概略描述，詳細變動請參考 git log ）

## v1.8 (2017-XX-XX)
<!-- - sppmgTool.sty 新增  指令 -->
- 修正 \cref 引用 appendix 章節之文字。（加 \crefname{appendix}{附錄}{附錄}）
- thesis_base.cls 預設文獻風格由 nature 改為 ieee。
- NTU 版依校方要求進行微調
    - 增加學院名(直接設定於 config.tex 原有的 \def\deptZh 與 \def\deptEn)。
    - 去除封面書脊設定（main.tex 註解相關指令）、封面不含 DOI 與浮水印。
    - 書脊檔(bookspine.tex)之年月資訊更正：學年 -> 口試通過年、學期 -> 口試通過月。
- 新增 tools/toc2txt.tex 用於轉換目錄檔 main.toc 為簡單文字檔。
- 修正 NTU 名稱（台 -> 臺）。
- 修正 author 範例（加句點 :D ）
- 修復書脊文字旋轉(RawFeature=vertical)


## v1.7 (2017-01-07)
- 支援 台大(NTU)、交大(NCTU) （依校方範例檔製作）
- 將基礎 class NCU_thesis_extbook.cls 更名為 thesis_base.cls（由於各 .tex 並非直接載入此檔，因此.tex中無須更動）。
- sppmgTool.sty 新增 \fs 指令 (\fontsize 快速版)


## v1.6.1 (2016-12-01)
- 修正 sppmgTool.sty 中的快速插圖指令


## v1.6 (2016-11-30)
- 合併（中央版）中英文的 class 檔(.cls)
- 基礎 class 由 book 改至 extbook，得以使用14pt以上字體大小。（免去使用\fontsize）
- 配合基礎字體變動，config.tex 中增加各種類型（圖說、表格....）文字樣式設定值。
- abstract/摘要 之章節標題前加上論文資訊 \abstractHeader* 且其樣式由\abstractHeaderStyle 設定。
- 自訂輔助寫作指令由 .cls 移入 sppmgTool.sty


## v1.5 (2016-10-27)
- 由「中央大學之中文版」複製並停用中文相關設定而成之英文版。
- 整理 class 檔內容
- 摘要頁增加論文題目等等的論文資訊。（依各校規定而有不同）
- 修正文獻資料庫(*.bib)的插入位置，並且實際插入一個 bib 到樣板中。


## v1.0 (2016-10-13)
- 首版釋出。僅支援中央大學之中文版。
- 內文大小由 \fontsize 進行調整。
