# Papers Directory

発表準備と引用管理のための論文置き場。

## Structure

- `00 Context Encoders`
- `01 Instance Discrimination`
- `02 Contrastive Predictive Coding`
- `03 SimCLR`
- `04 MoCo`

各ディレクトリには次を置く。

- `README.md`: 保存元、簡単な要約、発表内での用途メモ
- `paper.pdf`: 論文本体
- `paper.txt`: PDF から抽出したテキスト
- `source.tar`: 取得できた arXiv source bundle
- `source/`: `source.tar` を展開したもの

## Notes

- `paper.txt` はpypdf を使ってテキスト抽出なので、数式や段組みは崩れていることがある
- 引用や図の確認には `paper.pdf` を優先する
- 発表用の説明メモは各ディレクトリの `README.md` に追記していく
- 実体ファイルの再取得は `scripts/fetch-papers.sh` で行う
