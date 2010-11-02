module Fog
  module Parsers
    module AWS
      module CDN

        class Distribution < Fog::Parsers::Base

          def reset
            @response = { 'DistributionConfig' => { 'CNAME' => [], 'Logging' => {}, 'TrustedSigners' => [] } }
          end

          def end_element(name)
            case name
            when 'AwsAccountNumber'
              @response['DistributionConfig']['TrustedSigners'] << @value
            when 'Bucket', 'Prefix'
              @response['DistributionConfig']['Logging'][name] = @value
            when 'CNAME'
              @response['DistributionConfig']['CNAME'] << @value
            when 'DomainName', 'Id', 'Status'
              @response[name] = @value
            when 'CallerReference', 'Comment', 'DefaultRootObject', 'Origin', 'OriginAccessIdentity'
              @response['DistributionConfig'][name] << @value
            when 'Enabled'
              if @value == 'true'
                @response['DistributionConfig'][name] = true
              else
                @response['DistributionConfig'][name] = false
              end
            when 'LastModifiedTime'
              @response[name] = Time.parse(@value)
            when 'Protocol'
              @response['DistributionConfig']['RequireProtocols'] = @value
            when 'Self'
              @response['DistributionConfig']['TrustedSigners'] << 'Self'
            end
          end

        end

      end
    end
  end
end
