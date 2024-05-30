import os
from PIL import Image

def resize_image(image_path, max_resolution=(1000, 1000)):
    with Image.open(image_path) as img:
        img.thumbnail(max_resolution, Image.ANTIALIAS)
        img.save(image_path, quality=95)  # Overwrite the original image

def resize_images_in_folder(folder_path, max_resolution=(1000, 1000)):
    for filename in os.listdir(folder_path):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
            image_path = os.path.join(folder_path, filename)
            resize_image(image_path, max_resolution)
            print(f"Resized {filename}")

if __name__ == "__main__":
    folder_path = os.path.dirname(os.path.abspath(__file__))  # Current directory
    resize_images_in_folder(folder_path)

