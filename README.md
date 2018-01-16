# The LaTeX Template for TW Thesis 台灣碩博士 LaTeX 論文樣板

![XeLaTeX](https://img.shields.io/badge/TeX-XeLaTeX-orange.svg)
[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/sppmg)

這個專案的目的是希望台灣的研究生可以快速上手 LaTeX（尤其是使用中文撰寫），讓寫論文的時間完整的用在內容上。

除了提供中文樣板讓使用者直接修改之外，同時提供一個簡易 [LaTeX 教學](https://github.com/sppmg/LaTeX_tutorial_for_thesis)，*教學檔原始碼也是樣板的最佳範例*。教學內容主要但不限於論文樣板範圍，一般 LaTeX 學習者亦歡迎參考使用。

建議至少花15分鐘快速瀏覽過教學。不懂沒關係，至少知道 LaTeX 有哪些功能、要到哪裡找。瀏覽一遍只要15分鐘，不知道好用功能可以浪費你好幾天。
*（學弟妹們！不要再手打圖表編號了啊!!）*

專案名稱為 TW Thesis Template 表示這是為了台灣的論文而設計，主要支援中文論文，並提供多個學校的樣板。
專案目前支援的學校如下(全部支援中(zh), 英(en)雙語系)：

|   中文校名       | 英文縮寫/目錄 | 審核通過 | 說明 |
| --------------- | ------------- | ------- | ------------- |
| 國立中央大學      | NCU    | 是 | 為其餘學校的基礎樣板。
| 國立臺灣師範大學   | NTNU   | ? | 與中央版完全相同，請自行修改校名（如 `titlepage.tex` 內）。
| 國立臺灣大學      |  NTU   | 是 | patch
| 國立交通大學      | NCTU   | ? | patch
| 國立清華大學      | NTHU   | ? | patch

- **上表中， patch 表示為補充檔，可經由內附工具(build.sh/build.bat)產生完整樣板。細節見[Wiki](https://github.com/sppmg/TW_Thesis_Template/wiki/%E5%88%9D%E7%B4%9A%E6%89%8B%E5%86%8A#patch-%E7%89%88%E6%A8%A3%E6%9D%BF%E4%BD%BF%E7%94%A8%E8%AA%AA%E6%98%8E)中的說明。**

- 「審核通過」表示確認已有學生用此樣板撰寫並審過。「?」者為未確認，但已盡力符合校方要求，應該不會有問題。

- 文獻列表樣式預設直接套用期刊(IEEE)樣式，**可能不符合校方、系所規定**，請視情況自行修改（看審核嚴格程度）。設定值位於 `config.tex` 與 `bibliography.tex`。

- [其他 LaTeX 樣板](https://github.com/sppmg/TW_Thesis_Template/wiki/%E5%90%8C%E5%A5%BD%E9%80%A3%E7%B5%90)可以參考他人製作方式，以及本樣板尚未支援的學校。


由於本樣板設計是以一本完整的書為目標，所以不僅僅是論文，日後撰寫書籍文件亦非常適合。

## 下載

基本上只要是 `Branch:master` 均為穩定版。直接按綠色 `Clone or download` 下載整個專案即可。

若要特定發怖版號可以至 [releases](https://github.com/sppmg/TW_Thesis_Template/releases)

若想嘗鮮可以切換 `Branch:develop` 後下載專案。不過我通常 `develop` 只在大改時才會有短時間和 `master` 有差異，普通使用者用 `master` 或 `releases` 即可。


## 使用說明

本專案說明分為下列 3 種

### 單純的使用手冊 
見本專案的 [Wiki](https://github.com/sppmg/TW_Thesis_Template/wiki) 。
MiKTeX 使用者請一定要閱讀 [MiKTeX 注意事項](https://github.com/sppmg/TW_Thesis_Template/wiki/MiKTeX-%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A0%85)。

### 各校樣式說明 
對於各校特有的說明放在其目錄下的 `README.md` (github 進入其目錄即可看到網頁呈現結果)。

### 教學手冊
包含詳細的 LaTeX 資訊，由軟體安裝到基礎 LaTeX 教學。即使不足以讓你成為大師，至少也能帶你入門。
亦有部份章節敘述樣板設定及使用方式。

此手冊使用 NCU_zh 作為基底，因此也是一個現成的 LaTeX 範例。

目前教學手冊獨立為一個專案，請移駕 https://github.com/sppmg/LaTeX_tutorial_for_thesis


## 回饋
使用上有問題或建議請回饋到 Issues 分頁。非中央版使用者若發生「格式不符」情況請於 Issues 提出修正建議（通過審核也請告知）。

## 最新消息
若有任何新的資訊，我會公佈於[Wiki-News](https://github.com/sppmg/TW_Thesis_Template/wiki/News)。

## 版本遷移資訊
這裡紀錄一些版本間的遷移資訊供舊版使用者遷移至新版本使用。各版本修改資訊見[Change Log](https://github.com/sppmg/TW_Thesis_Template/blob/master/CHANGELOG.md)。

| 版本/日期          | 資訊 |
| ----------------- | ------------- |
| v1.8 (2018-0?-??) | 相對於 v1.7 / v1.7.1 ，因基礎（共用）樣板新增功能，舊使用者須放上新的 `config.tex` ，請手動將相關資訊移入新版設定檔中。新 `config.tex` 對部份舊設定值順序略有調整，這點非常抱歉！其餘檔案基本上可以不用修正，直接將修改過的 chapter, appendix, macro_* 等移入即可。|
| v1.7 (2017-01-07) | 相容v1.6 |
| v1.6 (2016-11-30) | 中英文共用同一份cls檔，因此英文版的tex檔標頭由NCU_thesis_en.cls 改為 `NCU_thesis.cls`。 英文版的 compatibility 目錄中含有一個 `NCU_thesis_en.cls` ，舊有使用者可以將其複製至主檔目錄，即可使用新版cls而不須修改tex檔。|
| v1.5 (2016-10-27) | 各tex檔標頭稍改，\\chapter直接移入新版即可。 bib檔引入位置修正。之前置於`config.tex`是錯的。 |
