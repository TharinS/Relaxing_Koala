import os

def retrieve_filename(asset_folder, asset_id):
    # Get all files in the asset folder
    files = os.listdir(asset_folder)
    
    # Check for a file that matches the asset_id
    for file in files:
        if file.startswith(str(asset_id)):
            return file
    
    # If no file is found
    return None
