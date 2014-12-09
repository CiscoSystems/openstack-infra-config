node gerrit {
  class { 'gerrit::mysql':
    mysql_root_password => 'password',
    database_name       => 'reviewdb',
    database_user       => 'gerrit2',
    database_password   => 'password',
  }

  class { '::gerrit':
    vhost_name                          => $::fqdn,
    canonicalweburl                     => $canonicalweburl,
  # opinions
    enable_melody                       => true,
    melody_session                      => true,
    robots_txt_source                   => 'puppet:///modules/openstack_project/gerrit/robots.txt',
    enable_javamelody_top_menu          => false,
  # passthrough
    ssl_cert_file                       => "/etc/ssl/certs/${::fqdn}.pem",
    ssl_key_file                        => "/etc/ssl/private/${::fqdn}.key",
    ssl_chain_file                      => $ssl_chain_file,
    # Self-signed dummy cert for example
    ssl_cert_file_contents              => '-----BEGIN CERTIFICATE-----
MIICrTCCAhYCCQD+9RzQDj7NfDANBgkqhkiG9w0BAQUFADCBmjELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAlROMRIwEAYDVQQHEwlOYXNodmlsbGUxHDAaBgNVBAoTE0Np
c2NvIFN5c3RlbXMsIEluYy4xDDAKBgNVBAsTA0NWRzEbMBkGA1UEAxMSTWF0dGhl
dyBNb250Z29tZXJ5MSEwHwYJKoZIhvcNAQkBFhJtYXR0bW9udEBjaXNjby5jb20w
HhcNMTQxMjA1MjEyNjA1WhcNMTUxMjA1MjEyNjA1WjCBmjELMAkGA1UEBhMCVVMx
CzAJBgNVBAgTAlROMRIwEAYDVQQHEwlOYXNodmlsbGUxHDAaBgNVBAoTE0Npc2Nv
IFN5c3RlbXMsIEluYy4xDDAKBgNVBAsTA0NWRzEbMBkGA1UEAxMSTWF0dGhldyBN
b250Z29tZXJ5MSEwHwYJKoZIhvcNAQkBFhJtYXR0bW9udEBjaXNjby5jb20wgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANXe5kt5KF2klYVbcajW8UiULuTAYJFf
Toys+rYcWmKfjMQs0tOEeSYFciY4Wb3OFShZJl6JK7dpzI1HVzdcOBpcDaYmcRpc
HfHTqp5sAJz76eQHhgKHEnUtEreXJFA0VMHDWUszUlXmzFwqJpbQdQjOrpT5wxwR
bhgmgXuBQZ3dAgMBAAEwDQYJKoZIhvcNAQEFBQADgYEAptfAit0m2aD3nB+Ae3Ec
8j+vXHSNGt9k7XMir+gqhd3UtVueb8z+UM3nop9ISazeHUN9B4Dj3xOwyBMgiSSt
wweWiM/HwyPbYVf7y5xHNqRxYFyOjOcUwCQlgqisYQV0C9D4S+fEdy8vGXUcVC/+
aDE2arZAfXhxnd71Hq6NWJs=
-----END CERTIFICATE-----',
    # Self-signed dummy key for example
    ssl_key_file_contents               => '-----BEGIN RSA PRIVATE KEY-----
MIICXwIBAAKBgQDV3uZLeShdpJWFW3Go1vFIlC7kwGCRX06MrPq2HFpin4zELNLT
hHkmBXImOFm9zhUoWSZeiSu3acyNR1c3XDgaXA2mJnEaXB3x06qebACc++nkB4YC
hxJ1LRK3lyRQNFTBw1lLM1JV5sxcKiaW0HUIzq6U+cMcEW4YJoF7gUGd3QIDAQAB
AoGBAL4Qg1VbbPYbiA2lwJKtwmwf1LTSCn/m1SXLrFsfQ2wWIsFMnGgBeLDDcjhp
J8e4V7Et2R12hfVP/ssnNWkreWbDrrfZ/IMxmdmyugeu8Xi7YDzNGzRElFTnanKP
1l35AFihHcgzdxfDNnm7ipJiCH9TQDUgbYQGx0XPWz+19r75AkEA7P6A9jxB6kFK
+MIlSYQP0biIAhX9gNY8huFSYVoNYeSSrdlWowwVRLc04u056EoQMrSeVfKJdEaT
XIbfxBd3UwJBAOcFq7Qjha/KDaUHopjeXEidJxyVgb3tab9dOhbnTpiH9wbX9I7e
+LRgHj24Qo7SbpNYhotUSO1dnYhZpGSD4A8CQQCryXuPgXRCKpv+nzRKCskwuvMT
l/8OsbxkBNYjLRSAPiA4lk8flvWfvrE+QLj18SG2r4gKQulx+Gp+6mEvEddzAkEA
mLPH3gdI23xL7pSQZkk8aIbwDlXIb3kZV/NQbUkxS2M75lsifLlnXRrXgmZkIDF6
A40VSc1JcxRZB4JxRjthAwJBAIgiY6nBjip1J4btDXcl7Y4KAHti5AEfNXWWnjXv
TmjvbWTiEF9kYVv9OWrctIrRq/5Y6qqeoB2vyGNJC9xLxDs=
-----END RSA PRIVATE KEY-----
',
    ssl_chain_file_contents             => $ssl_chain_file_contents,
    ssh_dsa_key_contents                => $ssh_dsa_key_contents,
    ssh_dsa_pubkey_contents             => $ssh_dsa_pubkey_contents,
    ssh_rsa_key_contents                => $ssh_rsa_key_contents,
    ssh_rsa_pubkey_contents             => $ssh_rsa_pubkey_contents,
    ssh_project_rsa_key_contents        => $ssh_project_rsa_key_contents,
    ssh_project_rsa_pubkey_contents     => $ssh_project_rsa_pubkey_contents,
    ssh_replication_rsa_key_contents    => $ssh_replication_rsa_key_contents,
    ssh_replication_rsa_pubkey_contents => $ssh_replication_rsa_pubkey_contents,
    email                               => $email,
    openidssourl                        => 'https://login.launchpad.net/+openid',
    database_poollimit                  => $database_poollimit,
    container_heaplimit                 => $container_heaplimit,
    core_packedgitopenfiles             => $core_packedgitopenfiles,
    core_packedgitlimit                 => $core_packedgitlimit,
    core_packedgitwindowsize            => $core_packedgitwindowsize,
    sshd_threads                        => $sshd_threads,
    httpd_acceptorthreads               => $httpd_acceptorthreads,
    httpd_minthreads                    => $httpd_minthreads,
    httpd_maxthreads                    => $httpd_maxthreads,
    httpd_maxwait                       => $httpd_maxwait,
    commentlinks                        => [
      {
        name  => 'bugheader',
        match => '([Cc]loses|[Pp]artial|[Rr]elated)-[Bb]ug:\\s*#?(\\d+)',
        link  => 'https://launchpad.net/bugs/$2',
      },
      {
        name  => 'bug',
        match => '\\bbug:? #?(\\d+)',
        link  => 'https://launchpad.net/bugs/$1',
      },
      {
        name  => 'story',
        match => '\\bstory:? #?(\\d+)',
        link  => 'https://storyboard.openstack.org/#!/story/$1',
      },
      {
        name  => 'blueprint',
        match => '(\\b[Bb]lue[Pp]rint\\b|\\b[Bb][Pp]\\b)[ \\t#:]*([A-Za-z0-9\\-]+)',
        link  => 'https://blueprints.launchpad.net/openstack/?searchtext=$2',
      },
      {
        name  => 'testresult',
        match => '<li>([^ ]+) <a href=\"[^\"]+\" target=\"_blank\">([^<]+)</a> : ([^ ]+)([^<]*)</li>',
        html  => '<li class=\"comment_test\"><span class=\"comment_test_name\"><a href=\"$2\">$1</a></span> <span class=\"comment_test_result\"><span class=\"result_$3\">$3</span>$4</span></li>',
      },
      {
        name  => 'launchpadbug',
        match => '<a href=\"(https://bugs\\.launchpad\\.net/[a-zA-Z0-9\\-]+/\\+bug/(\\d+))[^\"]*\">[^<]+</a>',
        html  => '<a href=\"$1\">$1</a>'
      },
      {
        name  => 'changeid',
        match => '(I[0-9a-f]{8,40})',
        link  => '#q,$1,n,z',
      },
      {
        name  => 'gitsha',
        match => '(<p>|[\\s(])([0-9a-f]{40})(</p>|[\\s.,;:)])',
        html  => '$1<a href=\"#q,$2,n,z\">$2</a>$3',
      },
    ],
    war                                 => 'http://tarballs.openstack.org/ci/gerrit/gerrit-v2.8.4.15.6dc8444.war',
    contactstore                        => $contactstore,
    contactstore_appsec                 => $contactstore_appsec,
    contactstore_pubkey                 => $contactstore_pubkey,
    contactstore_url                    => $contactstore_url,
    mysql_host                          => 'localhost',
    mysql_password                      => 'password',
    email_private_key                   => $email_private_key,
    replicate_local                     => $replicate_local,
    replicate_path                      => $local_git_dir,
    replication                         => $replication,
    gitweb                              => $gitweb,
    cgit                                => $cgit,
    web_repo_url                        => $web_repo_url,
    testmode                            => $testmode,
    secondary_index                     => $secondary_index,
    require                             => Class[openstack_project::server],
  }
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443, 29418],
    sysadmins                 => $sysadmins,
  }
}
