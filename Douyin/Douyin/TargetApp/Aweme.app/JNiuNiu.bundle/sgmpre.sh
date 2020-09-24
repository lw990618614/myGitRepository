#bin/sh

sgm_modify_json()
{
if [[ $1 == 'nopod' ]]; then
	#搜索下
	ATT_HEADER_PATH=`find $TARGET_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH -name sgmprej -type f`
else
    ATT_HEADER_PATH="$PODS_CONFIGURATION_BUILD_DIR/$1/JNiuNiu.bundle/sgmprej"
fi
echo $ATT_HEADER_PATH
if [ ! -f "$ATT_HEADER_PATH" ]; then
echo "路径不存在：$ATT_HEADER_PATH"
return
fi

#bundleID
ciphertext=""
for ((i=0; i < ${#bundleID}; i++ ))
do
ord=$(printf "%d" "'${bundleID:$i:1}")
t=`printf "%x" $((ord-1))`
tmp=$(printf "\\x$t")
ciphertext="${ciphertext}${tmp}"
done
echo $ciphertext
sed -i "" "s#\"bid\".*#\"bid\":\"$ciphertext\",#g" $ATT_HEADER_PATH

#teamID
ciphertext=""
for ((i=0; i < ${#teamID}; i++ ))
do
ord=$(printf "%d" "'${teamID:$i:1}")
t=`printf "%x" $((ord-1))`
tmp=$(printf "\\x$t")
ciphertext="${ciphertext}${tmp}"
done
echo $ciphertext
sed -i "" "s#\"tid\".*#\"tid\":\"$ciphertext\",#g" $ATT_HEADER_PATH

#buildVer
ciphertext=$(echo $buildVer | base64)
echo $ciphertext
sed -i "" "s#\"buid\".*#\"buid\":\"$ciphertext\"#g" $ATT_HEADER_PATH

if [[ $1 != 'nopod' ]]; then
#touch bundle
BUNLDE_PATH="$PODS_CONFIGURATION_BUILD_DIR/$1/JNiuNiu.bundle"
touch $BUNLDE_PATH
fi
}

bundleID=${PRODUCT_BUNDLE_IDENTIFIER}
teamID=${DEVELOPMENT_TEAM}

echo "当前应用的bundleID:"
echo $bundleID

echo "当前应用的PODS_CONFIGURATION_BUILD_DIR:"
echo $PODS_CONFIGURATION_BUILD_DIR

echo "当前应用的teamID："
echo $teamID

infoplist="$INFOPLIST_FILE"
echo "当前infoPlist路径："
echo $infoplist

echo "当前版本号："
buildVer=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$infoplist")
echo $buildVer

if [[ $1 == 'nopod' ]]; then
	#不使用cocoapods
	sgm_modify_json $1
else
	for dir in $(ls "$PODS_CONFIGURATION_BUILD_DIR"/)
	do
	#echo $dir
	if [[ $dir == "SecGuard"* ]]; then
		echo $dir
		sgm_modify_json $dir
		fi
	done
fi



