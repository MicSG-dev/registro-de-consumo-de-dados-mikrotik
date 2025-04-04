:log info " "
:log info "Registrando o consumo de dados"

:local nomeArquivoSessaoAtual "consumidoSessaoAtual.txt"

:local consumoDownload [/interface get lte1 rx-byte]
:local consumoUpload [/interface get lte1 tx-byte]

:set consumoDownload ($consumoDownload / 1000000)
:set consumoUpload ($consumoUpload / 1000000)

/file set $nomeArquivoSessaoAtual contents="DOWNLOAD:$consumoDownload&UPLOAD:$consumoUpload"

:log info "Download: $consumoDownload MB E Upload: $consumoUpload MB"
:log info "Registro de consumo de dados finalizado."