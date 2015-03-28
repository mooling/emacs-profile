### VPS准备

最近工作需要访问谷歌，但是总是没法使用，没有办法。经同事介绍可以购买国外的VPS，经由SS转发然后即可使用谷歌了，于是乎购入RamNode、UltraVPS。

同事推荐的[RamNode](http://ramnode.com/)，这个时延大概在300ms左右，但是丢包率还算可以，15美金1年128M的，可以使用PayPal来支付，可以使用优惠码：WOWSSD5。个人的PP账户是在2013年注册的，但是需要绑定信用卡比较戒备，所以就没有使用，现在为了谷歌没办法，只能重新开通，绑定信用卡扣除1.95美金然后还有1美金，由于长期不用账户冻结，电话申请解冻之后然后咨询一美金的问题，答曰这个是预授权，后面会退回到信用卡中，后面还要看账单核对一下。昨天PP客服给我电话，说之前问题有无解决PP服务如何之类的问题，最后说会给我的PP账户一个红包10$。由于只有128M只开了SS，总体还不错，平时只使用40M内存。另外，我申请的时候下单总是告知Fraud，提交工单、上传身份证多次才解决，还有一个问题，同事推荐的64位Ubuntu，后面才知道小内存32位就好了，就酱紫了，懒！

在赵荣部落得知 [UltraVPS](http://ultravps.com) 的 [512M内存特价16$](http://www.zrblog.net/13754.html)。于是乎又购买了一个，做了这个博客，这个使用的是信用卡支付，所以购买的小伙伴们需要注意下。买的拉斯维加斯的服务器，当时看重的是时延短一般在200ms左右，但是实际欠考虑丢包比较多不稳定，平均在14的丢包率。这个也是告知Fraud，提交工单、上传身份证搞定，这家对于工单解决比较怠慢。 

### 安装Nginx、mysql、php

#### 安装软件，没有使用lnmp，主要还是比较信任官方的。

	```bash
    apt-get update  
    apt-get install nginx  
    apt-get install mysql-server mysql-client    
    apt-get install php5-fpm php5-mysql  
	```

#### 编辑 /etc/php5/fpm/php.ini

    查找fix_pathinfo，将前面的注释取消，并将1改为0.

    > **cgi.fix_pathinfo=0**

#### 编辑/etc/nginx/sites-available/default

	root /usr/share/nginx/www;  
	index index.html index.htm **index.php**;  
	location ~ \.php$ {  
       	fastcgi_split_path_info ^(.+\.php)(/.+)$;  
       	fastcgi_pass unix:/var/run/php5-fpm.sock;  
       	fastcgi_index index.php;  
		include fastcgi_params;  
	}

#### 建立WordPress使用的库

    `mysql -u root -p`
	>`create database liushao_blog;`  
	>`\q`

#### 安装WordPress

	```bash
    cd /usr/share/nginx/www  
    wget https://cn.wordpress.org/wordpress-4.1-zh_CN.tar.gz  
    tar zvxf wordpress-4.1-zh_CN.tar.gz  
    mv wordpress blog  
    chown -R root:root blog/  
    ```

#### 修改WordPress配置

	`cp wp-config-sample.php wp-config.php`	

     17 /** WordPress数据库的名称 */
     18 define('DB_NAME', 'wp_blog');
     19 
     20 /** MySQL数据库用户名 */
     21 define('DB_USER', 'user');
     22 
     23 /** MySQL数据库密码 */
     24 define('DB_PASSWORD', 'pass');

	`service nginx restart`  

	然后进入web页面进行安装。


#### 安装WordPress主题

	`cd /usr/share/nginx/www/blog/wp-content/themes` 

	- [twentyeleven](https://wordpress.org/themes/twentyeleven/) : `wget https://downloads.wordpress.org/theme/twentyeleven.2.0.zip`
	- [iconic-one](http://themonic.com/iconic-one/) : `wget https://downloads.wordpress.org/theme/iconic-one.1.4.4.zip`

#### 安装WordPress插件
	
	`cd /usr/share/nginx/www/blog/wp-content/plugins`
	
	- [jetpack](https://wordpress.org/plugins/jetpack/) : `wget https://downloads.wordpress.org/plugin/jetpack.3.4.1.zip`  

### GitHub 原文
	
	- [Vps_and_Wordpress.md](https://github.com/mooling/emacs-profile/blob/master/ls/docs/blog/Vps_and_Wordpress.md) 

    

 