#!/bin/sh -e
# ESET PROTECT
# Copyright (c) 1992-2025 ESET, spol. s r.o. All Rights Reserved

files2del="$(mktemp -q /tmp/EraAgentOnlineInstaller.XXXXXXXX)"
dirs2del="$(mktemp -q /tmp/EraAgentOnlineInstaller.XXXXXXXX)"
echo "$dirs2del" >> "$files2del"
dirs2umount="$(mktemp -q /tmp/EraAgentOnlineInstaller.XXXXXXXX)"
echo "$dirs2umount" >> "$files2del"

finalize()
{
  set +e

  echo "Cleaning up:"

  if test -f "$dirs2umount"
  then
    while read f
    do
      sudo -S hdiutil detach "$f"
    done < "$dirs2umount"
  fi

  if test -f "$dirs2del"
  then
    while read f
    do
      test -d "$f" && rm -rf "$f"
    done < "$dirs2del"
  fi

  if test -f "$files2del"
  then
    while read f
    do
      rm -f "$f"
    done < "$files2del"
    rm -f "$files2del"
  fi
}

trap 'finalize' HUP INT QUIT TERM EXIT

eraa_server_hostname="myenp45fxzludb3j5fcfimo52a.a.ecaserver.eset.com"
eraa_server_port="443"
eraa_server_company_name='Regula Forensics Inc.'
eraa_peer_cert_b64="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"
eraa_peer_cert_pwd=""
eraa_ca_cert_b64="MIIFpDCCA4ygAwIBAgIIMUSW0eFkh/8wDQYJKoZIhvcNAQELBQAwaDELMAkGA1UEBhMCU0sxGDAWBgNVBAgTD1Nsb3ZhayBSZXB1YmxpYzETMBEGA1UEBxMKQnJhdGlzbGF2YTENMAsGA1UEChMERXNldDEbMBkGA1UEAxMSRVBDIEFnZW50IHByb3h5IENBMB4XDTIyMDYyMDAwMDAwMFoXDTMyMDYxOTIzNTk1OVowaDELMAkGA1UEBhMCU0sxGDAWBgNVBAgTD1Nsb3ZhayBSZXB1YmxpYzETMBEGA1UEBxMKQnJhdGlzbGF2YTENMAsGA1UEChMERXNldDEbMBkGA1UEAxMSRVBDIEFnZW50IHByb3h5IENBMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApFyygZ31hn6s/K7+Lm/r3KP+P5Gn0pb5J6IR0F+KtBUiNE9nRn5PnVDdyj9uVd6BZIKcczoHebH/70GQUuOzprDtHhWUTNDZ7R4NfNz0u5cYn2mKPk9lJRPEcuvqKr+aGsCs1yMv226xd72ngJE/Z2MlGLGX5+kuO0HmQWRUK/SDtmcCvforHs7zE19PjXmZQnpW+bUFkLeHcHS4WtJ64CNkbuTHssK8nNDQoJXLZVKafLWCkAZ94vpZWDRG5AffdBDnKrSy+WOTI6dOJw8i+uJ7YtWconTJo9NRCcgTzCHujylXgqWkwm3f+Wh/h0u5KIJEzTPN/RTzP+/SWEDrYi7+wECXWv6kU3Ty3KkzPGsAt9ABmnvAUGShi8Heyhnes6E3IiUt3wko+LHVw9hFyXFjfqtgRtxvOTcX06zinpQbtl+d1Wm7mU/ORFIPffRec4B9YewF1VRCm4gT5vqFZbO7BUnuyKFeGr6Vxlgrgz0mPS0PAoATI500x9g8Md3Mmshc/6wLInMHgSh//n+aylnePRrTvLEJhcWgoDx57wZ7G5fTeHEFIRrcU3ez6PSKbodCBcjfWrGLkXNQzmIwhDxVRmo4DXLga6MzbYqU54zQVfk60CiFEvwwK8l7WBZ7XlqxRl8QmsIUGf278N8Hxe0qOs7fcZPvuVHyhS4WKxsCAwEAAaNSMFAwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUZ9DJSflsyGkpLas5Ll3dMzeMJSEwCwYDVR0PBAQDAgEGMBEGCWCGSAGG+EIBAQQEAwIABzANBgkqhkiG9w0BAQsFAAOCAgEAWrXSFAd4OmT0bxHj1q+zMROTxXalzfAfqncTGaTm2NiqL5be3WfgnQLjGOMX+VVC1YXDlI2xs2JAWD3myRT4u7g1Y320HmjWczaE36h8PrnL+M/LEIHem3bM7e6ZFGHzwN80D5bmM++qacrGnnSDXid/sVx2Vi5KKXOXcFB74Haef5mqVm9uNpjDuUO+7Zdip6xqieHOpYD7HIWCkq/bJXxyrPr9CY37KyVdeMoU8QuIzdlgn5l0yc8LNBXXv7pba+ykPirIWe1ZR0O0z5e0gAqUe0kz9fpiMmzWpaGS/4s8gt0oYX2Ahibc3Lgg179OOpUFOsz92TmPVQCnzseZCPirikCA7qUAmMFKqs+l+X6DdKIrL4ocHs5zFAL9fysdKpczKczAWpZXr9LtuY6WFDkcWhxm4kj1MXyte8UBBC4C1UX47Km5TlOQUApnp7LMXI3jlBB+2Lo3T9N2FhiQ5R2PoNdA+XONNaBb8E9mh83wOvA6+Me1Rb7bIO6q/dTULd41Jns3JQ8zy0H8rQrOSOREWfieW0Czd38ZRJoa7MRp6Z3aYAuqt8pJpOykVbKQY/OYh43pt5gfgFvIkI3CuoJvLPQ3bYKyBiJN8PYhFpOyLYOrOJqbd26x+QFORgiBdZo6u6Em31l3fVpiaMcSAD9Cny6VUEC2aYn00beB2Vc="
eraa_product_uuid=""
eraa_initial_sg_token=""
eraa_enable_telemetry="0"
eraa_policy_data=""

