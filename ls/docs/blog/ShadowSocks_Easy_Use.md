### 第一种方法（推荐） ###

	`wget http://dl.chenyufei.info/shadowsocks/shadowsocks-server-linux64-1.1.3.gz`
	`gzip -d *.gz`
	`chmod +x shadowsocks-server-linux64-1.1.3 `

	echo '
    {
        "server":"0.0.0.0",
        "server_port":8088,
        "local_port":1080,
        "password":"passwd!",
        "timeout":600,
        "method":""aes-256-cfb""
    }
    ' > config.json

	` nohup ./shadowsocks-server-linux64-1.1.3 &`

### 第二种方式（Debian/Ubuntu） ###

	