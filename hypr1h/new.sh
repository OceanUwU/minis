#!/usr/bin/bash
dir=$(date '+%y-%m-%d')
cp -r template $dir
sed -i "s/template/$dir/" $dir/project.godot
org.godotengine.Godot -e $dir/project.godot &
org.gimp.GIMP $dir/assets/icon.png &