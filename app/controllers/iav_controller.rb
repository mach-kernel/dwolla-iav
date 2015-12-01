require 'dwolla_swagger'

class IavController < ApplicationController
  def landing
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

      redirect_to '/penny/attach_fs'
    else
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end
  end

  def create_funding
    @iav_request = "```http\nPOST #{session[:customer].split('/')[-1]}/iav-token"

    @iav_response = DwollaSwagger::CustomersApi.get_customer_iav_token(session[:customer]).to_hash
    @iav_response = "```js\n#{JSON.pretty_generate(@iav_response)}"
  end

  def post_funding
  end
end
