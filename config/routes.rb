Rails.application.routes.draw do
  root 'iav#landing'

  get 'create_customer', to: 'iav#create_customer'
  post 'create_customer', to: 'iav#post_customer'

  get 'create_funding', to: 'iav#create_funding'
  post 'create_funding', to: 'iav#post_funding'

  get 'finish_funding/:id', to: 'iav#finish_funding'
  get 'finish_move', to: 'iav#finish_move_money'

  get 'finish_move/:flip', to: 'iav#finish_move_money'
end
