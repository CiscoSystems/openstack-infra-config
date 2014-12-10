# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

$env = YAML::load_file('vagrant.yml')

Vagrant.configure('2') do |config|

    # Local name resolution via the vagrant-hostmanager plugin
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    # Create and provision each host as defined in the site's YAML file
    $env['hosts'].each do |host_name, host_config|
        config.vm.define host_name do |host|
            host.vm.synced_folder '.', '/vagrant', :disabled => false
            host.vm.synced_folder './modules', '/modules', :disabled => false

            host.vm.box = host_config['box']
            host.vm.network 'private_network', :ip => host_config['private_ip']
            host.vm.host_name = "#{host_name}.local"


            host.hostmanager.aliases = ["#{host_name}"]

            if host_config['ports']
                host_config['ports'].each do |port|
                    host.vm.network 'forwarded_port', :guest => port['guest'],
                                    :host => port['host']
                end
            end

            # VirtualBox config
            host.vm.provider :virtualbox do |vbox|
                if host_config['memory']
                    vbox.customize ['modifyvm', :id, '--memory',
                                    host_config['memory']]
                end
                vbox.customize ['modifyvm', :id, '--usb', 'off']
            end

            # VMware config
            host.vm.provider :vmware_fusion do |vmware|
                if host_config['memory']
                    vmware.vmx['memsize'] = host_config['memory']
                end
                vmware.vmx['numvcpus'] = '1'
                vmware.vmx['virtualHW.version'] = '11'
                vmware.vmx['vhv.enable'] = 'TRUE'
                vmware.gui = false
            end

            # ---------
            # Provision
            # ---------

            # Install Puppet and all required 3rd party modules
            host.ssh.shell = 'bash -c "BASH_ENV=/etc/profile exec bash"'
            host.vm.provision 'shell', privileged: true, inline: 'cd /vagrant/ && ./install_puppet.sh && ./install_modules.sh'

            # Run puppet apply using our manifest, as such
            # puppet apply -l /tmp/manifest.log --modulepath=modules:/etc/puppet/modules manifests/vagrant.pp
            # host.vm.provision 'puppet' do |puppet|
            #     puppet.manifest_file = 'vagrant.pp'
            #     puppet.working_directory = '/vagrant'
            #     puppet.options = '-l /tmp/manifest.log --modulepath=/modules:/etc/puppet/modules'
            # end
        end
    end
end
