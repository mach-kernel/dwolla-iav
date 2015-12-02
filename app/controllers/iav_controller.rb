require 'dwolla_swagger'
require 'secure_headers'

class IavController < ApplicationController

  rescue_from DwollaSwagger::ClientError, :with => :rescue_dwolla_errors
  rescue_from DwollaSwagger::ServerError, :with => :rescue_dwolla_errors

  def rescue_dwolla_errors(exception)
    reset_session
    flash[:error] = "Uh oh! A Dwolla API error was encountered: \n#{exception.message}"
  end


  def landing
    p action_name
    reset_session
  end

  def create_customer
    @customer_model = {
      :firstName => '',
      :lastName => '',
      :email => '',
      :ipAddress => ''
    }

    @customer_model = "```js\n#{JSON.pretty_generate(@customer_model)}"
  end

  def post_customer
    if params[:commit] == "Continue"
      # We can just re-use the hash that rails generates for this
      params['customer'] = params['customer'].except 'ipAddress' if params['customer']['ipAddress'].to_s.empty?

      # Grab the ID of our newly created customer
      session[:customer] = DwollaSwagger::CustomersApi.create({:body => params['customer']})

      redirect_to '/create_funding'
    else
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end
  end

  def create_funding
    if session[:customer].blank?
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end


    @iav_request = "```http\nPOST /customers/#{session[:customer].split('/')[-1]}/iav-token"

    @iav_response = DwollaSwagger::CustomersApi.get_customer_iav_token(session[:customer]).to_hash
    @iav_token = @iav_response[:token]

    @iav_response = "```js\n#{JSON.pretty_generate(@iav_response)}"
  end

  def post_funding
  end
end
