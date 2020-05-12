require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      NATIVE_DATABASE_TYPES[:string] = { :name => "varchar", :limit => 191 }
      init_connect='SET collation_connection = utf8_unicode_ci'
      init_connect='SET NAMES utf8mb4'
      innodb_file_format_max = 'Barracuda'
      innodb_strict_mode = 1
      default_character_set = 'utf8mb4'
      character_set_server = 'utf8mb4'
      collation_server = 'utf8_unicode_ci'
    end
  end
end