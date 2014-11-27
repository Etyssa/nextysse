# Etyssa Proof Of Concept

![logo](https://bytebucket.org/scriptx/nextysse/raw/b2288d2cca4105d11441157c2f6cc5e0ba4e562f/app/images/logo.png "logo")

In order to test and improve our new API, here is an implementation of our main features using AngularJs.


## Installation

    npm install 
    bower install

## Run the server

    grunt serve

## Deploy to scriptx.bitbucket.org

    from fabric.api import *
	from fabric.context_managers import settings

    REMOTE_REPO = "git@bitbucket.org:scriptx/scriptx.bitbucket.org.git"
	def prod():
        # local("git checkout master")
	    local("make freeze")
		with lcd("dist"):
		local("git init")
		local("git add .")
		local("git commit -m 'publishing'")
		local("git push %s master:master --force" % (REMOTE_REPO))
    # EOF

## Contributors
* vied12
* tinanimo
* smonff
