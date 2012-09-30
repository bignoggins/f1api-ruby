require 'json'

module FellowshipOneAPI
  # Creating a wrapper for the ActiveResource::Connection class
  class Connection < ActiveResource::Connection
    attr_accessor :resource_class

    # Pass in a new connection to the API
    def initialize(f1api_connection, *args)
      @f1api_connection = f1api_connection
      super(*args)
    end

    private

    # The request method that is passes the request through to the F1 API client
    def request(method, path, *args)
      if @f1api_connection == nil
        super(method, path, *args)
      else
        path = fix_path(path)

        case method
        when :get
          response = @f1api_connection.request(method, path, *args)
          response.body = transform_get_response response.body
        when :put
          response = transform_put_request path, args[0]
        when :post
          response = transform_create_request path, args[0]
        end
        handle_response(response)
      end
    end

    def transform_create_request(path, request_body)
      new_path = "#{path.gsub(".json", "")}/new.json"
      new_record = @f1api_connection.request :get, new_path

      transform_and_save(:post, path, request_body, new_record.body)
    end

    def transform_put_request(path, request_body)
      edit_path = path.gsub(/(.*)\.json$/, '\1/edit.json')
      edit_record = @f1api_connection.request :get, edit_path

      transform_and_save(:put, path, request_body, edit_record.body)
    end

    def transform_get_response(response_body)
      json = JSON.parse(response_body)
      if json.keys.first == "results"
        results = json["results"][self.resource_class.name.split("::").last.downcase]
        return "[]" unless results

        (json["results"].keys.find_all {|key| key[0] == '@' && key != '@array'}).each do |key|
          results.each do |result|
            result.merge!({key => json["results"][key]})
          end
        end
        JSON.dump(results)
      elsif !json[json.keys.first][json.keys.first.singularize].nil?
        JSON.dump(json[json.keys.first][json.keys.first.singularize])
      else
        JSON.dump(json[json.keys.first])
      end
    end


    def set_f1_hash_to_ar_values(f1_hash, ar_hash)
      f1_hash.each do |key, val|
        if val.is_a? Hash
          set_f1_hash_to_ar_values(val, ar_hash[key]) unless ar_hash.nil?
        else
          f1_hash[key] = ar_hash[key] unless ar_hash.nil? || (key == "@id" && ar_hash[key].nil?)
        end
      end
    end

    def transform_and_save(http_verb, path, request_body, record)
      merged_entity = JSON.parse(record)
      new_values = JSON.parse(request_body)
      new_values = camelize_root(new_values)

      merged_entity = set_f1_hash_to_ar_values(merged_entity, new_values)

      if path =~ /\/[vV]1\/(.*)\/(.*)$/
        new_path = "/V1/#{$1.capitalize}/#{$2}"
      end
      @f1api_connection.request(http_verb, new_path, JSON.dump(merged_entity), {'Content-Type' => 'application/json'})
    end

    def fix_path(path)
      # F1 runs words in paths together (contribution_receipts is contributionreceipts, but why??)
      path = path.gsub("_", "")

      # Oh yeah.  They also deviate from the rest of the path formats
      # by prepending "/giving" for all paths in the Giving realm.

      # Add more resources as needed
      giving_realm_resources = %w[contributionreceipts]
      path = "/giving#{path}" if giving_realm_resources.any? { |resource| path.include? resource }

      path
    end

    def camelize_root(hash)
      key = hash.keys.first
      new_key = key.camelize
      new_key = "#{new_key.first.downcase}#{new_key[1..-1]}"
      { new_key => hash[key] }
    end
  end
end
