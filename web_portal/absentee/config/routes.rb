Rails.application.routes.draw do
	resources :klass
	resources :students
	resources :attendances
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
