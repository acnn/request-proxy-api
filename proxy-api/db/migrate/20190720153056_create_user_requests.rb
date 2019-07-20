class CreateUserRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :user_requests do |t|
      t.string :client_id
      t.string :url
      t.string :headers
      t.string :http_method
      t.string :request_body

      t.timestamps
    end
  end
end
