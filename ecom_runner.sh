#!/usr/bin/env bash

# Set the network volume path
NETWORK_VOLUME="/"

COMFYUI_DIR="$NETWORK_VOLUME/ComfyUI"
WORKFLOW_DIR="$NETWORK_VOLUME/ComfyUI/user/default/workflows"
MODELS_DIR="$NETWORK_VOLUME/ComfyUI/models"
CUSTOM_NODES_DIR="$NETWORK_VOLUME/ComfyUI/custom_nodes"

echo "Initial setup global libs"
apt update
apt install unzip

pip uninstall lark
pip install lark
pip install facexlib

echo "Downloading SDXL_ECOMID"
cd "$CUSTOM_NODES_DIR" || exit 1
git clone "https://github.com/alimama-creative/SDXL_EcomID_ComfyUI.git" || { echo "Git clone failed"; exit 1; }

# Change to the directory
cd "$MODELS_DIR" || exit 1


echo "Downloading lfy"
cd "$MODELS_DIR/checkpoints" || exit 1
wget "https://civitai.com/api/download/models/1569593?type=Model&format=SafeTensor&token=62e657ad13a037e0fde176c0013e4b67" --content-disposition    

# download pulid pre-trained model and move to pulid folder
echo "Downloading pulid"
mkdir -p "$MODELS_DIR/pulid"
cd "$MODELS_DIR/pulid" || exit 1
wget "https://huggingface.co/huchenlei/ipadapter_pulid/resolve/main/ip-adapter_pulid_sdxl_fp16.safetensors?download=true" --content-disposition

#download antelopev2
echo "Downloading antelopev2"
mkdir -p "$MODELS_DIR/insightface/models"
cd "$MODELS_DIR/insightface/models" || exit 1
wget "https://huggingface.co/MonsterMMORPG/tools/resolve/main/antelopev2.zip?download=true" --content-disposition
unzip antelopev2.zip || exit 1

echo "Downloading instantid"
mkdir -p "$MODELS_DIR/instantid"
cd "$MODELS_DIR/instantid" || exit 1
wget "https://huggingface.co/InstantX/InstantID/resolve/main/ip-adapter.bin?download=true" --content-disposition

echo "Downloading controlnet"
cd "$MODELS_DIR/controlnet" || exit 1
wget "https://huggingface.co/alimama-creative/SDXL-EcomID/resolve/main/diffusion_pytorch_model.safetensors?download=true" --content-disposition
