# frozen_string_literal: true

class MerchantController < ApplicationController
  ## Summary expose the disbursements for a given merchant on a given week.
  #  If no merchant is provided return for all of them.
  #
  # @path [GET] /merchant/disbursements
  #
  #
  # @parameter (body)[integer](id)
  # @parameter (body, required)[date](week)
  #
  # @response 200 merchant_disbursements
  # @response 400 Invalid parameters
  # @response 404 merchant not found
  def disbursements
    # @todo - add authentication for user
    # @todo - add serialization for disbursements
    # @todo - add versioning in routes
    # @todo - add validations for week
    data = params.permit!.to_hash.deep_symbolize_keys!
    week = data[:week].to_datetime if data[:week].present?
    id = data[:id]

    if week.present?
      if id.present?
        merchant = Merchant.find_by(id: id)
        if merchant.present?
          render(json: merchant.disbursements.by_week(week), status: :ok) # scope by week
        else
          render(json: { errors: 'Merchant not found.' }, status: :not_found)
        end
      else
        render(json: Disbursement.by_week(week), status: :ok) # scope by week
      end
    else
      render(json: { errors: 'Invalid Parameters.' }, status: :bad_request)
    end
  end
end
