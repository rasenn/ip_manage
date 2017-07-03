Rails.application.routes.draw do
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
    passwords:	     "users/passwords",
    registrations:   "users/registrations"
  }

end
