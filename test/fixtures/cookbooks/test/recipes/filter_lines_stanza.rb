#
# Verify the results of using the stanza filter
#

template '/tmp/stanza' do
  source 'stanza.erb'
  action :create_if_missing
end

filter_lines 'Change stanza values' do
  path '/tmp/stanza'
  sensitive false
  filters(
    [
      { stanza:  ['libvas', { 'use-dns-srv' => false, 'mscldap-timeout' => 5 }] },
      { stanza:  ['nss_vas', { 'lowercase-names' => false, addme: 'option' }] },
    ]
  )
end
