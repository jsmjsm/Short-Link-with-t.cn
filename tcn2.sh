#!/bin/zsh
#
# https://github.com/jsmjsm
# Version 1.1
result2=$(curl -s -X POST -H "Host: www.lazyfarmer.top" -d "url=$1" "http://www.lazyfarmer.top/api/short/sina")

isSuccess=$(echo $result2 | grep -E -o 'true' | head -1)

if [ $isSuccess = "true" ]; then
    link=$(echo $result2 | sed 's/\\//g' | grep -E -o  'http.*?}' | sed 's/"}//g' )
    echo $link | pbcopy
    osascript <<EOF
	display notification "$link" with title "短链接已经复制到剪贴板"
EOF
else
    errorInfo="Error！接口可能已经失效 或传入连接出错"
    echo $errorInfo
    { osascript -e 'display notification "接口可能已经失效 或传入连接出错" with title "转换失败" ' } || {echo "lost terminal-notifier " }
fi

