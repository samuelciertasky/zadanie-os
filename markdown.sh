#!/bin/bash
cat <<THE_END
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
</head>
<body>
THE_END
while read LINE
do
	if echo "$LINE" | grep '^$' >/dev/null
	then
		LINE=$(echo "$LINE" | sed -z 's@^$@<p>@g')
	fi

	if echo "$LINE" | grep '^# .*' >/dev/null
       	then
		LINE=$(echo "$LINE" | sed 's@^# \(.*\)@<h1>\1</h1>@g')
        fi

	if echo "$LINE" | grep '^## .*' >/dev/null
        then
                LINE=$(echo "$LINE" | sed 's@^## \(.*\)@<h2>\1</h2>@g')
        fi
	
	if echo "$LINE" | grep '__[^ ]*__' >/dev/null
        then
                LINE=$(echo "$LINE" | sed 's@__\([^ ]*\)__@<strong>\1</strong>@g')
        fi
	
	if echo "$LINE" | grep '_[^ ]*_' >/dev/null
        then
                LINE=$(echo "$LINE" | sed 's@_\([^ ]*\)_@<em>\1</em>@g')
        fi
	
	if echo "$LINE" | grep '<https://[^ ]*>' >/dev/null
	then
		LINE=$(echo "$LINE" | sed 's@<https://\([^ ]*\)>@<a href="https://\([^ ]*\)">https://\1</a>@g')
	fi
echo "$LINE"
done

while IFS= read LINE
do
	if echo "$LINE" | grep '^ - .*' >/dev/null
	then
		LINE=$(echo "$LINE" | sed 's@^ - \(.*\)@<li>\1</li>@g')
	fi
echo "$LINE"
done

cat <<THE_END
</body>
</html>
THE_END
