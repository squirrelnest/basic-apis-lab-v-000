class RepositoriesController < ApplicationController

  def search
  end

  def github_search
    begin
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['client_id'] = 'Iv1.4152657178dd52b8'
      req.params['client_secret'] = '3c1c1dd996aaf614ff68203a876f4c0a6603189c'
      req.params['q'] = params['query']
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @repos = body["items"]
    else
      @error = body["message"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