eraa_http_proxy_use="0"
eraa_http_proxy_hostname=""
eraa_http_proxy_port=""
eraa_http_proxy_user=""
eraa_http_proxy_password=""

arch=$(uname -m)
eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v12/12.5.2104.0/agent_macosx_x86_64.dmg"
eraa_installer_checksum="09faa39659a0a91567646d9c0613047ef64d348efcab85a104b0aa2a40f5b77a"
if $(echo "$arch" | grep -E "^(x86_64|amd64)$" 2>&1 > /dev/null)
then
    eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v12/12.5.2104.0/agent_macosx_x86_64.dmg"
    eraa_installer_checksum="09faa39659a0a91567646d9c0613047ef64d348efcab85a104b0aa2a40f5b77a"
elif $(echo "$arch" | grep -E "^(arm64)$" 2>&1 > /dev/null)
then
    eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v12/12.5.2104.0/agent_macosx_x86_64.dmg"
    eraa_installer_checksum="09faa39659a0a91567646d9c0613047ef64d348efcab85a104b0aa2a40f5b77a"
    if test -z $eraa_installer_url
    then
        eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v12/12.5.2104.0/agent_macosx_x86_64.dmg"
        eraa_installer_checksum="09faa39659a0a91567646d9c0613047ef64d348efcab85a104b0aa2a40f5b77a"
    fi
fi

echo "ESET Management Agent live installer script. Copyright © 1992-2025 ESET, spol. s r.o. - All rights reserved."

if test ! -z "$eraa_server_company_name"
then
  echo " * CompanyName: $eraa_server_company_name"
fi
echo " * Hostname: $eraa_server_hostname"
echo " * Port: $eraa_server_port"
echo " * Platform: $arch"
echo " * Installer: $eraa_installer_url"
echo

if test -z "$eraa_installer_url"
then
  echo "No installer available for '$arch' arhitecture."
  exit 1
fi

local_params_file="/tmp/postflight.plist"
echo "$local_params_file" >> "$files2del"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >> "$local_params_file"
echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> "$local_params_file"
echo "<plist version=\"1.0\">" >> "$local_params_file"
echo "<dict>" >> "$local_params_file"

echo "  <key>Hostname</key><string>$eraa_server_hostname</string>" >> "$local_params_file"
echo "  <key>SendTelemetry</key><string>$eraa_enable_telemetry</string>" >> "$local_params_file"

echo "  <key>Port</key><string>$eraa_server_port</string>" >> "$local_params_file"

if test -n "$eraa_peer_cert_pwd"
then
  echo "  <key>PeerCertPassword</key><string>$eraa_peer_cert_pwd</string>" >> "$local_params_file"
  echo "  <key>PeerCertPasswordIsBase64</key><string>yes</string>" >> "$local_params_file"
