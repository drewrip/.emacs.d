# .emacs.d
**Emacs configuration file**

I've recently started rewriting my config file for my current needs
while also scrapping some of the copy pasting I did for my first file.

Currently the config relies on all-the-icons because of treemacs, so you must
also run `M-x all-the-icons-install-fonts`.

My goal is to get LSP working so I can make emacs a bit more practical for my purposes.
Part of this will be setting up Rust Analyzer in emacs. See https://robert.kra.hn/posts/rust-emacs-setup/.


## Language Servers

Any notes about setting up language servers.

### Rust

```
$ rustup component add rust-analyzer
```

You also need to make sure that rust-analyzer is in the path so Emacs can find it. So, lets put a link to it in the .cargo/bin:

```
$ rustup which --toolchain stable rust-analyzer
/home/drewrip/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer
$ ln /home/drewrip/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer ~/.cargo/bin/.
```

### Python

```
$ sudo npm install -g pyright
```

### C/C++

```
$ sudo apt-get install clang clangd
```

### Markdown

For Markdown processing use pandoc:

```
$ sudo apt-get install pandoc
```