# Change Log | 版本紀錄
不同於首頁（README.md）的遷移資訊僅說明版本間的轉移，這裡提供各發佈版的更動。（此檔於 2016-12-30 補上。舊版僅概略描述，詳細變動請參考 git log ）

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
- 整理 class 檔內容


## v1.5 (2016-10-27)
- 由「中央大學之中文版」複製並停用中文相關設定而成之英文版。

## v1.0 (2016-10-13)
- 首版釋出。僅支援中央大學之中文版。
- 內文大小由 \fontsize 進行調整。