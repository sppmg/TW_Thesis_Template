# Change Log | 版本紀錄
不同於首頁（README.md）的遷移資訊僅說明版本間的轉移，這裡提供各發佈版的更動。（此檔於 2016-12-30 補上。舊版僅概略描述，詳細變動請參考 git log ）

## v1.8 (2018-0?-??)

- 新增功能
  - 支援清大樣式
  - 支援(多頁)浮水印。
  - 章間頁可選用純白頁（不含頁首頁尾）。
  - 支援自動選用 Mac 字型 （Thanks [borting](https://github.com/borting/nctu-thesis/) ）
  - 文獻支援三種插入方法，由 config.tex 簡單切換。
  - 目錄支援 `frontmatter` 區段使用不同字體風格。
  - 附上中大中英文件，並加入英文文件之自動填單。（文件於 2018-01-11 確認與校方一致）
  - 非 XeLaTeX 錯誤訊息。
  - 於 `macros_preamble.tex` 附上已註解的 `blindtext` 、 `glossaries` 套件，解註後使用。
  - `\tableofcontents`, `\listoffigures`, `\listoftables` 可由 `config.tex` 切換自動加入目錄頁。（不再需要於 `main.tex` 手動加入指令，因此 `main.tex` 同步移除相關指令。）

- 修改
  - 開發環境升級至 Tex Live 2016 ，舊的 TeX 發行版將不再特別支援。
  - mhchem 套件之語法版號 3 -> 4 (2012 不支援)
  - `macros_preamble.tex` 新增 `\macrosAfterHyperref` 用於放置須於 `hyperref` 套件之後載入的指令。此後建議所有導言區內容均移入 `macros_preamble.tex`
  - `\frontmatter` 中所有圖、表、方程的編號顯示成 `0.1` 的格式(原 `book.cls` 設定為當 chapter <= 0 時不顯示 `章.`)
  - `config.tex` 重排順序。
  - 變數更名：
    -`config.tex`: `\titleStyle` -> `\titleNumStyle`
  - 教學檔移出成獨立專案。

- 移除 `NCU_en/compatibility/` (舊版之相容性檔案，已不需要)

## v1.7.1 (2017-09-14)
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
- tools 加入 unix2dos4toc.bat


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
