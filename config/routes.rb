Rails.application.routes.draw do
  root to: 'api/welcome#index', defaults: { format: :json }

  namespace 'api', defaults: { format: :json } do
    root to: 'welcome#index'
  end
end