fi

echo "  <key>PeerCertContent</key><string>$eraa_peer_cert_b64</string>" >> "$local_params_file"


if test -n "$eraa_ca_cert_b64"
then
  echo "  <key>CertAuthContent</key><string>$eraa_ca_cert_b64</string>" >> "$local_params_file"
fi
if test -n "$eraa_product_uuid"
then
  echo "  <key>ProductGuid</key><string>$eraa_product_uuid</string>" >> "$local_params_file"
fi
if test -n "$eraa_initial_sg_token"
then
  echo "  <key>InitialStaticGroup</key><string>$eraa_initial_sg_token</string>" >> "$local_params_file"
fi
if test -n "$eraa_policy_data"
then

  echo "  <key>CustomPolicy</key><string>$eraa_policy_data</string>" >> "$local_params_file"
fi

if test "$eraa_http_proxy_use" = "1"
then
  echo "  <key>UseProxy</key><string>$eraa_http_proxy_use</string>" >> "$local_params_file"
  echo "  <key>ProxyHostname</key><string>$eraa_http_proxy_hostname</string>" >> "$local_params_file"
  echo "  <key>ProxyPort</key><string>$eraa_http_proxy_port</string>" >> "$local_params_file"
  echo "  <key>ProxyUsername</key><string>$eraa_http_proxy_user</string>" >> "$local_params_file"
  echo "  <key>ProxyPassword</key><string>$eraa_http_proxy_password</string>" >> "$local_params_file"
fi

echo "</dict>" >> "$local_params_file"
echo "</plist>" >> "$local_params_file"

local_installer="$(dirname $0)"/"$(basename $eraa_installer_url)"

if $(echo "$eraa_installer_checksum  $local_installer" | shasum -a 256 -c 2> /dev/null > /dev/null)
then
    echo "Verified local installer was found: '$local_installer'"
else
    local_installer=""

    local_installer_dir="$(mktemp -q -d /tmp/EraAgentOnlineInstaller.XXXXXXXX)"
    echo "Downloading installer image '$eraa_installer_url':"

    eraa_http_proxy_value=""
    if test -n "$eraa_http_proxy_value"
    then
      export use_proxy=yes
      export http_proxy="$eraa_http_proxy_value"
      cd "$local_installer_dir" && { curl --fail --connect-timeout 300 --insecure -O -J "$eraa_installer_url" || curl --fail --connect-timeout 300 --noproxy "*" --insecure -O -J "$eraa_installer_url" ; cd - > /dev/null ; } && echo "$local_installer_dir" >> "$dirs2del"
    else
      cd "$local_installer_dir" && { curl --fail --connect-timeout 300 --insecure -O -J "$eraa_installer_url" ; cd - > /dev/null ; } && echo "$local_installer_dir" >> "$dirs2del"
    fi

    installer_filename="$(ls $local_installer_dir)"

    if [ "$installer_filename" ];
    then
        local_installer="$local_installer_dir"/"$installer_filename" && echo "$local_installer" >> "$files2del"
    fi

    if test ! -s "$local_installer"
    then
       echo "Failed to download installer file"
       exit 2
    fi

    /bin/echo -n "Checking integrity of downloaded package " && echo "$eraa_installer_checksum  $local_installer" | shasum -a 256 -c
fi

if $(echo "$local_installer" | grep -E "\.dmg$" 2>&1 > /dev/null)
then
    local_mount="$(mktemp -q -d /tmp/EraAgentOnlineInstaller.XXXXXXXX)" && echo "$local_mount" | tee "$dirs2del" >> "$dirs2umount"
    echo "Mounting image '$local_installer':" && sudo -S hdiutil attach "$local_installer" -mountpoint "$local_mount" -nobrowse

    local_pkg="$(ls "$local_mount" | grep "\.pkg$" | head -n 1)"

    echo "Installing package '$local_mount/$local_pkg':" && sudo -S installer -pkg "$local_mount/$local_pkg" -target /
elif $(echo "$local_installer" | grep -E "\.pkg$" 2>&1 > /dev/null)
then
    echo "Installing package '$local_installer':" && sudo -S installer -pkg "$local_installer" -target /
else
    echo "Installing package '$local_installer' has unsupported package type"
fi
