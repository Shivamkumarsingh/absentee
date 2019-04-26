Rails.application.routes.draw do
  devise_for :users
  get 'schools/:school_id/sections/:section_id/todays_attendance' => 'attendances#todays_attendance' ,:as => 'todays_attendance'
  resources :students 
  resources :schools , only: [] do
    resources :sections do
      resources :attendances
    end
  end
  root 'schools#dashboard'
end
