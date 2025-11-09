#!/bin/bash

NEW_PROMPT=""

declare -A COLOR_CODES=(
  ["white"]="\[\e[37m\]"
  ["black"]="\[\e[30m\]"
  ["red"]="\[\e[31m\]"
  ["green"]="\[\e[32m\]"
  ["blue"]="\[\e[34m\]"
  ["cyan"]="\[\e[36m\]"
  ["yellow"]="\[\e[33m\]"
  ["magenta"]="\[\e[35m\]"
  ["default"]="\[\e[0m\]"
)

declare -A STYLE_CODES=(
  ["bold"]="\[\e[1m\]"
  ["dim"]="\[\e[2m\]"
  ["italic"]="\[\e[3m\]"
  ["underline"]="\[\e[4m\]"
  ["default"]=""
)

main_menu() {
  clear
  
  if [ -n "$NEW_PROMPT" ]; then
    echo "Prompt preview:"
    display_prompt="${NEW_PROMPT//\\t/\\\\t}"  # Escapar \t
    display_prompt="${display_prompt//\\v/\\\\v}"  # Escapar \v
    display_prompt="${display_prompt//\\n/\\\\n}"  # Escapar \n
    display_prompt="${NEW_PROMPT//\\[/}"
    display_prompt="${display_prompt//\\]/}"
    echo -e "${display_prompt}"
    echo ""
  fi
  
  cat << EOF
Select an option:
  1) Add new element
  2) Reset
  3) Save and quit
  4) Quit without saving
EOF
  
  read -n 1 -r -s -p "Press the corresponding key: " choice_menu
  echo ""
  
  case $choice_menu in
    1) insert_element ;;
    2) NEW_PROMPT=""; echo "Prompt reset."; sleep 1 ;;
    3) save_prompt; return 1 ;;
    4) printf "Exiting...\n"; return 1 ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
}

insert_element() {
  local element color style
  
  element=$(select_element)
  [ -z "$element" ] && return
  
  color=$(choose_color)
  [ -z "$color" ] && return
  
  style=$(choose_style)
  [ -z "$style" ] && return
  
  NEW_PROMPT="${NEW_PROMPT}${COLOR_CODES[$color]}${STYLE_CODES[$style]}${element}\[\e[0m\]"
}

save_prompt() {
  clear
  
  PS1="$(printf "%b" "${NEW_PROMPT}")"
  echo "Prompt has been updated for this terminal session."
  echo "To make it permanent, add this line to your ~/.bashrc:"
  echo "PS1='${NEW_PROMPT}'"
}

select_element() {
  clear >&2
  
  cat << EOF >&2
Select an element to add:
 1) Username
 2) Hostname
 3) Current directory
 4) Bash version
 5) Exit status
 6) Time
 7) Date
 8) Newline
 9) Prompt sign
 0) Custom text
 r) Go back
EOF
  
  read -n 1 -r -s -p "Press the corresponding key: " choice_element >&2
  echo "" >&2
  
  case $choice_element in
    1) printf '%s' '\u' ;;
    2) printf '%s' '\h' ;;
    3) printf '%s' '\w' ;;
    4) printf '%s' '\\v' ;;
    5) printf '%s' '$?' ;;
    6) printf '%s' '\\t' ;;
    7) printf '%s' '\d' ;;
    8) printf '%s' '\\n' ;;
    9) printf '%s' '\$' ;;
    0) read -rp "Enter custom text: " custom && echo "$custom" ;;
    r|R) return ;;
    *) echo "Invalid option"; sleep 1; select_element ;;
  esac
}

choose_color() {
  clear >&2
  
  cat << EOF >&2
Choose a color:
  1) White      6) Cyan
  2) Black      7) Yellow
  3) Red        8) Magenta
  4) Green      9) Default
  5) Blue
EOF
  
  read -n 1 -r -s -p "Press the corresponding key: " choice_color >&2
  echo "" >&2
  
  case $choice_color in
    1) echo "white" ;;
    2) echo "black" ;;
    3) echo "red" ;;
    4) echo "green" ;;
    5) echo "blue" ;;
    6) echo "cyan" ;;
    7) echo "yellow" ;;
    8) echo "magenta" ;;
    9) echo "default" ;;
    *) echo "Invalid option"; sleep 1; choose_color ;;
  esac
}

choose_style() {
  clear >&2
  
  cat << EOF >&2
Choose a style:
  1) Bold
  2) Dim
  3) Italic
  4) Underline
  5) Default
EOF
  
  read -n 1 -r -s -p "Press the corresponding key: " choice_style >&2
  echo "" >&2
  
  case $choice_style in
    1) echo "bold" ;;
    2) echo "dim" ;;
    3) echo "italic" ;;
    4) echo "underline" ;;
    5) echo "default" ;;
    *) echo "Invalid option"; sleep 1; choose_style ;;
  esac
}

while true; do
  main_menu
  
  if [ $? -eq 1 ]; then
    break
  fi
done