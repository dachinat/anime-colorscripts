# anime-colorscripts

A small script that shows a random anime image in your terminal using **chafa**.

---

## Installation

### 1. Install chafa
```
sudo pacman -S chafa   # Arch
sudo apt install chafa # Debian/Ubuntu
```

### 2. Install the script
```
sudo cp anime-colorscripts /usr/bin/
sudo chmod +x /usr/bin/anime-colorscripts
```

### 3. Install images  
You can put images in either:

**User directory (preferred):**
```
~/.local/share/anime-colorscripts/images
```

**System-wide directory:**
```
/usr/share/anime-colorscripts/images
```

Images must be `.png`, `.jpg`, `.jpeg`, or `.webp`.

---

## Usage

Show a random image:
```
anime-colorscripts
```

Set custom size (width x height):
```
anime-colorscripts --size=40x20
```

Use a custom directory:
```
anime-colorscripts --dir=/path/to/images
```

Get help:
```
anime-colorscripts --help
```

