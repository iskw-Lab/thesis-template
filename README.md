# 学位論文 LaTeX テンプレート

upLaTeX（`ujreport`）+ dvipdfmx で学位論文（卒業論文・修士論文・博士論文）を書くためのテンプレートです．Windows / macOS / Linux で同じように使えます．

**完成イメージ：[sample.pdf](sample.pdf)**（このテンプレートをそのままビルドしたもの）

## 使い方

### 1. リポジトリを作る

GitHub 上でこのリポジトリの **「Use this template」→「Create a new repository」** を押して，自分用のリポジトリを作成してください（**Private 推奨**）．

```sh
git clone https://github.com/<あなたのアカウント>/<作ったリポジトリ>.git
cd <作ったリポジトリ>
```

### 2. 環境を用意する

#### TeX

| OS | インストール方法 |
| --- | --- |
| Windows | [TeX Live](https://www.tug.org/texlive/windows.html) の `install-tl-windows.exe` を実行（latexmk 用の Perl も同梱されています） |
| macOS | [MacTeX](https://www.tug.org/mactex/) をインストール，または `brew install --cask mactex-no-gui` |
| Linux | `sudo apt install texlive-full` など |

インストール後，ターミナル（Windows は PowerShell）で `latexmk -v` と `uplatex -v` が動けば OK です．

> [!TIP]
>
> - TeX Live 2020 以降は，どの OS でも日本語フォントに同梱の「原ノ味フォント」が埋め込まれるため，Windows と Mac で同じ見た目の PDF になります．
> - Windows で古い W32TeX や TeX Live が残っていると，そちらが使われて失敗することがあります．`where uplatex` で確認してください．
> - Windows のユーザ名が日本語の場合，インストーラが失敗することがあります．その場合は環境変数 `TEMP`/`TMP` を `C:\temp` などに変えてから実行してください．

#### Node.js（日本語の校正ツール textlint を使う場合）

[Node.js](https://nodejs.org/ja) の LTS 版をインストールしてください（Windows: `winget install OpenJS.NodeJS.LTS`，macOS: `brew install node`）．リポジトリのフォルダで一度だけ次を実行します．

```sh
npm install
```

#### エディタ

**VS Code を使う場合（推奨）**：フォルダを開くと推奨拡張機能（LaTeX Workshop，EditorConfig）のインストールを促されるので入れてください．`.vscode/settings.json` の設定により，保存するたびに自動でビルドされ，PDF がタブで開きます．

> [!NOTE]
> LaTeX Workshop の標準設定は pdfLaTeX 用のため日本語の文書ではビルドに失敗します．同梱の `.vscode/settings.json` はそれを `latexmk`（`.latexmkrc` の設定）で動かすよう上書きしています．

### 3. ビルドする

```sh
latexmk          # 00_main.pdf が生成される
latexmk -pvc     # ファイルを保存するたびに自動で再ビルド
latexmk -c       # 中間ファイルを削除
```

GitHub に push すると，GitHub Actions でも自動でビルドと textlint のチェックが行われます．Actions タブの該当の実行結果の「Artifacts」から PDF をダウンロードできます（手元に TeX 環境がなくても確認できます）．

### 4. 論文情報を設定する

`00_main.tex` の「論文情報」ブロックで，論文種別（卒業論文・修士論文・博士論文）・タイトル・氏名・学籍番号・指導教員などを設定します．表紙と PDF のメタ情報に反映されます．

## ファイル構成

| ファイル | 内容 |
| --- | --- |
| `00_main.tex` | メインファイル（論文情報・パッケージ・章の読み込み） |
| `01_macro.tex` | 自作マクロ（`\figref`，`\todo` など） |
| `02_title.tex` | 表紙 |
| `03_abstract.tex` | 概要 |
| `10_introduction.tex` 〜 `60_conclusion.tex` | 本文（1ファイル = 1章） |
| `A0_thanks.tex` | 謝辞 |
| `B0_references.tex` | 参考文献の出力設定 |
| `references.bib` | 参考文献データ（BibTeX） |
| `C0_figures.tex` | 図目次・表目次 |
| `D0_achievements.tex` | 研究業績 |
| `E0_appendix.tex` | 付録 |
| `graphics/` | 図（PDF 形式推奨） |

章を増減する場合は，ファイルを追加・削除して `00_main.tex` の `\input{...}` を編集してください．新しいファイルの先頭に `% !TEX root = 00_main.tex` と書いておくと，そのファイルを開いた状態でもメインファイルがビルドされます．

## 書き方のルール

記法の例は `30_method.tex` にまとめてあります（ビルドした PDF の第3章）．

### 参照

ラベルには種類ごとに接頭辞を付け，参照はマクロを使います．

| 対象 | ラベル | 参照 | 出力 |
| --- | --- | --- | --- |
| 図 | `\label{fig:xxx}` | `\figref{xxx}` | 図 1.1 |
| 表 | `\label{tab:xxx}` | `\tabref{xxx}` | 表 1.1 |
| 章 | `\label{chap:xxx}` | `\chapref{xxx}` | 第 1 章 |
| 節 | `\label{sec:xxx}` | `\secref{xxx}` | 1.1 節 |
| 数式 | `\label{eq:xxx}` | `\equref{xxx}` | 式 (1.1) |

### 参考文献（BibTeX）

1. Google Scholar の「引用」→「BibTeX」，CiNii，出版社のページなどから BibTeX をコピーして `references.bib` に貼り付ける
2. 本文中で `\cite{キー}` と書いて引用する（キーは `@article{キー,` の部分）

引用した文献だけが，引用順に参考文献リストに出力されます．著者名順にしたい場合は `B0_references.tex` のスタイルを `junsrt` から `jplain` に変えてください．

### 執筆中のメモ

`\todo{あとで図を追加}` と書くと PDF に赤字で表示されます．提出前に `01_macro.tex` の `\showtodotrue` を `\showtodofalse` に変えると一括で非表示になります（消し忘れ防止のため，提出前に `grep -n '\\todo' *.tex` で残っていないか確認するのがおすすめです）．

### 日本語の校正（textlint）

[textlint](https://textlint.github.io/) で，日本語の文章をチェックできます．

```sh
npm run lint       # チェックする
npm run lint:fix   # 自動で直せるもの（句読点・表記ゆれなど）を修正する
```

VS Code では拡張機能 textlint を入れると，書いている最中に問題箇所に波線が出ます．

主にチェックされる内容：

- 句読点が「，」「．」になっているか（`、` `。` は自動修正可）
- 「である」調と「です・ます」調が混ざっていないか（謝辞は対象外）
- 一文が長すぎないか（100文字まで），読点が多すぎないか
- 同じ助詞の連続（「〜に〜に」），冗長な表現（「〜することができる」），二重否定など
- 表記ゆれ（`prh.yml` に辞書があり，研究室の方針に合わせて追加できます）

ルールの設定は `.textlintrc.json` にあります．指摘はあくまで目安です．特定の箇所だけチェックを止めたい場合は，次のように書いてください．

```latex
% textlint-disable
ここはチェックされない．
% textlint-enable
```

> [!NOTE]
> LaTeX 用プラグインの仕様で，半角英数字と全角文字の間のスペースは検出されません．

### 原稿の書き方

- **1文ごとに改行する**：LaTeX では単独の改行は無視されるので，PDF の見た目は変わりません．1文1行にしておくと，Git の差分や指導教員の添削箇所が見やすくなります．段落を変えるときは空行を入れます．
- **句読点**は「，」「．」に統一しています．
- 図はできるだけ **PDF（ベクター形式）** で作成してください．PNG/JPEG も使えます．

## 提出前チェックリスト

- [ ] `00_main.tex` の論文情報（年度・タイトル・氏名・学籍番号・指導教員・所属）を設定した
- [ ] `\todo` が残っていない（または `\showtodofalse` にした）
- [ ] ビルド時に `undefined`（未定義の参照・引用）の警告が出ていない
- [ ] `npm run lint` の指摘を確認した
- [ ] 目次・図目次・表目次のページ番号が正しい
- [ ] `LICENSE` を削除した（テンプレートのライセンスは論文には関係ないので，消して問題ありません）
- [ ] 不要になったサンプル（`sample.pdf`，`30_method.tex` の記法例，`graphics/sample.pdf`，`references.bib` のサンプル）を削除した

## 注意

- 論文本文・実験データ・図には個人情報や未公開の研究内容が含まれることがあります．**自分のリポジトリは Private にしてください．**
- コンパイル結果の `00_main.pdf` や中間ファイルは `.gitignore` で除外しています．

## ライセンス

このテンプレートは [MIT No Attribution（MIT-0）](LICENSE) で公開しています．著作権表示の義務はないので，自由に改変・再配布できます．

ライセンスが適用されるのはテンプレート部分だけです．このテンプレートから作ったリポジトリでは `LICENSE` を削除してかまいません．各自が書いた論文の著作権は，それぞれの著者にあります．
