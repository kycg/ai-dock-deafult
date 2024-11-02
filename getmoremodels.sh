#!/bin/bash


download_model() {
    local url=$1
    local destination_path=$2


    mkdir -p "$(dirname "$destination_path")"


    echo "Downloading $destination_path ..."
    wget -O "$destination_path" "$url" --tries=3 --continue


    if [ $? -eq 0 ]; then
        echo "ok $destination_path"
    else
        echo "Error：$url"
    fi
}

# 下载任务列表
download_model "https://huggingface.co/alimama-creative/FLUX.1-dev-Controlnet-Inpainting-Beta/resolve/main/diffusion_pytorch_model.safetensors?download=true" \
               "/workspace/Comfyui/models/controlnet/cn-inpaint-control.safetensors"

