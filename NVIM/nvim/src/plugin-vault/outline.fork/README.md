> [!TIP]
> Use `Google Translate` to read this file in your native language.

# Outline.fork

Este plugin es un pequeño gestor de buffer para Neovim. Es una bifurcación de [Djancyp/outline](https://github.com/Djancyp/outline). Se eliminaron varias funciones del plugin original, se refactorizo el codigo y se agregaron nuevas caracteristicas.

## Requerimientos

* [`neovim`](https://github.com/neovim/neovim) >= 0.8
* [`nerd font`](https://www.nerdfonts.com/) para los iconos de los buffers
* [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim)
* [`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons)

### Instalación

Usando [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
{
    "farias-hecdin/outline.fork",
    cmd = "BSOpen",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = true,
    -- Si quieres configurar algunas opciones, sustituye la línea anterior con:
    -- config = function()
    -- end,
}
```

## Configuración

Estas son las opciones de configuración predeterminadas:

```lua
require('outline').setup({
    active_icon = "",
    window_width = 80,
    window_maxheight = 20,
})
```

### Comandos y atajos de teclado

| Comandos       | Descripción                         |
| -------------  | ----------------------------------- |
| `BSOpen`       | Abrir el gestor de buffer |

Estos son los atajos de teclado predeterminados:

| Atajos de teclado | Descripcion  |
| ----------------- | ------------------------------- |
| `q` `ESC`         | Salir del gestor buffers |
| `d`               | Cerrar un buffer |
| `<CR>`            | Ir a un buffer |

## Agradecimientos a

* [Djancyp/outline](https://github.com/Djancyp/outline): Ha sido la base de este plugin.

## Licencia

Outline.fork está bajo la licencia MIT. Consulta el archivo `LICENSE` para obtener más información.
