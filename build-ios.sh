#!/bin/bash

out="flutter_frameworks"

echo "build frameworks put to : $out"

echo "------ clean begin ------"
flutter clean
rm -rf $out
rm -rf build
echo "------ clean end ------"


echo "------ get dependences begin ------"

flutter pub get

echo "------ get dependences end ------"


iphone_cmd="flutter build ios --release --no-codesign"
simulator_cmd="flutter build ios --debug --simulator --no-codesign"
build_cmd=${iphone_cmd}


if [[ $# == 1 ]]; then 
	if [[ $1 == '--simulator' ]]; then
		build_cmd=${simulator_cmd}
	fi
fi

echo "\n>>>>>> build_cmd : ${build_cmd} <<<<<<<\n"


echo "------ flutter build begin ------"

${build_cmd}


echo "------ flutter build success ------"


echo "------ copy begin ... ------"

copy_path="build/ios/Release-iphoneos/*/*.framework $out"
if [[ ${build_cmd} == ${simulator_cmd} ]]; then
	copy_path="build/ios/Debug-iphonesimulator/*/*.framework $out"
fi

mkdir $out

cp -r $copy_path
cp -r .ios/Flutter/App.framework $out
cp -r .ios/Flutter/engine/Flutter.framework $out

dstPath="../flutter_pod"
rm -rf "${dstPath}/flutter_frameworks"
cp -r $out ${dstPath}
rm -rf $out

echo "------ copy end ------"

echo "------ sucess !!! -----"

