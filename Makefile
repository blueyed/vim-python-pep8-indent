test:
	VIMRUNNER_REUSE_SERVER=1 xvfb-run bundle exec rspec

test_slow:
	VIMRUNNER_REUSE_SERVER=0 bundle exec rspec

test_visible:
	VIMRUNNER_REUSE_SERVER=1 bundle exec rspec

test_docker:
	docker build -t vim-python-pep8-indent .
	docker run --rm -ti vim-python-pep8-indent
