# ぶれいんふぁっきゅ

HIRAGANA is KAWAII!

ひらがなの可愛さを伝えるために作られたネタプログラム。

かわいさのために、ひらがなしか出力できず、濁点も出力できないという業を背負った。


```
ruby yumekawa.rb run hello-world.yf
```

```
> ruby yumekawa.rb run hello-world.yf
はしるのつらい。 // これはrunコマンドを打つと表示される。かわいいから表示させてる。
はろぉ、わぁるとてんてん。
```

brainf*ckの記号と対応させる感じで組んでいます。

対応表

| + | - | > | < | [ | ] | . |
|---|---|---|---|---|---|---|
| ゆ | わ | か | ふ | ぁ | っ | め |

## Qiitaから抜粋

### サンプル

試しにあいしてると表示させてみる。

``` i-love-you.yf
ゆめゆめゆゆゆ
ゆゆゆゆゆ
ゆゆめゆゆゆ
ゆゆゆゆめゆ
ゆゆゆゆゆ

ゆゆゆゆゆ
ゆゆゆゆゆ
ゆゆゆゆゆ
ゆゆゆめ
```

```
$ ruby yumekawa.rb run i-love-you.yf
> はしるのつらい。 // これはrunコマンドを打つと表示される。かわいいから表示させてる。
> あいしてる
```

かわいいですね。
ハローワールドもあります。

```hello-world.yf
ゆゆゆゆゆぁかゆゆゆゆゆふわっかゆめ
ふ
ゆゆゆゆぁかゆゆゆゆゆふわっかわめ
ふ
ゆゆゆゆゆぁかゆゆゆふわっかめ
ゆゆゆゆゆめ
ふ
ゆゆゆゆゆぁかわわわわふわっかゆめ
ふ
ゆゆゆぁかゆゆゆふわっかゆめ
ふ
ゆゆゆぁかわわわわふわっかわめ
ふ
ゆゆゆゆゆゆぁかわわわわふわっかゆめ
か
ゆゆゆゆゆぁかゆゆゆゆふわっかわめ
か
ゆゆゆゆゆゆゆゆゆゆぁかゆゆゆゆゆふわっかめ
ふふめ
かかめ
か
ゆゆゆぁふゆゆゆゆゆかわっふゆめ
```

```
$ ruby yumekawa.rb run hello-world.yf
> はしるのつらい。 // これはrunコマンドを打つと表示される。かわいいから表示させてる。
> はろぉ、わぁるとてんてん。
```

### 文字出力とメモリの対応

メモリが１のときには「あ」を出力、２のときは「い」を出力みたいにしてます。
内部の配列でこんな感じで持っています。

```
@char_dict = [
'',
# 1
'あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 
'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と',
'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'へ', 'ほ',
'ま', 'み', 'む', 'め', 'も', 'や', '', 'ゆ', '','よ',
'ら', 'り', 'る', 'れ', 'ろ', 'わ', '', 'を', '', 'ん',
# 51
'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ', #55
#56
'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'ゃ', 'ゅ', 'ょ', 'っ', #64
#65
'、', '。', '　', "\n", #67
]
```

なので、メモリが６８以上の時に出力（ゆめかわふぁっきゅでは「め」）をしても何も表示されません。

あいうえおかきくけこ、、、、、、と表示したい時はこんな感じで記述します。

```
ゆめゆめゆめゆめゆめ　// あ行
ゆめゆめゆめゆめゆめ　// か行
・
・
・
```
