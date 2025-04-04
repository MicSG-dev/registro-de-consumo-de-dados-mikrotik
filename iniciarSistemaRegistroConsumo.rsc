:local nomeArquivo "consumidoSessaoAnterior.txt" 

:local arquivoExiste false

:foreach arq in=[/file find] do={
    :if ([/file get $arq name] = $nomeArquivo) do={
        :set arquivoExiste true
    }
}

:if (!$arquivoExiste) do={
    /file print file=$nomeArquivo
    /file set $nomeArquivo contents="DOWNLOAD:0&UPLOAD:0"

    :log info "Arquivo '$nomeArquivo' criado porque não existia."
} else={
    :log info "Arquivo '$nomeArquivo' já existe. Nenhuma ação necessária."
}

# substitui o nome do arquivo para consumidoSessaoAtual.txt
:set nomeArquivo "consumidoSessaoAtual.txt"
:local arquivoAtualExiste false

:foreach arq in=[/file find] do={
    :if ([/file get $arq name] = $nomeArquivo) do={
        :set arquivoAtualExiste true
    }
}

:if (!$arquivoAtualExiste) do={
    /file print file=$nomeArquivo
    /file set $nomeArquivo contents="DOWNLOAD:0&UPLOAD:0"

    :log info "Arquivo '$nomeArquivo' criado porque não existia."
} else={
    :log info "Arquivo '$nomeArquivo' já existe. Nenhuma ação necessária."
}