Rails.application.routes.draw do
  root to: 'api/welcome#index', defaults: { format: :json }

  namespace 'api', defaults: { format: :json } do
    root to: 'welcome#index'

    namespace 'zenvia' do
      scope 'wpp' do
        post 'message_received'
      end
    end
  end
end
