#!/bin/bash

# Define o padrão de versão usando uma expressão regular
version_pattern='[0-9]+\.[0-9]+\.[0-9]+'

# Encontra o diretório mais recente que corresponde ao padrão de versão
latest_version_dir=$(ls -d ~/Library/Application\ Support/discord/*/ | grep -E "$version_pattern" | sort -V | tail -1)

# Verifica se encontrou um diretório correspondente
if [ -n "$latest_version_dir" ]; then
  # Executa o comando com o diretório mais recente
  sudo amdfriend --in-place --sign "${latest_version_dir}modules/discord_krisp/discord_krisp.node"
else
  echo "Nenhum diretório correspondente encontrado."
fi
