#!/bin/bash

# Location  wget https://raw.githubusercontent.com/kycg/ai-dock-deafult/refs/heads/main/getmoremodels.sh
# 1.1		dos2unix getmoremodels.sh
# 2         chmod +x getmoremodels.sh
# 3         ./getmoremodels.sh

# 99  tar -cvf output.tar /workspace/ComfyUI/output

download_model() {
    local url=$1
    local destination_path=$2

    mkdir -p "$(dirname "$destination_path")"

    echo "Downloading $destination_path ..."
    wget -O "$destination_path" "$url" --tries=3 --continue

    if [ $? -eq 0 ]; then
        echo "ok $destination_path"
    else
        echo "Error: $url"
    fi
}

download_model "https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8-e4m3fn.safetensors?download=true" \
               "/workspace/ComfyUI/models/unet/flux1-dev-fp8-e4m3fn.safetensors"
			   
download_model "https://huggingface.co/alimama-creative/FLUX.1-dev-Controlnet-Inpainting-Beta/resolve/main/diffusion_pytorch_model.safetensors?download=true" \
               "/workspace/ComfyUI/models/controlnet/cn-inpaint-control.safetensors"

#download_model "https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/model.safetensors" \
               "/workspace/ComfyUI/models/clip/clip-vit-large-patch14.safetensors"
			   

#download_model  "https://huggingface.co/lodestones/stable-diffusion-3-medium/resolve/4a708bd3d18c10253247f8660cd4ffae6cd63bf1/stable-diffusion-3-medium/text_encoders/clip_g.safetensors" \
#               "/workspace/ComfyUI/models/clip/clip_g.safetensors"
			   
