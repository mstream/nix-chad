{ cfg, ... }:
{
  postActivation.text = ''
    if [ ! -f ${cfg.sslCertFilePath} ]; then
        tmp_dir=$(mktemp -d)

        security export \
            -t certs -f pemseq -k /Library/Keychains/System.keychain -o "$tmp_dir/certs-system.pem"

        security export \
            -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o "$tmp_dir/certs-root.pem"

        cat "$tmp_dir/certs-root.pem" "$tmp_dir/certs-system.pem" > "$tmp_dir/ca_cert.pem"
        sudo mv "$tmp_dir/ca_cert.pem" ${cfg.sslCertFilePath}
    fi
  '';
}
