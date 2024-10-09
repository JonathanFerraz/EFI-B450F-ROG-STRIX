#!/bin/bash

# Função para listar volumes com UUID, ignorando Time Machine e o disco principal do macOS
listar_volumes() {
    echo "Volumes montados com seus UUIDs (excluindo Time Machine e o disco principal):"
    for volume in /Volumes/*; do
        # Ignora volumes relacionados ao Time Machine e o disco principal
        if [[ "$volume" == *"TimeMachine"* || "$volume" == *"com.apple.TimeMachine"* || "$volume" == "/" ]]; then
            continue
        fi

        # Pega o UUID do volume e exibe
        uuid=$(diskutil info "$volume" | grep "Volume UUID" | awk '{print $3}')
        if [[ -n "$uuid" ]]; then
            echo "$(basename "$volume") -> $uuid"
        fi
    done
}

# Função para verificar se o UUID já está presente no fstab
verificar_fstab() {
    local uuid=$1
    if grep -q "UUID=$uuid" /etc/fstab; then
        return 0
    else
        return 1
    fi
}

# Função para adicionar UUID ao fstab para APFS e NTFS
adicionar_ao_fstab() {
    local uuid=$1
    local nome_volume=$2

    # Verifica se o arquivo fstab existe, se não, cria
    if [ ! -f /etc/fstab ]; then
        sudo touch /etc/fstab
    fi

    # Verifica se o UUID já está presente no fstab
    if verificar_fstab "$uuid"; then
        echo "O volume $nome_volume com UUID $uuid já está adicionado ao fstab."
        return
    fi

    # Adiciona o comentário e as entradas no fstab para APFS e NTFS
    echo "# $nome_volume" | sudo tee -a /etc/fstab > /dev/null
    echo "UUID=$uuid none apfs rw,noauto" | sudo tee -a /etc/fstab > /dev/null
    echo "UUID=$uuid none ntfs rw,noauto" | sudo tee -a /etc/fstab > /dev/null

    echo "Volume $nome_volume com UUID $uuid adicionado ao fstab nos formatos APFS e NTFS."

    # Desmonta o volume após adicionar ao fstab
    local path="/Volumes/$nome_volume"
    echo "Desmontando o volume $path..."
    sudo diskutil unmount "$path"
}

# Listar volumes e seus UUIDs
listar_volumes

# Pergunta ao usuário quais volumes deseja adicionar ao fstab
while true; do
    read -p "Digite o nome do volume que deseja impedir de montar na inicialização (ou digite 'sair' para finalizar): " volume

    if [[ "$volume" == "sair" ]]; then
        break
    fi

    # Pega o UUID do volume
    uuid=$(diskutil info "/Volumes/$volume" | grep "Volume UUID" | awk '{print $3}')

    if [[ -z "$uuid" ]]; then
        echo "Volume $volume não encontrado. Tente novamente."
        continue
    fi

    # Adiciona ao fstab nos formatos APFS e NTFS e desmonta o volume
    adicionar_ao_fstab "$uuid" "$volume"
done

# Reinicia o auto mounter
echo "Reiniciando auto mounter..."
sudo automount -vc

echo "Processo concluído."
