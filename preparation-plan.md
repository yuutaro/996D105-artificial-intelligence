# Self-supervised Learning / Contrastive Learning 発表準備メモ

## この発表で目指すこと

この発表のゴールは、Self-supervised Learning を広く網羅することではなく、次の 2 点を明確に説明できるようになることです。

1. Self-supervised Learning とは何か
2. Contrastive Learning がどのように表現学習を行うのか

20〜30 分の発表で扱う主軸は `SimCLR` と `MoCo` に置く。  
それ以前の流れとして、`pretext task` 系の発想と、`instance discrimination` / `CPC` を短く押さえる。

## 最低限の到達目標

発表前に、次のことを自分の言葉で説明できる状態にする。

- Self-supervised Learning とは
- 表現学習とは何か
- positive pair / negative pair とは何か
- data augmentation がなぜ重要なのか
- Contrastive Learning の損失が何をしているのか
- SimCLR と MoCo の違い

## 読む論文

### 必読

1. Chen et al., `A Simple Framework for Contrastive Learning of Visual Representations` (SimCLR, ICML 2020)
2. He et al., `Momentum Contrast for Unsupervised Visual Representation Learning` (MoCo, CVPR 2020)

### 補助

3. van den Oord et al., `Representation Learning with Contrastive Predictive Coding` (CPC, 2018)
4. Wu et al., `Unsupervised Feature Learning via Non-Parametric Instance Discrimination` (CVPR 2018)

### 導入用に 1 本だけ読む

5. Pathak et al., `Context Encoders: Feature Learning by Inpainting` (CVPR 2016)

## 論文ごとの役割

### 1. Context Encoders

役割:
- 初期の self-supervised learning の雰囲気を掴む
- 「人手ラベルなしで補助タスクを解かせると表現が学べる」という発想を理解する

ここで理解すべきこと:
- pretext task とは何か
- なぜ inpainting のような補助課題で特徴が学べるのか
- ただの再構成と、下流タスクに使える表現学習の違い

深追いしなくてよいこと:
- 生成品質
- adversarial loss の細部

### 2. Instance Discrimination

役割:
- 「各インスタンスを区別する」という contrastive 的発想の入口を理解する
- NCE 的な考え方の前段を掴む

ここで理解すべきこと:
- クラス分類ではなく、各サンプルを識別対象にするとはどういうことか
- 似たサンプル同士が近い表現になるとはどういう意味か

深追いしなくてよいこと:
- 実装上のメモリバンクの細部

### 3. CPC

役割:
- InfoNCE の発想を押さえる
- contrastive loss が「正例を他候補から当てる softmax 型の損失」に近いことを理解する

ここで理解すべきこと:
- positive sample / negative sample
- latent space で予測するという考え方
- InfoNCE の式の見方

深追いしなくてよいこと:
- mutual information の厳密証明
- 音声や強化学習の実験

### 4. SimCLR

役割:
- 今回の発表の中心
- contrastive learning の標準的な説明軸を作る

ここで理解すべきこと:
- 2 views を作る流れ
- encoder と projection head の役割
- cosine similarity
- NT-Xent loss
- augmentation が本質的に重要であること

特に押さえること:
- 学習後は projection head を捨てる
- batch 内の他サンプルを negative とみなす
- augmentation の設計が学習信号を決める

### 5. MoCo

役割:
- SimCLR との比較対象
- 大 batch を使わずに多くの negative を確保する工夫を理解する

ここで理解すべきこと:
- queue
- momentum encoder
- large and consistent dictionary という考え方

特に押さえること:
- SimCLR は大 batch 寄り
- MoCo は queue で辞書を保つ
- momentum update により表現の変化を滑らかにする

## 読む順番

次の順で読む。

1. Context Encoders
2. Instance Discrimination
3. CPC
4. SimCLR
5. MoCo

この順番にする理由:
- 最初に「自己教師あり学習とは何か」を掴む
- 次に「各サンプルを識別する」という contrastive 的発想に入る
- その後に InfoNCE を理解する
- 最後に SimCLR と MoCo で現在の主題に入る

## 論文のどこまで読めばよいか

全部を丁寧に読む必要はない。まずは次だけ読む。

### Context Encoders

- Abstract
- Introduction
- Method の概要
- Figure 1

読めば十分なこと:
- pretext task の考え方

### Instance Discrimination

- Abstract
- Introduction
- Method の最初の部分
- 問題設定の説明図

読めば十分なこと:
- instance-level discrimination の意味

### CPC

- Abstract
- Introduction
- InfoNCE が出てくる節
- 画像への適用を説明する図

読めば十分なこと:
- InfoNCE をどう読むか

### SimCLR

- Abstract
- Introduction
- Figure 2
- Method 2.1
- loss の式
- augmentation と projection head の説明

読めば十分なこと:
- 発表の中心に使う図と式

### MoCo

- Abstract
- Introduction
- Figure 1
- queue と momentum encoder の説明

読めば十分なこと:
- SimCLR との比較材料

## 論文を読む前に学ぶべき基礎

今の前提知識から追加で必要なのは次の内容。

### 1. 表現学習

