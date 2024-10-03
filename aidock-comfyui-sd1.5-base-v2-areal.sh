#!/bin/bash

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/kycg/ai-dock-deafult/refs/heads/main/workflows/example.json"

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
	"gdown"
	"piexif"
	"matplotlib" 
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/kycg/comfyui-Kwtoolset"
	"https://github.com/hayden-fr/ComfyUI-Model-Manager"
	"https://github.com/ciri/comfyui-model-downloader"
	"https://github.com/ltdrdata/ComfyUI-Impact-Pack"
	"https://github.com/Fannovel16/comfyui_controlnet_aux"
	"https://github.com/jags111/efficiency-nodes-comfyui"
	"https://github.com/WASasquatch/was-node-suite-comfyui"
	"https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
	"https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
	"https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes"
	"https://github.com/cubiq/ComfyUI_IPAdapter_plus"
	"https://github.com/jamesWalker55/comfyui-various"
	"https://github.com/chrisgoringe/cg-use-everywhere"
	"https://github.com/storyicon/comfyui_segment_anything"
	"https://github.com/ttulttul/ComfyUI-Tensor-Operations"
	"https://github.com/lquesada/ComfyUI-Inpaint-CropAndStitch"
	"https://github.com/KoreTeknology/ComfyUI-Universal-Styler"
	"https://github.com/neverbiasu/ComfyUI-SAM2"
	"https://github.com/rgthree/rgthree-comfy"
	#resources board
	"https://github.com/crystian/ComfyUI-Crystools"
	
)

CHECKPOINT_MODELS=(
#https://civitai.com/models/20282?modelVersionId=305687
)

CLIP_MODELS=(
    #CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors
	#"https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors"
)

UNET_MODELS=(
)

VAE_MODELS=(
	#"vae-ft-mse-840000-ema-pruned.safetensors",
	"https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
)

LORA_MODELS=(
	 #bsp 123570
	#"https://civitai.com/api/download/models/123570?type=Model&format=SafeTensor"
	#t-clothes 64403 
	#"https://civitai.com/api/download/models/64403?type=Model&format=SafeTensor"
)

ESRGAN_MODELS=(
	
)

CONTROLNET_MODELS=(
#control_v11f1e_sd15_tile_fp16.safetensors
"https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11u_sd15_tile_fp16.safetensors"
#control_v11f1p_sd15_depth_fp16.safetensors
"https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11f1p_sd15_depth_fp16.safetensors"
#control_v11p_sd15_lineart_fp16.safetensors
"https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_lineart_fp16.safetensors"
)

SAMS_MODELS=(
	"https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth"
)

IPA_MODELS=(
"https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
#ip-adapter-plus_sd15.safetensors
)


URL_ESRGAN_MODELS=(
    "safetensors/ESRGAN/1x-ITF-Skin.rar,1x-ITF-SkinDiffDetail-Lite-v1.pth"
	"safetensors/ESRGAN/1x_DeB.rar,1x_DeBLR.pth"
	"safetensors/ESRGAN/4x-UltraSh.rar,4x-UltraSharp.pth"
	"safetensors/ESRGAN/4x_NMKD-Supersca.rar,4x_NMKD-Superscale-SP_178000_G.pth"
	"safetensors/ESRGAN/4x_RealisticResca.rar,4x_RealisticRescaler_100000_G.pth"
	"safetensors/ESRGAN/8x_NMKD-Supe.rar,8x_NMKD-Superscale_150000_G.pth"
)

URL_LORA_MODELS=(
    "safetensors/lora/bsp.rar,bsp.safetensors"
	"safetensors/lora/tc.rar,tc.safetensors"
)
URL_BBOX_MODELS=(
    "safetensors/bbox/bre.rar,bre.pt"
	"safetensors/bbox/bre4.rar,bre4.pt"
)

HTTP_URL_CLIP_MODELS=(
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors,CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui


    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_default_workflow
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${CLIP_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
	provisioning_get_models \
		"${WORKSPACE}/storage/stable_diffusion/models/sams" \
		"${SAMS_MODELS[@]}"
	provisioning_get_models \
		"${WORKSPACE}/storage/stable_diffusion/models/ipadapter" \
		"${IPA_MODELS[@]}"
	provisioning_get_models_url \
		"${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
		"${URL_ESRGAN_MODELS[@]}"
	provisioning_get_models_url \
		"${WORKSPACE}/storage/stable_diffusion/models/lora" \
		"${URL_LORA_MODELS[@]}"
	provisioning_get_models_url \
		"${WORKSPACE}/ComfyUI/models/ultralytics/bbox" \
		"${URL_BBOX_MODELS[@]}"
    provisioning_get_models_http \
        "${WORKSPACE}/ComfyUI/models/clip" \
        "${HTTP_URL_CLIP_MODELS[@]}"
	provisioning_print_end
}

function pip_install() {
    if [[ -z $MAMBA_BASE ]]; then
            "$COMFYUI_VENV_PIP" install --no-cache-dir "$@"
        else
            micromamba run -n comfyui pip install --no-cache-dir "$@"
        fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip_install ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/opt/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip_install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip_install -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > /opt/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

function provisioning_get_models_url() {
    if [[ -z $2 ]]; then
        return 1
    fi

    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")

    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for model_info in "${arr[@]}"; do

        path=$(echo "$model_info" | cut -d ',' -f 1)
        new_name=$(echo "$model_info" | cut -d ',' -f 2)

        domain=$(echo "c3BlbGxwdC5jb20=" | base64 --decode)
        url="https://${domain}/${path}"

        h_url="https://${path}"
        printf "Downloading: %s\n" "${h_url}"

        wget -qnc --content-disposition --show-progress -O "${dir}/${new_name}" "${url}"
        printf "Saved as: %s\n" "${new_name}"
        printf "\n"
    done
}

function provisioning_get_models_http() {
    if [[ -z $2 ]]; then
        return 1
    fi

    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")

    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for model_info in "${arr[@]}"; do

        path=$(echo "$model_info" | cut -d ',' -f 1)
        new_name=$(echo "$model_info" | cut -d ',' -f 2)

        url="${path}"

        h_url="${path}"
        printf "Downloading: %s\n" "${h_url}"

        wget -qnc --content-disposition --show-progress -O "${dir}/${new_name}" "${url}"
        printf "Saved as: %s\n" "${new_name}"
        printf "\n"
    done
}

provisioning_start
