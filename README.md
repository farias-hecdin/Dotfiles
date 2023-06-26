# Dotfiles
En este repositorio encontrarás mis archivos de configuración (dotfiles) para varias herramientas de línea de comandos (cli). Siéntete libre de usarlo para mejorar tu equipo. Pero, procede con precaución al copiar los archivos.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents** 

- [Dotfiles](#dotfiles)
  - [Instalación](#instalaci%C3%B3n)
    - [Neovim](#neovim)
    - [Tmux](#tmux)
    - [Nnn](#nnn)
    - [Zsh](#zsh)
  - [Licencia](#licencia)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Instalación
Para usar estos dotfiles sigue los siguientes paso:

   1. Clona este repositorio.

   ```bash
   git clone https://github.com/farias-hecdin/dotfiles.git
   ```

   2. Copia todos los archivos o solo aquellos que necesites y muévelo a su respetivo directorio ¡Y disfruta de la configuración!

### Neovim
El [directorio](./@nvim/) @nvim contiene mi configuración de Neovim. Agrega algunos atajos de teclado útiles, temas, plugins y opciones de configuración personalizadas.

Para instalarlo sigue los siguientes pasos:

   * Para evitar conflictos, borra tu antigua configuración o crea un respaldo.

   ```bash
   rm -rf ~/.config/nvim/
   ````

   * Procede a copiar la nueva configuración.

   ```bash
   cp -r ./@nvim/nvim/ ~/.config/
   ```

### Tmux
En el [directorio](./@tmux/) @tmux se encuentra el archivo tmux.conf de contiene mi configuración de Tmux, que mejora la interfaz de usuario y agrega algunos atajos de teclado.

Para instalarlo sigue los siguientes pasos:

   * Para evitar conflictos, borra tu antigua configuracion o crea un resplado.

   ```bash
   rm -rf ~/.tmux.conf
   ````

   * Procede a copiar la nueva configuración.

   ```bash
   cp -r ./@tmux/.tmux.conf ~/
   ```

### Nnn
El [directorio](./@nnn/) @nnn contiene mi configuración para el gestor de archivos Nnn. Agrega algunos plugins útiles para moverse más rápidamente entre los directorios como `autojump` y `fzcd`.

Para instalarlo sigue los siguientes pasos:

   * Para evitar conflictos, borra tu antigua configuración o crea un respaldo.

   ```bash
   rm -rf ~/.config/nnn/plugins/
   ````

   * Procede a copiar la nueva configuración.

   ```bash
   cp -r ./@nnn/plugins/ ~/.config/nnn/
   ```

### Zsh
El [directorio](./@zsh/) @zsh contiene mi configuración de Zsh. Incluye opciones de configuración personalizadas, alias y plugins como `zsh-z`, `fast-zsh-syntax-highlighting` y `zsh-vi-mode`.

Para instalarlo sigue los siguientes pasos:

   * Para evitar conflictos, borra tu antigua configuracion o crea un resplado.

   ```bash
   rm -rf ~/.zsh/
   ````

   * Procede a copiar la nueva configuración.

   ```bash
   cp -r ./@zsh/.zsh/ ~/
   ```

## Licencia
dotfiles se distribuye bajo la licencia MIT. Consulte el archivo LICENSE para obtener más información.
