Rails.application.routes.draw do
  devise_for :users
  get 'schools/:school_id/sections/:section_id/todays_attendance' => 'attendances#todays_attendance' ,:as => 'todays_attendance'
  post 'schools/:school_id/sections/attendances' => 'attendances#bulk_attendance', :as => 'bulk_attendance_create'
  resources :students 
  resources :schools , only: [] do
    resources :sections do
      resources :attendances
    end
  end
  root 'schools#dashboard'
end
