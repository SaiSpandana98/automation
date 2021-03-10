#!/bin/bash

root_folder=$1
reqsubstr='dir1'

inotifywait -qmre create --format %w%f $root_folder/jpg/ |
    while read dir action file; do
	
	if [ -z "${file##*$reqsubstr*}" ]; then
		echo "The file ${file} appeared in directory ${root_folder}/jpg/dir1/ via ${action} :: $(date +"%d-%m-%Y %T.%3N %Z")"
  		ffmpeg -i ${root_folder}/jpg/dir1/${file} -c:v libx264 -crf 23 -pix_fmt yuv420p "$root_folder/dir3/${file%.jpg}.h264"
		echo ${file} conversion done at $(date +"%d-%m-%Y %T.%3N %Z")
	else
		echo "The file ${file} appeared in directory ${root_folder}/jpg/dir2/ via ${action} :: $(date +"%d-%m-%Y %T.%3N %Z")"
		ffmpeg -i ${root_folder}/jpg/dir2/${file} -c:v libx264 -crf 23 -pix_fmt yuv420p "$root_folder/dir4/${file%.jpg}.h264"
		echo ${file} conversion done at $(date +"%d-%m-%Y %T.%3N %Z")
	fi
    done

