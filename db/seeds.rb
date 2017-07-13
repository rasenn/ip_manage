# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# AdminUser.create(:email => "admin@test.com", :password => "hogehoge", :password_confirmation => "hogehoge")

AdminUser.create(:username => "admin", :password => "hogehoge", :password_confirmation => "hogehoge")


# for active direcoty

ldap_config = YAML.load(ERB.new(File.read(::Devise.ldap_config || "#{Rails.root}/config/ldap.yml")).result)[Rails.env]
ldap_config["ssl"] = :simple_tls if ldap_config["ssl"] === true
ldap_options[:encryption] = ldap_config["ssl"].to_sym if ldap_config["ssl"]

ldap_host = ldap_config["host"]
ldap_port = ldap_config["port"]
ldap_base = ldap_config["base"]
attribute = ldap_config["attribute"]
ldap_admin_user = ldap_config["admin_user"]
ldap_admin_password = ldap_config["admin_password"]

ldap = Net::LDAP.new :host => ldap_host,
     :port => ldap_port,
     :auth => {
           :method => :simple,
           :username => ldap_admin_user,
           :password => ldap_admin_password
     }

filter = Net::LDAP::Filter.eq( "cn", "George*" )
treebase = ldap_base

ldap.search( :base => treebase ) do |entry|
#CN=Person,CN=Schema,CN=Configuration,DC=test,DC=local
  if entry["objectCategory"]
    if entry["objectCategory"][0] && entry["objectCategory"][0] =~ /CN=Person,CN=Schema,CN=Configuration/
      # p entry["objectCategory"][0]
      # puts entry["sAMAccountName"]
      # p entry["displayname"]
      # puts "---------"

      displayname = entry["sAMAccountName"][0]
      displayname = entry["displayname"][0] if entry["displayname"].size > 0
      User.create(:username => entry["sAMAccountName"][0], :displayname => displayname)
    end
  end

end


