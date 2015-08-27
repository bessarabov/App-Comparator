# The Comparator

Script to compare CPAN modules.

             ______
          .-"      "-.
         /            \
        |              |
        |,  .-.  .-.  ,|
        | )(__/  \__)( |
        |/     /\     \|
        (_     ^^     _)
         \__|IIIIII|__/
          | \IIIIII/ |
          \          /
    jgs    `--------`

## build

    time docker build --tag comparator .

## run

    docker run --rm comparator

## dev

### to change dependencies

    time docker run \
        --rm \
        -it \
        --volume `pwd`:/app \
        comparator \
        sh -c 'cd /app; rm -rf cpanfile.snapshot local; carton install'

### dev run

    docker run \
        --rm \
        -it \
        --volume `pwd`/bin:/app/bin \
        --volume `pwd`/lib:/app/lib \
        comparator \
        bash

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/b81c7a8c300a0a52c2bfecf4b9fc53de "githalytics.com")](http://githalytics.com/bessarabov/App-Comparator)

