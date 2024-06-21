Dev mode
```
docker run -ti --rm --volume="$PWD:/srv/jekyll:Z" --publish '0.0.0.0:4000:4000' jvconseil/jekyll-docker:4.3.3 jekyll serve
```

Prod mode
```
docker build -t blog .
```
