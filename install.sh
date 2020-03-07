# Isolated Development Environment Installation
# Poor man's storybook for scripts, with glitch

# https://www.lucidchart.com/invitations/accept/d77e6095-bd82-41af-a9cf-a48e056f39ee

# tldr;

# Problem:
# `return _cache( new Symbol( key ) )` should have been `return ( typeof key === 'Symbol' ) ? _cache( key ) : _cache( new Symbol( key ) )

# Solution:
# Standards - Script, Test, Diagram
# Isolated development with glitch ala storybook - unit testing - perf - prettier - lint

# @todo port to node
# - tdd faster

ROOT=""
SRC=""
REMOTEURL=""
DEST=""


if $1 == 'update'
	then 
		git pull origin master && npx run ./node_modules/karma && 

fi

if [ ! -e .config ]
	then 
		touch .config && echo 'notebook=glitch' >> .config && echo "notebook-remote-url=$REMOTEURL" >> .config
fi

if [ ! -e "$SRC" ]
	then
		mkdir $SRC
fi

mv $SRC

if [ ! -f index.js ]
	then
		touch index.js
fi

if [ ! -f .gitignore ]
	then
		touch .gitignore && echo "node_modules" >> .gitignore && git init && git remote add origin $REMOTEURL
fi

git pull origin

cp index.js DEST

# Performance and Benchmarking

cd $ROOT

if [ ! -e .config ]
	then
		touch .config && echo 'perf=js-perf'
fi

npm install js-perf

# Unit Tests

cd $ROOT

if [ ! -e .config ]
	then
		touch .config && echo 'unit_tests=jasmine'
fi

cd $SRC

npm install jasmine karma

touch karma.conf.js && curl "" >> karma.conf.js && mkdir tests && touch tests/.gitkeep && touch tests/index.spec.js && curl "" >> index.spec.js

npx run 

# Machine Analysis

npm install eslint prettier && touch .prettierrc && curl "" >> .prettierrc

# Reporting

cd $SRC && mkdir reports && touch reports/.gitkeep npm install allure

# Push
git add -A && git commit -m "scaffold" && git push origin master