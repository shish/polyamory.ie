Dev mode
```
docker run -ti --rm --volume="$PWD:/srv/jekyll:Z" --publish '0.0.0.0:4000:4000' jekyll/jekyll:3.8 jekyll serve
```

Prod mode
```
docker build -t blog .
```
