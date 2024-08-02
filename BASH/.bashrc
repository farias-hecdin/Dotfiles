# Setup -----------------------------------------------------------------------

export EDITOR=nvim

# Alias -----------------------------------------------------------------------

alias Add="apk add"
alias Del="apk del"
alias Search="apk search"
alias Installed="apk list --installed"

# Basic
alias e="nnn"
alias q="exit"
alias C="clear"
alias R="source /etc/profile"

# Venv
alias v-new="python3 -m venv /path/to/venv"
alias v=". /path/to/venv/bin/activate"

# Text-to-speech (TTS)

# setup 1. = pitch (-9) rate (+25)
PITCH="-9Hz"
RATE="+20%"
VOICE="es-CR-JuanNeural"
FOLDER="downloads/"
ID=$RANDOM

alias tts="edge-tts --voice $VOICE --write-media ${FOLDER}TTS_${ID}.mp3 --pitch=$PITCH --rate=$RATE --text"
alias tts-voices="edge-tts --list-voices"

