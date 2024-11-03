# **Encode Audio to Useful Formats Recursively**
This script encodes audio files to multiple formats in the current set directory.

## **Features**
- Open Source bash script.
- Can run on Linux and [Windows WSL](https://docs.microsoft.com/en-us/windows/wsl/).
- Can be run in a tmux session in the background.
- Encodes all audio files in subfolders.
- Will delete original files after successful encoding.
- Has the option to select your desired Bitrate or Codec.

## **Requirements**
The script uses `ffmpeg`, `whiptail`, and `pv` and can be installed on Debian/Ubuntu-based systems or [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/) with:
```bash
apt install ffmpeg whiptail pv
```
Windows users, to find out more regarding WSL, use [this link](https://docs.microsoft.com/en-us/windows/wsl/).

## **Download/Install Script**
To download and use the script, do the following in a folder of your choosing:
```bash
wget https://raw.githubusercontent.com/DeadLaurin/EncodeAudio/main/encode_audio.sh
chmod +x encode_audio.sh
```
Now the script is ready to use: You could move the script to somewhere in your PATH if you'd like to access it from anywhere.

## **Usage**
```bash
./encode_audio.sh
```
