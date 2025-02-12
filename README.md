# Tripper(トリッパー)【手軽な旅程作成アプリ】

[![Tripper](https://github.com/user-attachments/assets/f686cf56-0399-4be9-a111-926cb9a5e150)](https://www.canva.com/design/DAGUuXfYn10/C_nEnGAhQ6wl7HIEXvoSzw/watch?utm_content=DAGUuXfYn10&utm_campaign=designshare&utm_medium=link&utm_source=editor)
**クリックしてデモ動画再生**
## 製品概要
みんなの旅行プランをもとに、手軽に旅程を作成できるアプリです！

### 背景(製品開発のきっかけ、課題等）
新型コロナが収束し、国内外の旅行者は増加しています。
みなさんは旅行の予定を立てるのが面倒だと思ったことはありませんか？約7割に上る人が旅行の計画に「手間がかかる」、「難しい」などのストレスを感じるといわれています。（[株式会社 旅行工房調べ](https://about.tabikobo.com/news/press/2018/06/180605/)）


これに対して、数多くの旅行プラン作成アプリ（[tabiori](https://tabiori.com/)、[Funliday](https://www.funliday.com/jp)など）がリリースされていますが、これらのアプリには次のような課題があります。

* 他人の作成した旅行プランが閲覧できないため、スクラッチから入力する必要がある
* 旅行プランの入力時ぶ位置情報などの複雑な情報と結びついており、おおまかな日程がわかりにくい

### 解決出来ること
**Tripper（トリッパー）** は旅行プラン作成の煩わしさを解消します。みんなが作成した旅行プランを編集して自分好みにカスタマイズすることで、手軽に旅行プランを立てることを可能にしました。 

### 製品説明（具体的な製品の説明）
**Tripper** は、他のユーザーが作成した旅行プランをベースにスケジュールをカスタマイズできるアプリです。旅行プランの作成画面では、行きたい場所やその日時を直感的に追加・変更でき、煩わしい入力作業を減らします。また、他のユーザーが投稿した旅行プランを参考にすることで、目的地やスケジュールの選択が容易になります。

### 特長
#### 1. 他ユーザーの旅行プランを参考にしやすい
他ユーザーが公開している旅行プランからプランを選び、行きたい場所をクリックするだけで自分用に簡単にカスタマイズできます。

#### 2. 直感的で簡単な旅行プラン編集
日付や時間、訪問場所の編集がシンプルな操作で行えます。

#### 3. 旅行プランシェア機能
作成した旅行プランを簡単に他のユーザーと共有できます。友人や家族とリアルタイムで計画を共有し、調整もスムーズに進められます

### 今後の展望
#### 1. おすすめの旅行プランの提案機能
人気の観光地や旅行シーズンに合わせた「おすすめの旅行プラン」の提供も検討しています。将来的にはAIを活用し、ユーザーの好みに基づいたプランを自動で提案できるようにすることを目指しています。

#### 2. AIによる不適切なプランの自動検出
公序良俗に反するようなプランや、botなどによる有害なデータなどをAIによって常時監視することでユーザが安心して利用できる環境を整えます。

#### 3. AIによるイベントアイコンの自動生成
イベントのテーマに応じた多様なスタイルのアイコンを自動生成することで、ユーザーが選択する手間を減らしつつ、従来のアイコンでは伝わりにくかった「曖昧さ」を解消して、イベントの意図に合ったデザインを提供できます。

### 注力したこと（こだわり等）
* ユーザーの使いやすさを重視したUIデザイン：直感的な操作とシンプルなインターフェースで、初心者でも簡単に旅程を作成できるようにしました。
* 軽快な操作感：アプリの動作を軽快にするために、データの処理と読み込みの最適化に注力しました。

## 開発技術
### 活用した技術

#### フレームワーク・ライブラリ・モジュール
* SwiftUI　
* Firebase Authentication : ユーザ認証
* Firebase : データベース

#### デバイス
* iOSデバイス

### 独自技術
#### ハッカソンで開発した独自機能・技術
* ハックデイ以前に開発した機能
  * ユーザ登録・ログイン機能
* ハックデイ期間中に開発した機能
  * 旅程の作成・編集・削除
  * 他のユーザの旅程の閲覧・コピー・カスタマイズ
  * ユーザの検索
  * 都道府県別の旅程の検索
  * 他のユーザの旅程に対するいいね機能  
