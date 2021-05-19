docker build -t demo-thread -f Dockerfile .
docker run -v $(pwd):/opt/Project  -p 5000:5000 --name demo-thread demo-thread