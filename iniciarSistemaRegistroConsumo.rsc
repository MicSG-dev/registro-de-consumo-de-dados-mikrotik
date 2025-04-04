:log info " "
:log info "Iniciando o sistema de registro de consumo de dados."

:local nomeArquivoSessaoAnterior "consumidoSessaoAnterior.txt" 
:local nomeArquivoSessaoAtual "consumidoSessaoAtual.txt"

:local arquivoExiste false

:foreach arq in=[/file find] do={
    :if ([/file get $arq name] = $nomeArquivoSessaoAnterior) do={
        :set arquivoExiste true
    }
}

:if (!$arquivoExiste) do={
    /file print file=$nomeArquivoSessaoAnterior
    /file set $nomeArquivoSessaoAnterior contents="DOWNLOAD:0&UPLOAD:0"

    :log info "Arquivo '$nomeArquivoSessaoAnterior' criado porque não existia."
}

:set arquivoExiste false

:foreach arq in=[/file find] do={
    :if ([/file get $arq name] = $nomeArquivoSessaoAtual) do={
        :set arquivoExiste true
    }
}

:if (!$arquivoExiste) do={
    /file print file=$nomeArquivoSessaoAtual
    /file set $nomeArquivoSessaoAtual contents="DOWNLOAD:0&UPLOAD:0"

    :log info "Arquivo '$nomeArquivoSessaoAtual' criado porque não existia."
}

:local consumoDownloadAnterior 0
:local consumoUploadAnterior 0

:local conteudoArquivo [/file get $nomeArquivoSessaoAnterior contents]


:local iniDownload [:find $conteudoArquivo "DOWNLOAD:"]

# Extrair DOWNLOAD
:if ($iniDownload >= 0) do={
    :set iniDownload ($iniDownload + [:len "DOWNLOAD:"])
    :local fimDownload [:find $conteudoArquivo "&UPLOAD:"]
    :if ($fimDownload > $iniDownload) do={
        :set consumoDownloadAnterior [:tonum [:pick $conteudoArquivo $iniDownload $fimDownload]]
    }
}

# Extrair UPLOAD
:local iniUpload [:find $conteudoArquivo "UPLOAD:"]
:if ($iniUpload >= 0) do={
    :set iniUpload ($iniUpload + [:len "UPLOAD:"])
    :local fimUpload [:len $conteudoArquivo]
    :set consumoUploadAnterior [:tonum [:pick $conteudoArquivo $iniUpload $fimUpload]]
}

:log info "Consumo de dados anterior: Download = $consumoDownloadAnterior E Upload = $consumoUploadAnterior"


:local consumoDownloadAtual 0
:local consumoUploadAtual 0

:set conteudoArquivo [/file get $nomeArquivoSessaoAtual contents]

:set iniDownload [:find $conteudoArquivo "DOWNLOAD:"]

# Extrair DOWNLOAD
:if ($iniDownload >= 0) do={
    :set iniDownload ($iniDownload + [:len "DOWNLOAD:"])
    :local fimDownload [:find $conteudoArquivo "&UPLOAD:"]
    :if ($fimDownload > $iniDownload) do={
        :set consumoDownloadAtual [:tonum [:pick $conteudoArquivo $iniDownload $fimDownload]]
    }
}

# Extrair UPLOAD
:set iniUpload [:find $conteudoArquivo "UPLOAD:"]
:if ($iniUpload >= 0) do={
    :set iniUpload ($iniUpload + [:len "UPLOAD:"])
    :local fimUpload [:len $conteudoArquivo]
    :set consumoUploadAtual [:tonum [:pick $conteudoArquivo $iniUpload $fimUpload]]
}

:log info "Consumo de dados atual: Download = $consumoDownloadAtual E Upload = $consumoUploadAtual"

:local downloadTotal 0
:local uploadTotal 0

# somar os contadores de download e upload em consumidoSessaoAnterior.txt
:set downloadTotal ($consumoDownloadAnterior + $consumoDownloadAtual)
:set uploadTotal ($consumoUploadAnterior + $consumoUploadAtual)
/file set $nomeArquivoSessaoAnterior contents="DOWNLOAD:$downloadTotal&UPLOAD:$uploadTotal"

:log info "Consumo de dados total: Download = $downloadTotal E Upload = $uploadTotal"

# zerar os contadores de download e upload em consumidoSessaoAtual.txt
/file set $nomeArquivoSessaoAtual contents="DOWNLOAD:0&UPLOAD:0"
:log info "Contadores de download e upload zerados em '$nomeArquivoSessaoAtual'."

:log info "Sistema de registro de consumo de dados finalizado."