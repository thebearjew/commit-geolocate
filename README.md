## Commit Geolocate

![](https://i.imgur.com/dzcJIVk.png)

Tag your geolocation every time you make a commit (using only UNIX tools).

Keeps a log of of the following data in `~/.commit-geolocate/locations.csv`

```
time,        repo,              sha,        msg,                    lat,         lon
1474760174,  commit-geolocate,  e5ee37...,  Fixed the turbo drive,  52.0853030,  5.1475200
```

### Installation

Clone this repository - that's it.

```
$ git clone git@github.com:thebearjew/commit-geolocate.git
$ cd commit-geolocate
```

### Usage

Setup a Git templates directory which Git will use to populate all new repositories you create using either `git init` or `git clone`.

```
$ mkdir -p ~/.git-templates/hooks/

# Tell Git where the template directory exists (globally)
$ git config --global init.templatedir '~/.git-templates'

# Copy commit-geolocate script to template directory
$ cp post-commit.sh ~/.git-templates/hooks/
```

Now test by making a new Git repository using `git init`. The post-commit scripts should be in `./git/hooks/`.

### Contributing

Looking for better/cleaner Bash practices. I whipped this up rather quickly.

Also looking for alternative methods to getting geo-location. Either another API other than [ip-api.com/json](http://ip-api.com/json), or some network tricks.

Also, if anyone wants to calculate the days until Santa comes... https://twitter.com/mxcl/status/779115553944244224

### License

MIT
