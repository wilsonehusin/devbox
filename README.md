# devbox

Devbox is my development setup to be used with [toolbx](https://containertoolbx.org).

> [!NOTE]
> I'm experimenting with using Fedora Silverblue (Sway) for my development environment. Toolbx is a utility recommended by the Universal Blue team. 

This was inspired by [the wolfi version in toolbx-images/images](https://github.com/toolbx-images/images/blob/main/wolfi/latest/Containerfile), but converted to use [apko](https://github.com/chainguard-dev/apko) and [melange](https://github.com/chainguard-dev/melange) in building the image.

## Usage

```shell-session
# toolbox create --image ghcr.io/wilsonehusin/devbox:latest devbox
# toolbox enter devbox
```
