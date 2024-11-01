#!/bin/bash

#File Location
#https://raw.githubusercontent.com/kycg/ai-dock-deafult/refs/heads/main/aidock-comfyui-flux1-dev-gguf.sh

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/ai-dock/comfyui/main/config/workflows/flux-comfyui-example.json"


APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
	"sentencepiece"
	"piexif"
	"matplotlib" 
	"segment-anything"
	"scikit-image"
	"transformers"
	"opencv-python-headless"
	"GitPython"
	"scipy>=1.11.4"
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/city96/ComfyUI-GGUF"
	"https://github.com/ltdrdata/ComfyUI-Impact-Pack"
	"https://github.com/cubiq/ComfyUI_essentials"
	"https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
	"https://github.com/chrisgoringe/cg-use-everywhere"
	"https://github.com/kijai/ComfyUI-KJNodes"
	#"https://github.com/jamesWalker55/comfyui-various"
	"https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/kycg/comfyui-Kwtoolset"
	"https://github.com/hayden-fr/ComfyUI-Model-Manager"
	"https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes"
	"https://github.com/rgthree/rgthree-comfy"
	#resources board
	"https://github.com/crystian/ComfyUI-Crystools"
	#Model download
	"https://github.com/holchan/ComfyUI-ModelDownloader"
	"https://github.com/ciri/comfyui-model-downloader"
	# Img2text
	"https://github.com/kijai/ComfyUI-Florence2"
	"https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
	# seg
	"https://github.com/storyicon/comfyui_segment_anything"
	#upscale
	"https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
	#"https://github.com/kijai/ComfyUI-SUPIR"
	#mask editor
	"https://github.com/BadCafeCode/masquerade-nodes-comfyui"
	#face
	"https://github.com/cubiq/ComfyUI_FaceAnalysis"
	"https://github.com/cubiq/PuLID_ComfyUI"
	"https://github.com/Gourieff/comfyui-reactor-node"
	"https://github.com/cubiq/ComfyUI_InstantID"
	#face flux
	"https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced"
	#24gb vram not enough with flux PuLID
	#models cd /workspace/ComfyUI/models/pulid/  wget  https://huggingface.co/guozinan/PuLID/resolve/main/pulid_flux_v0.9.0.safetensors
	# cd /workspace/ComfyUI/models/xlabs/controlnets$ wget https://huggingface.co/XLabs-AI/flux-controlnet-depth-v3/resolve/main/flux-depth-controlnet-v3.safetensors?download=true
	# controlnet
	"https://github.com/Fannovel16/comfyui_controlnet_aux"
	# add
		#show anything
	"https://github.com/yolain/ComfyUI-Easy-Use"
	
)

CHECKPOINT_MODELS=(
)

CLIP_MODELS=(
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors?download=true"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors?download=true"
)

UNET_MODELS=(
#wget --header="Authorization: Bearer fd36ce38e82dd18ff9250753e02186b3e5" "https://civitai.com/api/download/models/873571?type=Model&format=SafeTensor&size=pruned&fp=fp8"
# cd/workspace/storage/stable_diffusion/models/unet$ wget https://huggingface.co/city96/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q4_0.gguf
)

VAE_MODELS=(
)

LORA_MODELS=(
	#XLabs-AIflux-RealismLora 
     "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors?download=true"
)

ESRGAN_MODELS=(
    #"https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    #"https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    #"https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
)

CONTROLNET_MODELS=(
)

URL_ESRGAN_MODELS=(
    "safetensors/ESRGAN/1x-ITF-Skin.rar,1x-ITF-SkinDiffDetail-Lite-v1.pth"
	"safetensors/ESRGAN/1x_DeB.rar,1x_DeBLR.pth"
	"safetensors/ESRGAN/4x-UltraSh.rar,4x-UltraSharp.pth"
	"safetensors/ESRGAN/4x_NMKD-Supersca.rar,4x_NMKD-Superscale-SP_178000_G.pth"
	"safetensors/ESRGAN/4x_RealisticResca.rar,4x_RealisticRescaler_100000_G.pth"
	"safetensors/ESRGAN/8x_NMKD-Supe.rar,8x_NMKD-Superscale_150000_G.pth"
)

URL_BBOX_MODELS=(
    "safetensors/bbox/bre.rar,bre.pt"
	"safetensors/bbox/bre4.rar,bre4.pt"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    # Get licensed models if HF_TOKEN set & valid
    if provisioning_has_valid_hf_token; then
        UNET_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors")
        VAE_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors")
    else
        #UNET_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors")
	#UNET_MODELS+=("https://huggingface.co/lllyasviel/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q5_K_S.gguf?download=true")
	UNET_MODELS+=("https://huggingface.co/lllyasviel/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q8_0.gguf?download=true")
	UNET_MODELS+=("https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8-e4m3fn.safetensors?download=true")
	VAE_MODELS+=("https://huggingface.co/foxmail/flux_vae/resolve/main/ae.safetensors?download=true")
        #sed -i 's/flux1-dev\.safetensors/flux1-dev-fp8-e4m3fn.safetensors/g' /opt/ComfyUI/web/scripts/defaultGraph.js
    fi

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
	provisioning_get_models_url \
		"${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
		"${URL_ESRGAN_MODELS[@]}"
	provisioning_get_models_url \
		"${WORKSPACE}/ComfyUI/models/ultralytics/bbox" \
		"${URL_BBOX_MODELS[@]}"
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


provisioning_start
