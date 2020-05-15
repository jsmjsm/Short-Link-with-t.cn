#!/bin/zsh
#
# https://github.com/jsmjsm
# usage:
# step1: $ chmod 777 ./tcn.sh
# step2: $ ./t.cn longlink

result2=$(curl -X POST -H "User-Agent: Shortcuts/1050.19 CFNetwork/1125.2 Darwin/19.4.0" -H "Content-Type: application/x-www-form-urlencoded" -H "Host: www.lazyfarmer.top" -d "url=$1" "http://www.lazyfarmer.top/api/short/sina")

result=$(curl -k -X GET -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 12_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148" "https://api.uomg.com/api/long2dwz?dwzapi=tcn&url=$1")
isSuccess=$(echo $result | grep -E -o '[1-9]' | head -1)
if [ $isSuccess ]; then
    link=$(echo $result | sed 's/\\//g' | grep -E -o  'http.*' | sed 's/"}//g')
    echo $link | pbcopy
    osascript <<EOF
	display notification "$link" with title "短链接已经复制到剪贴板"
EOF
else
    errorInfo="Error！接口可能已经失效 或传入连接出错"
    echo $errorInfo
    { osascript -e 'display notification "接口可能已经失效 或传入连接出错" with title "转换失败" ' } || {echo "lost terminal-notifier "}
fi

