# encoding: utf-8

Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end

  config.development do |dev|
    dev.platform.logging.level = :debug
  end

  ##
  # Use with Rayo (eg Voxeo PRISM or FreeSWITCH mod_rayo)
  #
  config.punchblock.username = "ahn@ahn-demo.com" # Your XMPP JID for use with Rayo
  config.punchblock.password = "1234" # Your XMPP password
  config.punchblock.host = "192.168.1.118"

  ##
  # Use with Asterisk
  #
  # config.punchblock.platform = :asterisk # Use Asterisk
  # config.punchblock.username = "manager" # Your AMI username
  # config.punchblock.password = "password" # Your AMI password
  # config.punchblock.host = "asterisk.local-dev.mojolingo.com" # Your AMI host
end
