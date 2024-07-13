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
alias v-new="python3 -m venv /path/to/venv"
alias v-go=". /path/to/venv/bin/activate"

# TTS
function now() {
	local datetime=$(date +"%m-%d_%H:%M:%S")
	echo "$datetime"
}

tts_export="downloads/"
tts_pitch="-18"
tts_rate="18"

alias tts="edge-tts --voice es-PA-RobertoNeural --write-media ${tts_export}tts_$(now).mp3 --write-subtitles ${tts_export}tts_$(now).vtt --pitch=${tts_pitch}Hz --rate=${tts_rate}% --text"
alias tts-voices="edge-tts --list-voices"

