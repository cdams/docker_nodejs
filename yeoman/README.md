Container Docker with Yeoman
=============
 - Based on Centos6
 - Parent image : cdams/nodejs

How to use it?
--------------
### Running default : webapp
	docker run -it -v local/folder:/home/user cdams/nodejs_yeoman:centos6

### Running yo
	docker run -it -v local/folder:/home/user cdams/nodejs_yeoman:centos6 --generators

### Info for Windows Users
If npm install is run on Windows, errors could appear. Don't worry about