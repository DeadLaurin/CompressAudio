#!/bin/bash

# Function to select audio encoding format
select_format() {
    FORMAT=$(whiptail --title "Select Audio Format" --menu "Choose audio format:" 20 60 2 \
    "1" "EAC3" \
    "2" "Opus" 3>&1 1>&2 2>&3)

    case $FORMAT in
        1)
            select_eac3
            ;;
        2)
            select_opus
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Function to select EAC3 encoding options
select_eac3() {
    CHOICE=$(whiptail --title "Select EAC3 Option" --menu "Choose encoding format:" 20 60 4 \
    "1" "5.1 256kbps 6CH | EAC3" \
    "2" "5.1 384kbps 6CH | EAC3" \
    "3" "5.1 448kbps 6CH | EAC3" \
    "4" "5.1 640kbps 6CH | EAC3" 3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            CHANNELS=6
            BITRATE="256k"
            CODEC="eac3"
            ;;
        2)
            CHANNELS=6
            BITRATE="384k"
            CODEC="eac3"
            ;;
        3)
            CHANNELS=6
            BITRATE="448k"
            CODEC="eac3"
            ;;
        4)
            CHANNELS=6
            BITRATE="640k"
            CODEC="eac3"
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
    process_files
}

# Function to select Opus encoding options
select_opus() {
    CHOICE=$(whiptail --title "Select Opus Option" --menu "Choose encoding format:" 20 60 4 \
    "1" "5.1 256kbps 6CH | Opus" \
    "2" "5.1 384kbps 6CH | Opus" \
    "3" "5.1 448kbps 6CH | Opus" \
    "4" "5.1 640kbps 6CH | Opus" 3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            CHANNELS=6
            BITRATE="256k"
            CODEC="libopus"
            ;;
        2)
            CHANNELS=6
            BITRATE="384k"
            CODEC="libopus"
            ;;
        3)
            CHANNELS=6
            BITRATE="448k"
            CODEC="libopus"
            ;;
        4)
            CHANNELS=6
            BITRATE="640k"
            CODEC="libopus"
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
    process_files
}

# Process audio files
process_files() {
    for file in *.wav *.mp3 *.flac *.aac *.ogg *.m4a *.eac3 *.ac3 *.opus *.dts *.thd; do
        if [[ -f "$file" ]]; then
            encode_audio "$file"
        fi
    done

    # Done message
    whiptail --title "Encoding Complete" --msgbox "All files have been encoded to the selected format." 10 60
}

# Encoding function
encode_audio() {
    local input_file="$1"
    # Determine the correct output file extension based on the codec
    if [[ "$CODEC" == "libopus" ]]; then
        local output_file="${input_file%.*}_Encoded.opus"
    else
        local output_file="${input_file%.*}_Encoded.eac3"
    fi

    echo -e "\nEncoding $input_file to $output_file..."

    # Encode the file to EAC3 or Opus, hiding ffmpeg output and capturing errors
    ffmpeg -i "$input_file" -c:a "$CODEC" -b:a "$BITRATE" -ac "$CHANNELS" -y "$output_file" 2> /tmp/ffmpeg_error.log

    # Check if encoding was successful
    if [[ $? -eq 0 ]]; then
        echo -e "\e[32mDone: $output_file\e[0m"  # Display "Done" in green
        rm "$input_file"  # Delete original file
        echo "Deleted original file: $input_file"
    else
        echo "Encoding failed for $input_file. See error log for details:"
        cat /tmp/ffmpeg_error.log  # Display the ffmpeg error output
    fi
}

# Start the encoding process by selecting format
select_format
