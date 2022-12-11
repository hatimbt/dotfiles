# Emacs Configuration

This `emacs` configuration uses literate programming to generate the config files.

`init.org` contains codeblocks that can be exported to `init.el` by running the following:

```emacs
M-x ^org-babel-tangle
```

## Useful commands
To add codeblocks to an `org` file, use: 
```<s TAB```

To add an `emacs-lisp` codeblock, use:
```<el TAB```
