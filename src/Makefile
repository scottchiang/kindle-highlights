all:
	rm -rf ./build/
	rm -rf ./lambda.zip
	python3 -m venv build
	cp *.py ./build/
	. ./build/bin/activate;                          \
	pip install -r requirements.txt -t ./build/; \
	deactivate
	cd ./build/ && zip -r ../lambda.zip .
