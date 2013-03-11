module Harvest
  class Invoice < BaseModel
    include HappyMapper
  
    api_path '/invoices'
  
    element :id, Integer
    element :amount, Float, :tag => 'amount'
    element :due_amount, Float, :tag => 'due-amount'
    element :due_at, Time, :tag => 'due-at'
    element :client_id, Float, :tag => 'client-id'
    element :currency, String
    element :issued_at, Time, :tag => 'issued-at'
    element :notes, String
    element :number, Integer
    element :client_key, String, :tag => 'client-key'
    element :state, String
    
    element :updated_at, Time, :tag => 'updated-at'
    element :created_at, Time, :tag => 'created-at'
    
  end
end