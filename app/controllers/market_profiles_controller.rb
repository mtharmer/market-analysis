# frozen_string_literal: true

class MarketProfilesController < ApplicationController
  before_action :set_market_profile, only: %i[show edit update destroy]

  # GET /market_profiles or /market_profiles.json
  def index
    @market_profiles = MarketProfile.all
  end

  # GET /market_profiles/1 or /market_profiles/1.json
  def show; end

  # GET /market_profiles/new
  def new
    @market_profile = MarketProfile.new
  end

  # GET /market_profiles/1/edit
  def edit; end

  # POST /market_profiles or /market_profiles.json
  def create
    @market_profile = MarketProfile.new(market_profile_params)

    respond_to do |format|
      if @market_profile.save
        format.html { redirect_to market_profile_url(@market_profile), notice: t('.success') }
        format.json { render :show, status: :created, location: @market_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @market_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market_profiles/1 or /market_profiles/1.json
  def update
    respond_to do |format|
      if @market_profile.update(market_profile_params)
        format.html { redirect_to market_profile_url(@market_profile), notice: t('.success') }
        format.json { render :show, status: :ok, location: @market_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @market_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market_profiles/1 or /market_profiles/1.json
  def destroy
    @market_profile.destroy

    respond_to do |format|
      format.html { redirect_to market_profiles_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_market_profile
    @market_profile = MarketProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def market_profile_params
    params.require(:market_profile).permit(:day, :instrument_id, :high, :low, :open, :close, :initial_balance_high,
                                           :initial_balance_low, :value_area_high, :value_area_low, :point_of_control,
                                           :day_type, :opening_type)
  end
end
