module FeatureSteps
  step 'VCR cassette is :cassette_name' do |cassette_name|
    @cassette_name = cassette_name
  end

  step 'dispatch :endpoint_name request' do |endpoint_name, table|
    @endpoint = GMO::PG.const_get(endpoint_name)
    @request  = @endpoint::Request.new(to_params(table))

    VCR.use_cassette @cassette_name, vcr_options do
      @response = GMO::PG.connect { |d| d.dispatch(@request) }
      histories << { endpoint: @endpoint, request: @request, response: @response }
    end
  end

  step 'response has no error' do
    expect(@response).not_to be_error
  end

  private

  def vcr_options(overrides = {})
    {
      re_record_interval: 60 * 60 * 24 * 7, # 7 days
      match_requests_on: %i{ method uri },
      allow_unused_http_interactions: true,
      record: :new_episodes,
    }.merge(overrides)
  end

  def to_params(table)
    table.hashes.each_with_object({}) do |row, params|
      params[row['Name']] =
        case row['Value']
        when /\A<%=.*%>\Z/
          ERB.new(row['Value']).result(binding)
        else
          row['Value']
        end
    end
  end

  def histories
    @histories ||= []
  end

  def order_id
    @order_id ||= 'OID-' + [*('a'..'z'), *('A'..'Z'), *('0'..'9')].sample(23).join('')
  end

  def member_id
    @member_id ||= 'MEM-' + [*('a'..'z'), *('A'..'Z'), *('0'..'9'), '-', '@', '_', '.'].sample(56).join('')
  end
end
