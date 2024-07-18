# Setup -----------------------------------------------------------------------

export EDITOR=nvim

# Alias -----------------------------------------------------------------------

alias add="apk add"
alias del="apk del"
alias search="apk search"
alias installed="apk list --installed"

# Basic
alias e="nnn"
alias q="exit"
alias C="clear"
alias R="source /etc/profile"
alias v-new="python3 -m venv /path/to/venv"
alias v=". /path/to/venv/bin/activate"

# TTS
function now() {
	local datetime=$(date +"%m-%d_%H:%M:%S")
	echo "$datetime"
}

# setup 1. = pitch (-9) rate (+25)
tts_pitch="-9"
tts_rate="+20"
tts_voice="es-CR-JuanNeural"
tts_export="downloads/"

alias tts="edge-tts --voice $tts_voice --write-media ${tts_export}tts_$(now).mp3 --write-subtitles ${tts_export}tts_$(now).vtt --pitch=${tts_pitch}Hz --rate=${tts_rate}% --text"
alias tts-voices="edge-tts --list-voices"

