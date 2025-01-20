# Download the Salt model 3D.

# Please adjust the download method according to your country and region.

import requests
import zipfile
import tarfile
import os

def download_file(url, dest_folder):
    if not os.path.exists(dest_folder):
        os.makedirs(dest_folder)
    
    local_filename = os.path.join(dest_folder, url.split('/')[-1])
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)
    return local_filename
def untar_file(tar_filepath, dest_folder):
    with tarfile.open(tar_filepath, 'r:gz') as tar_ref:
        tar_ref.extractall(dest_folder)

def unzip_file(zip_filepath, dest_folder):
    with zipfile.ZipFile(zip_filepath, 'r') as zip_ref:
        zip_ref.extractall(dest_folder)

if __name__ == "__main__":

    url_model = "https://s3.amazonaws.com/open.source.geoscience/open_data/seg_eage_models_cd/Salt_Model_3D.tar.gz"  
    dest_folder_model = "./Model"

    model_filepath = download_file(url_model, dest_folder_model)
    untar_file(model_filepath, dest_folder_model)
    os.remove(model_filepath)
    print(f"Downloaded and extracted {model_filepath} to {dest_folder_model}")

    salt_zip_path = os.path.join(dest_folder_model, "3D_Salt_Model", "VEL_GRIDS", "SALTF.ZIP")
    unzip_file(salt_zip_path, os.path.dirname(salt_zip_path))
    os.remove(salt_zip_path)
    print(f"Extracted {salt_zip_path}")