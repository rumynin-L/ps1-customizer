# PS1 Customizer

I wrote this script as an assignment for a Linux Shell Programming [course](https://www.uc3m.es/lifelong-learning/Microcredencial-Programacion-Shell-Linux). It is a scuffed version of this Bash Prompt Generator [website](https://bash-prompt-generator.org), but in the form of a bash script. The quality of the code may be underwhelming.

## How to run

Run the script through:
```bash
source ps1-customizer.sh
# or
. ps1-customizer.sh
```
This will execute the script without creating a subshell.

If you already have a custom `$PS1` in your `.bashrc`, you will have to do
```bash
bash --norc
```
before executing the script.

## Notes

Dim, italic and underline text styles have limited support.

If you have a custom color scheme set up for your terminal, it is possible that the colors won't correspond to what they are labeled as.

Currently, the script doesn't apply the change to your `.bashrc`, but it instead gives a command you can add in it to change your prompt permanently. However, it does change the `$PS1` variable of the shell it is executed in, so long as your `.bashrc` is not overwriting it. During execution, it will also show you a preview of the new prompt you are creating.

In the preview, the elements of the prompt are shown as their escape sequences (`\u`, `\d`, `$?`, etc.)

I will (maybe) update it and add more features in the future.