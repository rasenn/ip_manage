Rails.application.routes.draw do
  root to: "ip_address#menu"

  get 'ip_address/menu', as: :user_root

  get 'ip_address/dispense'

  post 'ip_address/submit_dispense'

  get 'ip_address/delete'

  get 'ip_address/submit_delete'

  get 'subnet/menu', as: :admin_user_root

  get 'subnet/register'

  post 'subnet/submit_register'

  get 'subnet/delete'

  post 'subnet/submit_delete'

  get 'subnet/list'

  get 'subnet/ip_list'

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  # devise_for :admin_users
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, controllers: {
    sessions:      "admin_users/sessions",
    passwords:	   "admin_users/passwords",
    registrations: "admin_users/registrations"

  }

  devise_for :users, controllers: {
    sessions:	     "users/sessions",
#    passwords:	     "users/passwords",
#    registrations:   "users/registrations"
  }

end
