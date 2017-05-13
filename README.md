# Raspberry PI + Mopidy setup

Setup for raspberry pi serving as a music streaming server (mopidy)

# How to run

Run as sudo

``` shell
./bootstrap
make
```

After `puppet` is finished run `sudo rpi-update` manually (it is difficult to ensure this is idempotent).
