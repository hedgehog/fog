require 'lib/fog/vcloud/terremark/ecloud/models/node'

module Fog
  class Vcloud
    module Terremark
      class Ecloud

        class Nodes < Fog::Vcloud::Collection

          model Fog::Vcloud::Terremark::Ecloud::Node

          attribute :href, :aliases => :Href

          def all
            if data = connection.get_nodes(href).body[:NodeService]
              load(data)
            end
          end

          def get(uri)
            if data = connection.get_node(uri)
              new(data.body)
            end
          rescue Fog::Errors::NotFound
            nil
          end

        end
      end
    end
  end
end
