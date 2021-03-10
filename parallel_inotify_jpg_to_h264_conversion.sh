#!/bin/bash

export root_folder=$1
export reqsubstr='dir1'

inotifywait -qmre create --format %w%f $root_folder/jpg/ |
  parallel -j10 'echo ${root_folder};var={/};if [ -z "${var##*$reqsubstr*}" ];then ffmpeg -i {} -c:v libx264 -crf 23 -pix_fmt yuv420p ${root_folder}/dir3/${var%.jpg}.h264;else ffmpeg -i {} -c:v libx264 -crf 23 -pix_fmt yuv420p ${root_folder}/dir4/${var%.jpg}.h264;fi'
