#
# Cookbook Name:: kubernetes
# Recipe:: cleaner
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'fileutils'

%w(apiserver controller-manager scheduler proxy).each do |srv|

  if node['kubernetes']['install_via'] == 'systemd_units'
    FileUtils.rm_f "/etc/kubernetes/manifests/#{srv}.yaml"
  end

  if node['kubernetes']['install_via'] == 'static_pods'
    systemd_service "kube-#{srv}" do
      action [:disable, :stop]
    end
  end

end
