#!/bin/bash

# 連番画像からmp4ムービーを作成：

# YouTube投稿用
ffmpeg -r 30 -i generative_1_%05d.png -vcodec libx264 -b:v 15M -g 30 -bf 2 -profile:v high  -coder 1 -pix_fmt yuv420p -movflags +faststart -r 60 out.mp4

# 参考: 
# https://www.bioerrorlog.work/entry/youtube-encoding-ffmpeg
# https://support.google.com/youtube/answer/1722171?hl=ja


# 動画を連結
ffmpeg -f concat -safe 0 -i concat.txt -c copy output.mp4

# concat.txt:
# file C:\\・・・\\generative_3\\white_out.mp4
# file C:\\・・・\\generative_3\\black_out.mp4
