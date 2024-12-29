.PHONY: run build

run: 
build: 

run-frontend:

build-frontend:
	cd ./frontend && \
	templ generate && \
	go mod tidy && \
	npx tailwindcss -c tailwind.config.js -i main.css -o ./render/public/tailwind.css && \
	cp -a ./render/public/ ./render/public/minified && \
	go build && \
	./main