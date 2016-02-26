require 'dwolla_swagger'

class IavController < ApplicationController

  rescue_from DwollaSwagger::ClientError, :with => :rescue_dwolla_errors
  rescue_from DwollaSwagger::ServerError, :with => :rescue_dwolla_errors

  def rescue_dwolla_errors(exception)
    flash[:error] = "Uh oh! A Dwolla API error was encountered: \n#{exception.message}"
    redirect_to '/'
  end

  def landing
  end

  def create_customer
    reset_session

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
      params['customer'] = params['customer'].except('ipAddress') if params['customer']['ipAddress'].to_s.empty?

      # Grab the ID of our newly created customer
      session[:customer] = DwollaSwagger::CustomersApi.create({:body => params['customer']})

      redirect_to '/create_funding'
    else
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end
  end

  def create_funding
    if session[:customer].nil?
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    else
      @iav_request = "```http\nPOST /customers/#{session[:customer].split('/')[-1]}/iav-token"

      @iav_response = DwollaSwagger::CustomersApi
        .get_customer_iav_token(session[:customer])
        .to_hash

      @iav_token = @iav_response[:token]

      @iav_response = "```js\n#{JSON.pretty_generate(@iav_response)}"
    end
  end

  def finish_funding
    if params[:id].blank?
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end

    @funding_source = DwollaSwagger::FundingsourcesApi.id params[:id]
    @funding_source = "```js\n#{JSON.pretty_generate(@funding_source.to_hash)}"


    @transaction_model = {
      "_links" => {
        "destination" => {"href"=>"https://api-uat.dwolla.com/funding-sources/7e645801-78a7-465e-a999-45fb2b8d4ef2"},
        "source" => {"href"=>"https://api-uat.dwolla.com/funding-sources/#{params[:id]}"}
      },
      "amount" => {
        "currency"=>"USD",
        "value"=>"0.01"
      }
    }

    session[:tx_body] = @transaction_model

    @transaction_model = "```js\n#{JSON.pretty_generate(@transaction_model)}"
  end

  def finish_move_money
    unless session.has_key?(:tx_body)
      flash[:error] = 'Something went wrong. Try again?'
      redirect_to '/'
    end

    if params.has_key?(:flip)
      old_destination = session[:tx_body]['_links']['destination']
      session[:tx_body]['_links']['destination'] = session[:tx_body]['_links']['source']
      session[:tx_body]['_links']['source'] = old_destination
    end

    transaction = DwollaSwagger::TransfersApi.create({:body => session[:tx_body]})

    @transaction_response = DwollaSwagger::TransfersApi.by_id(transaction.split('/')[-1])
    @transaction_response = "```js\n#{JSON.pretty_generate(@transaction_response.to_hash)}"
  end
end