学ぶこと:
- 特徴量を学ぶとは何か
- 下流タスクで使える表現とは何か
- pre-training と fine-tuning の関係

自分で言えるようにすること:
- 「分類器を直接作るのでなく、使い回せる特徴ベクトルを作る」

### 2. 埋め込みベクトルと類似度

学ぶこと:
- ベクトル表現
- コサイン類似度
- 近い / 遠い が何を意味するか

最低限の式:

```text
sim(u, v) = (u^T v) / (||u|| ||v||)
```

### 3. softmax と cross-entropy の見方

学ぶこと:
- 候補の中から正解を当てる損失としての cross-entropy
- Contrastive Learning の loss がこれに近いこと

自分で言えるようにすること:
- 「正例のスコアを他候補より相対的に高くする」

### 4. Data Augmentation

学ぶこと:
- crop
- color jitter
- blur
- 同じ画像から複数の view を作る意味

自分で言えるようにすること:
- 「augmentation は前処理ではなく、何を同一視するかを決める仕組み」

## あなたがやるべき具体的タスク

### タスク 1: 基礎用語を整理する

やること:
- `表現学習`
- `事前学習`
- `fine-tuning`
- `embedding`
- `cosine similarity`
- `positive pair`
- `negative pair`
- `augmentation`

完了条件:
- 各用語を 1〜2 文で説明できる

### タスク 2: Self-supervised Learning の位置づけを整理する

やること:
- supervised learning との違いを書く
- unsupervised learning との違いを書く
- self-supervised learning の定義を自分の言葉で書く

完了条件:
- スライド 1 枚分の文章が作れる

### タスク 3: Context Encoders を読む

やること:
- Abstract と Introduction を読む
- pretext task の意味をメモする
- 「なぜラベルなしで学習できるか」を 3 行で書く

完了条件:
- 導入スライドで 1 分説明できる

### タスク 4: Instance Discrimination を読む

やること:
- Abstract と Introduction を読む
- 「各インスタンスを区別する」とは何かをメモする
- クラス分類との違いを 3 行で書く

完了条件:
- contrastive 的発想の入口として説明できる

### タスク 5: CPC を読んで InfoNCE を理解する

やること:
- InfoNCE の式を読む
- positive / negative の意味を整理する
- 「softmax に近い損失」として説明できるようにする

完了条件:
- 式を見ながら 2〜3 分説明できる

### タスク 6: SimCLR を読む

やること:
- Figure 2 を見て流れを説明できるようにする
- encoder / projection head / loss の関係を整理する
- augmentation が重要な理由をメモする

完了条件:
- SimCLR の学習パイプラインを図なしでも説明できる

### タスク 7: MoCo を読む

やること:
- Figure 1 を見て SimCLR との違いを整理する
- queue の役割を書く
- momentum encoder の役割を書く

完了条件:
- SimCLR と MoCo の比較表を作れる

### タスク 8: 発表用の主張を 3 つに絞る

やること:
- 発表で一番伝えたい点を 3 つ書く

候補:
- Self-supervised Learning はラベルなしで学習信号を作る枠組み
- Contrastive Learning は同じものを近づけ、違うものを遠ざける
- SimCLR と MoCo はその代表的手法で、negative の扱い方が異なる

完了条件:
- まとめスライドの骨子ができる

### タスク 9: スライドに載せる図と式を決める

やること:
- SimCLR の全体図
- MoCo の全体図
- InfoNCE か NT-Xent の式
- positive / negative pair の概念図

完了条件:
- スライド素材の候補が決まっている

## 1 週間の進め方

### Day 1

- 基礎用語を整理する
- supervised / unsupervised / self-supervised の違いをまとめる

### Day 2

- Context Encoders を読む
- Instance Discrimination を読む

### Day 3

- CPC を読んで InfoNCE を理解する
- 式の意味を日本語で書き下す

### Day 4

- SimCLR を読む
- Figure 2 と NT-Xent loss を重点的に整理する

### Day 5

- MoCo を読む
- SimCLR との比較表を作る

### Day 6

- 発表の章立てを作る
- 各スライドに何を書くか箇条書きにする

### Day 7

- 発表練習をする
- 20 分版と 30 分版の両方で時間を測る

## スライド作成に入る前のチェックリスト

- Self-supervised Learning を 1 分で説明できる
- Contrastive Learning を 2 分で説明できる
- InfoNCE / NT-Xent の意味を説明できる
- SimCLR の流れを説明できる
- MoCo の工夫を説明できる
- SimCLR と MoCo の違いを比較できる

## 発表で削るべき話題

次の話題は、今回の時間と前提知識では優先度が低い。

- mutual information の厳密な理論
- BYOL / SimSiam の詳細
- 全ての SSL 手法の歴史
- 実験結果の細かい数値比較
- 実装上のハイパーパラメータの細部

## 最終的な発表の軸

この発表では、次の流れに乗せる。

1. ラベルなしでどう学ぶかという問題設定
2. Self-supervised Learning という考え方
3. Contrastive Learning の基本原理
4. SimCLR による標準的な枠組み
5. MoCo による改良
6. 意義と限界

この軸がぶれなければ、20〜30 分の発表として十分まとまる。
