# Composer Prestissimo docker image


## Usage

```shell
docker run -it \
   -v $(pwd):/srv \
      ypereirareis/prestissimo composer install
```

## Build

```shell
git clone git@github.com:ypereirareis/docker-prestissimo.git && cd docker-prestissimo
make build
make build-no-cache
```

## Credits

Thanks to [https://github.com/hirak/prestissimo](https://github.com/hirak/prestissimo)
