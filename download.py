# Download the MATLAB toolbox Seilab 3.02 and Salt model 3D.

# Please adjust the download method according to your country and region,
# because the download source in this code is from mathworks.cn

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

def unzip_file(zip_filepath, dest_folder):
    with zipfile.ZipFile(zip_filepath, 'r') as zip_ref:
        zip_ref.extractall(dest_folder)

def untar_file(tar_filepath, dest_folder):
    with tarfile.open(tar_filepath, 'r:gz') as tar_ref:
        tar_ref.extractall(dest_folder)

if __name__ == "__main__":
    url_zip = "https://ww2.mathworks.cn/matlabcentral/mlc-downloads/downloads/submissions/53109/versions/2/download/zip"
    url_tar_gz = "https://s3.amazonaws.com/open.source.geoscience/open_data/seg_eage_models_cd/Salt_Model_3D.tar.gz"  
    dest_folder_toolbox = "./Toolbox"
    dest_folder_model = "./Model"

    toolbox_filepath = download_file(url_zip, dest_folder_toolbox)
    unzip_file(toolbox_filepath, dest_folder_toolbox)
    os.remove(toolbox_filepath)
    print(f"Downloaded and extracted {toolbox_filepath} to {dest_folder_toolbox}")

    model_filepath = download_file(url_tar_gz, dest_folder_model)
    untar_file(model_filepath, dest_folder_model)
    os.remove(model_filepath)
    print(f"Downloaded and extracted {model_filepath} to {dest_folder_model}")