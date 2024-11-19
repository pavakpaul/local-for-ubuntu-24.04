# local-for-ubuntu-24.04

This script downloads [Local](https://localwp.com/), fixes dependencies, installs it, and creates symbolic links for libraries required by it.

## How to use

1. Download this repository
2. Open terminal (`Ctrl` + `Alt` + `T`)
3. drag the file `install-local.sh` to the terminal and press Enter.
4. Enter your password when prompted.

If your file manager allows executing scripts, you can also run the script that way, skipping steps 2 and 3 above.

## One liner

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pavakpaul/local-for-ubuntu-24.04/refs/heads/main/install-local.sh)"
```

## Contributors

Other than me, [Sagnik Sasmal](https://github.com/SagnikSRHUSE) has contributed to the script and wrote the main logic.

<!-- https://askubuntu.com/a/1514001

https://askubuntu.com/a/1515027

/usr/lib/x86_64-linux-gnu
sudo ln -s libtinfo.so.6 libtinfo.so.5
 -->
