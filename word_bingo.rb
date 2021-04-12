# 標準入力から入力内容を取得
input = readlines

# 1行目の数字をSに代入
s = input[0].to_i

# 2行目からS+1行目の単語群を取得して1つの配列にする
word_lines = []
x = 0
while x < s
  word_lines << input[x + 1].chomp.split(' ')
  x += 1
end
bingo_card = word_lines.flatten

# S+2行目の数字をnに代入する
n = input[s + 1].to_i

# S+3行目からS+2+N行目の単語群を取得する
words = []
y = 0
while y < n
  words << input[s + 2 + y].chomp
  y += 1
end

# 配列wordsの中身を一つずつ調べ、含まれていればbingo_cardのindexを取得する
marked_index = []
words.each do |word|
  if bingo_card.index(word) != nil
    marked_index << bingo_card.index(word)
  end
end

# 取得したindexを昇順に並べ替え
marked_index.sort_by!{|n| n.to_i}

# 0と1の配列に変換し印が付いている、または付いていないの判定ができる下準備をする
marked = []
(s ** 2).times do |i|
  if marked_index.include?(i)
    marked << 1
  else
    marked << 0
  end
end

# 配列を分割して1行ごとの配列xlineを取得
xlines = marked.each_slice(s).to_a

# ビンゴ判定のための配列collection_yを用意
collection_y = []

# 横のビンゴ判定
xlines.each do |line|
  if line.count(1) == s
    collection_y << "y"
  end
end

# 1列ごとの配列ylineを取得
marked_y = []
s.times do |i|
  xlines.each do |line|
    marked_y << line[i]
  end
end
ylines = marked_y.each_slice(s).to_a

# 縦のビンゴ判定
ylines.each do |line|
  if line.count(1) == s
    collection_y << "y"
  end
end

# 斜めの配列dlineを取得
marked_d = []
xlines.each_with_index do |line, i|
  marked_d << line[i]
end
xlines.each_with_index do |line, i|
  marked_d << line[s-i-1]
end
dlines = marked_d.each_slice(s).to_a

# 斜めのビンゴ判定
dlines.each do |line|
  if line.count(1) == s
    collection_y << "y"
  end
end

# 1回でもビンゴの判定が出ていればyesを出力する
if collection_y.include?("y")
  puts "yes"
else
  puts "no"
end