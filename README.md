> Translate this file into your native language using `Google Translate` or a [similar service](https://immersivetranslate.com).

# Dotfiles

¡Bienvenido a mi repositorio de dotfiles!

Aquí encontrarás una amplia variedad de archivos de configuración que he personalizado para diferentes herramientas de línea de comandos (CLI) como: Neovim, Zsh y otras más. Siéntete libre de explorar este repositorio y encontrar aquella configuración que sea útil para ti.

_Procede con precaución al copiar y pegar estos archivos, revisarlos antes para asegurarte de que sean compatibles con tu configuración actual._

- [Dotfiles](#dotfiles)
  - [ Instalacion](#-instalacion)
    - [Neovim](#neovim)
    - [Tmux](#tmux)
    - [Nnn](#nnn)
    - [Zsh](#zsh)
    - [Otras configuraciones](#otras-configuraciones)
      - [Lazygit](#lazygit)
  - [ Licencia](#-licencia)

## 🗒️ Instalacion

Para usar estos dotfiles sigue los siguientes paso:

* Clona este repositorio.
```sh
git clone https://github.com/farias-hecdin/dotfiles.git
```

* Copia todos los archivos o solo aquellos que necesites ¡Y disfruta de la configuración!

### Neovim

El [directorio Nvim](./Nvim) contiene mi configuración de Neovim. Agrega algunos atajos de teclado útiles, temas, plugins y opciones de configuración personalizadas.

**Prerrequisitos**:

Antes de instalar esta configuración, asegúrate de tener instalados los siguientes paquetes:

1. `Clang`: Para compilar e instalar correctamente los parsers de lenguaje con treesitter.
2. `Termux-api`: Para copiar texto al portapapeles (solo si utilizas Termux).
3. `Fzf`: Para utilizar la herramienta el buscador fuzzy finder en neovim.
4. `Nnn`: Para utilizar el gestor de archivos Nnn en neovim.

Para instalar estos paquetes, puedes usar los siguientes comandos:

```sh
pkg install clang && pkg install termux-api && pkg install fzf && pkg install nnn
```

Para instalar la configuración de Neovim, sigue los siguientes pasos:

* Para evitar conflictos, borra tu antigua configuración o crea un respaldo.
* Procede a copiar la nueva configuración.

```sh
rm -rf ~/.config/nvim/ && cp -r ./NVIM/nvim/ ~/.config/
```

### Tmux

En el [directorio Tmux](./Tmux) se encuentra el archivo `tmux.conf` de contiene mi configuración de Tmux, que mejora la interfaz de usuario y agrega algunos atajos de teclado utiles.

Para instalar la configuración de Tmux, sigue los siguientes pasos:

* Para evitar conflictos, borra tu antigua configuracion o crea un resplado.
* Procede a copiar la nueva configuración.

```sh
rm -rf ~/.tmux.conf && cp -r ./TMUX/.tmux.conf ~/
```

### Nnn

El [directorio Nnn](./Nnn) contiene mi configuración para el gestor de archivos Nnn. Agrega algunos plugins útiles para moverse más rápidamente entre los directorios como `autojump` y `fzcd`.

Para instalarlo sigue los siguientes pasos:

* Para evitar conflictos, borra tu antigua configuración o crea un respaldo.
* Procede a copiar la nueva configuración.

```sh
rm -rf ~/.config/nnn/plugins/ && cp -r ./@nnn/plugins/ ~/.config/nnn/
```

### Zsh

En el [directorio Zsh](./Zsh) contiene mi configuración de Zsh. Incluye opciones de configuración personalizadas, alias y plugins como `z.lua` y `git-status`.

Para instalarlo sigue los siguientes pasos:

* Para evitar conflictos, borra tu antigua configuracion o crea un resplado.
* Procede a copiar la nueva configuración.

```sh
rm -rf ~/.zsh/ && cp -r ./ZSH/.zsh/ ~/
```

### Otras configuraciones

#### Lazygit

Para instalarlo sigue los siguientes pasos:

```sh
rm -rf ~/.config/lazygit/ && cp -r ./LAZYGIT/lazygit/ ~/.config/lazygit/
```

## 🛡️ Licencia

Dotfiles se distribuye bajo la licencia MIT. Consulte el archivo `LICENSE` para obtener más información.
