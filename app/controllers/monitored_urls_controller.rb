class MonitoredUrlsController < ApplicationController
  include Pagination

  before_action :authenticate_user!
  before_action :set_monitored_url, only: %i[ show update destroy ]

  # GET /monitored_urls
  def index
    @monitored_urls = current_user.monitored_urls.order(created_at: :desc).then(&paginate)

    render json: @monitored_urls
  end

  # GET /monitored_urls/1
  def show
    render json: @monitored_url
  end

  # POST /monitored_urls
  def create
    @monitored_url = current_user.monitored_urls.build(monitored_url_params)

    if @monitored_url.save
      render json: @monitored_url, status: :created, location: @monitored_url
    else
      render json: @monitored_url.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /monitored_urls/1
  def update
    if @monitored_url.update(monitored_url_params)
      render json: @monitored_url
    else
      render json: @monitored_url.errors, status: :unprocessable_entity
    end
  end

  # DELETE /monitored_urls/1
  def destroy
    @monitored_url.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitored_url
      @monitored_url = current_user.monitored_urls.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def monitored_url_params
      params.expect(monitored_url: [ :url, :name, :check_interval ])
    end
end
