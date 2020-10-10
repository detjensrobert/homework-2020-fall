# OSU Fall 2020 Homework

> Note: these markdown files are intended to be used with `pandoc` and contain inline LaTeX.
>
> GFM does not support this and as such these will not render correctly here on GitHub.

A handy alias:

```sh
md2pdf () {
    pandoc "$*" -o "$*.pdf" -V geometry:margin=1in --highlight=tango
}
```
