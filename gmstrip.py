import os
import json
import re
from PIL import Image

def yy_validate(data):
    # Use regex to replace commas that are followed by whitespace and a closing brace or bracket
    return re.sub(r',(?=\s*[\]}])', '', data)
    
ROOT = os.path.dirname(os.path.abspath(__file__))

# Create output directory if it doesn't exist
output_dir = os.path.join(ROOT, "output_sprites")
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Iterate through directories in the sprites folder
sprites_dir = os.path.join(ROOT, "sprites")
for dir_name in os.listdir(sprites_dir):
    try:
        dir_path = os.path.join(sprites_dir, dir_name)

        yy_file_path = os.path.join(dir_path, f"{dir_name}.yy")

        if not os.path.exists(yy_file_path):
            continue

        with open(yy_file_path, "r", encoding="utf-8") as file:
            contents = yy_validate(file.read())

        sprite_info = json.loads(contents)
        sprite_frames = sprite_info['frames']

        frame_count = len(sprite_frames)
        sprite_width = sprite_info['width']
        sprite_height = sprite_info['height']

        # Create a new blank image for the sprite strip
        sprite_strip = Image.new('RGBA', (sprite_width * frame_count, sprite_height))

        pX = 0
        pY = 0

        for index, frame in enumerate(sprite_frames):
            frame_name = frame['name']
            frame_path = os.path.join(dir_path, f"{frame_name}.png")

            # Load the image and paste it into the sprite strip
            image = Image.open(frame_path)#.transpose(Image.FLIP_LEFT_RIGHT)
            sprite_strip.paste(image, (pX + index * sprite_width, pY))

        # Save the final sprite strip image
        output_file_path = os.path.join(output_dir, f"{dir_name}_strip{frame_count}.png")
        sprite_strip.save(output_file_path)
    except Exception:
        print(dir_name, "failed")