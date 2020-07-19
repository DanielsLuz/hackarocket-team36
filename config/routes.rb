Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'api/welcome#index', defaults: { format: :json }

  namespace 'api', defaults: { format: :json } do
    root to: 'welcome#index'

    namespace "pagarme" do
      post "update"
    end

    namespace 'zenvia' do
      scope 'wpp' do
        post 'message_received'
        post 'order_received'
        patch 'update_delivery_address'
        post 'create_user'
        get 'check_address'
      end
    end
  end
end
