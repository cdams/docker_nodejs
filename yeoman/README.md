Container Docker with Yeoman
=============
 - Based on Centos7
 - Parent image : cdams/nodejs

How to use it?
--------------
### Running default : webapp
	docker run -it -v local/folder:/home/user cdams/nodejs_yeoman

### Running yo
	docker run -it -v local/folder:/home/user cdams/nodejs_yeoman --generators

### Info for Windows Users
If npm install is run on Windows, errors could appear. Don't worry about