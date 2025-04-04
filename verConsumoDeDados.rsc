:log info " "
:log info "Consumo de dados total"

:local nomeArquivoSessaoAnterior "flash/consumidoSessaoAnterior.txt" 
:local nomeArquivoSessaoAtual "flash/consumidoSessaoAtual.txt"

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

:local downloadTotal 0
:local uploadTotal 0

# somar os contadores de download e upload em consumidoSessaoAnterior.txt
:set downloadTotal ($consumoDownloadAnterior + $consumoDownloadAtual)
:set uploadTotal ($consumoUploadAnterior + $consumoUploadAtual)

:log info "Download: $downloadTotal MB"
:log info "Upload: $uploadTotal MB"